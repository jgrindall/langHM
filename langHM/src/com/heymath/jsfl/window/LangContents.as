package com.heymath.jsfl.window
{
    import com.bit101.components.*;
    import com.heymath.jsfl.events.*;
    import com.heymath.jsfl.model.*;
    import com.heymath.jsfl.trans.*;
    import com.heymath.jsfl.utils.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class LangContents extends MovieClip
    {
        private var p1:Point;
        private var p0:Point;
        private var sizeSlider:HSlider;
        private var cancelButton:PushButton;
        private var _selectedText:StaticText;
        private var saveButton:PushButton;
        private var _text:TextField;
        private var onOffBox:CheckBox;
        private var editButton:PushButton;
        private var alphaSlider:HSlider;
        private var radios:Array;
        private var displayBox:CheckBox;
        public static const PADDING:int = 5;
        public static const LEFT:int = 110;

        public function LangContents()
        {
            this.p0 = new Point(10, 10);
            this.p1 = new Point(350, 70);
            this.radios = [];
            EventSingleton.getInstance().addEventListener(LangEvent.EDIT_STATE_CHANGE, this.changeState);
            EventSingleton.getInstance().addEventListener(LangEvent.DISPLAY_CHANGED, this.changeState);
            EventSingleton.getInstance().addEventListener(LangEvent.DIRTY_CHANGED, this.changeState);
            EventSingleton.getInstance().addEventListener(LangEvent.ROLL_OVER, this.rollOver);
            EventSingleton.getInstance().addEventListener(LangEvent.ROLL_OUT, this.rollOut);
            EventSingleton.getInstance().addEventListener(LangEvent.CLICK, this.click);
            this.create();
            this.changeState(null);
            this.filters = [new DropShadowFilter(5, 45, 0, 0.5)];
            return;
        }

        private function doTranslate(m:MovieClip) : void
        {
            LangUtils.addTranslatedText(this._text, m);
            return;
        }

        private function drawSlider() : void
        {
            this.alphaSlider.x = this.p0.x + PADDING;
            this.alphaSlider.y = this.p1.y - PADDING - 30;
            this.sizeSlider.x = this.p0.x + PADDING;
            this.sizeSlider.y = this.p1.y - PADDING - 50;
            return;
        }

        public function click(event:LangEvent) : void
        {
            var m:MovieClip = event.data.movieclip as MovieClip;
            if (LangModelSingleton.getInstance().isNotEditing())
            {
                this._selectedText = LangUtils.getOrigTextField(m);
                this.doTranslate(m);
                LangModelSingleton.getInstance().setSelected();
            }
            else
            {
                this._selectedText = null;
                this._text.text = "";
                LangModelSingleton.getInstance().setNotEditing();
            }
            return;
        }

        private function onBtnClick(event:Event) : void
        {
            if (LangModelSingleton.getInstance().isNotEditing())
            {
                LangModelSingleton.getInstance().setSelected();
            }
            else if (LangModelSingleton.getInstance().isSelected())
            {
                LangModelSingleton.getInstance().setEditing();
            }
            else if (LangModelSingleton.getInstance().isEditing())
            {
                LangModelSingleton.getInstance().setNotEditing();
                this.saveEdit();
            }
            return;
        }

        private function changeState(event:LangEvent) : void
        {
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG,true,true,{"message":"change state..."}));
            if (LangModelSingleton.getInstance().isNotEditing())
            {
                this.editButton.label = "Edit";
                this.editButton.enabled = false;
                this.cancelButton.enabled = false;
                this.cancelButton.visible = false;
                this._text.selectable = false;
            }
            else if (LangModelSingleton.getInstance().isEditing())
            {
                this.editButton.label = "Ok";
                this.editButton.enabled = true;
                this.cancelButton.enabled = true;
                this.cancelButton.visible = true;
                this._text.selectable = true;
            }
            else if (LangModelSingleton.getInstance().isSelected())
            {
                this.editButton.label = "Edit";
                this.editButton.enabled = true;
                this.cancelButton.enabled = false;
                this.cancelButton.visible = false;
                this._text.selectable = false;
            }
           
            this.alphaSlider.enabled = LangModelSingleton.getInstance().getDisplay();
            this.sizeSlider.enabled = LangModelSingleton.getInstance().getDisplay();
            this.saveButton.enabled = TransSingleton.getInstance().getDirty();
            
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG,true,true,{"message":"save state "+this.saveButton.enabled}));
            
            this.drawBg();
            return;
        }

        public function rollOut(event:LangEvent) : void
        {
            var m:MovieClip = event.data.movieclip as MovieClip;
            if (LangModelSingleton.getInstance().isNotEditing())
            {
                this.setText("");
            }
            return;
        }
		
        private function onSizeChanged(event:Event) : void
        {
            LangModelSingleton.getInstance().setFontSize(this.sizeSlider.value);
            return;
        }

        private function onCancelClick(event:Event) : void
        {
            LangModelSingleton.getInstance().setSelected();
            return;
        }

        private function onCheckDisplay(event:Event) : void
        {
            LangModelSingleton.getInstance().setDisplay(this.displayBox.selected);
            return;
        }

        private function createButton() : void
        {
            var r:RadioButton = null;
            this.editButton = new PushButton(this, 0, 0, "Edit", this.onBtnClick);
            this.editButton.enabled = false;
            this.cancelButton = new PushButton(this, 0, 0, "Cancel", this.onCancelClick);
            this.cancelButton.enabled = false;
            this.saveButton = new PushButton(this, 0, 0, "Save", this.onSaveClick);
            this.saveButton.enabled = false;
            var langs:Array = TransSingleton.getInstance().getLanguages();
            var i:int = 0;
            while (i <= (langs.length - 1))
            {
                r = new RadioButton(this, 100, 100, langs[i], i == 0, this.onRadioClick);
                r.tag = i;
                this.radios.push(r);
                i++;
            }
            return;
        }

        private function drawText() : void
        {
            var gap:int = 20;
            this._text.x = this.p0.x + LangContents.PADDING + LEFT;
            this._text.y = this.p0.y + LangContents.PADDING + gap;
            this._text.width = this.p1.x - this.p0.x - 2 * LangContents.PADDING - LEFT;
            this._text.height = this.p1.y - this.p0.y - 2 * LangContents.PADDING - gap;
            return;
        }

        private function createText() : void
        {
            this._text = new TextField();
            this._text.border = true;
            this._text.type = TextFieldType.INPUT;
            this._text.multiline = true;
            this._text.wordWrap = true;
            var tf:TextFormat = new TextFormat();
            tf.font = "Arial";
            tf.color = 0;
            this._text.borderColor = 9474192;
            tf.size = 32;
            this._text.setTextFormat(tf);
            this.addChild(this._text);
            return;
        }

        private function drawBg() : void
        {
            var g:Graphics = this.graphics;
            g.clear();
            if (LangModelSingleton.getInstance().isEditing() && this.stage)
            {
                g.lineStyle(0, 0, 0);
                g.beginFill(0, 0.2);
                g.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
                g.endFill();
            }
            g.lineStyle(1, 9474192, 1);
            g.beginFill(16777215, 1);
            g.drawRect(this.p0.x, this.p0.y, this.p1.x - this.p0.x, this.p1.y - this.p0.y);
            g.endFill();
            return;
        }

        private function onRadioClick(event:Event) : void
        {
            var r:RadioButton = null;
            var lang:String = null;
            var index:int = -1;
            var i:int = 0;
            while (i <= (this.radios.length - 1))
            {
                
                r = this.radios[i] as RadioButton;
                if (r.selected)
                {
                    index = i;
                }
                i++;
            }
            if (index != -1)
            {
                lang = TransSingleton.getInstance().getLanguages()[index];
                LangModelSingleton.getInstance().setLang(lang);
            }
            return;
        }

        private function onCheckOn(event:Event) : void
        {
            LangModelSingleton.getInstance().setOn(this.onOffBox.selected);
            return;
        }

        private function drawCheck() : void
        {
            this.displayBox.x = this.p0.x + PADDING;
            this.displayBox.y = this.p1.y - PADDING - 10;
            this.onOffBox.x = this.p0.x + PADDING;
            this.onOffBox.y = this.p0.y + PADDING + 20;
            return;
        }

        private function createCheck() : void
        {
            this.displayBox = new CheckBox(this, 0, 0, "display", this.onCheckDisplay);
            this.onOffBox = new CheckBox(this, 0, 0, "on", this.onCheckOn);
            this.onOffBox.selected = LangModelSingleton.getInstance().getOn();
            return;
        }

        private function saveEdit() : void
        {
            trace("save Edit");
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG,true,true,{"message":"saving..."}));
            var s:String = this._selectedText.text;
            var r:String = this._text.text;
            TransSingleton.getInstance().add(s, r);
            return;
        }

        public function setText(s:String) : void
        {
            this._text.text = s;
            return;
        }

        public function rollOver(event:LangEvent) : void
        {
            var m:MovieClip = event.data.movieclip as MovieClip;
            if (LangModelSingleton.getInstance().isNotEditing())
            {
                this.doTranslate(m);
            }
            return;
        }

        public function resize(x0:int, y0:int, x1:int, y1:int) : void
        {
            this.p0 = new Point(x0, y0);
            this.p1 = new Point(x1, y1);
            this.drawBg();
            this.drawText();
            this.drawButtons();
            this.drawCheck();
            this.drawSlider();
            return;
        }

        private function onAlphaChanged(event:Event) : void
        {
            LangModelSingleton.getInstance().setAlpha(this.alphaSlider.value);
            return;
        }

        private function onSaveClick(event:Event) : void
        {
            var newArray:Array = TransSingleton.getInstance().getNew();
            var obj:Object = {newData:newArray};
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.SAVE_NEW, true, true, obj));
            return;
        }

        private function create() : void
        {
            this.createText();
            this.createButton();
            this.createCheck();
            this.createSlider();
            return;
        }

        private function createSlider() : void
        {
            this.alphaSlider = new HSlider(this, 0, 0, this.onAlphaChanged);
            this.alphaSlider.value = LangModelSingleton.getInstance().getAlpha();
            this.alphaSlider.enabled = LangModelSingleton.getInstance().getDisplay();
            this.sizeSlider = new HSlider(this, 0, 0, this.onSizeChanged);
            this.sizeSlider.value = LangModelSingleton.getInstance().getFontSize();
            this.sizeSlider.enabled = LangModelSingleton.getInstance().getDisplay();
            return;
        }

        private function drawButtons() : void
        {
            var r:RadioButton = null;
            this.editButton.x = this.p1.x - this.editButton.width - 10;
            this.editButton.y = this.p1.y - this.editButton.height - 10;
            this.cancelButton.x = this.editButton.x - this.cancelButton.width - 2;
            this.cancelButton.y = this.editButton.y;
            var xpos:* = this.p0.x + PADDING;
            var ypos:* = this.p0.y + PADDING + 60;
            var i:int = 0;
            while (i <= (this.radios.length - 1))
            {
                r = this.radios[i] as RadioButton;
                r.x = xpos;
                r.y = ypos;
                ypos = ypos + (r.height + 3);
                i++;
            }
            this.saveButton.x = this.p1.x - this.saveButton.width - PADDING;
            this.saveButton.y = this.p0.y + 2;
            return;
        }

    }
}
