package com.heymath.jsfl.float
{
    import com.heymath.jsfl.components.*;
    import com.heymath.jsfl.events.*;
    import com.heymath.jsfl.model.*;
    import com.heymath.jsfl.trans.*;
    import com.heymath.jsfl.utils.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.geom.Rectangle;
    

    public class LangFloat extends Object
    {
        private var _mc:Array;
        public static const MIN_FONT_SIZE:int = 8;
        public static const MAX_FONT_SIZE:int = 32;

        public function LangFloat()
        {
            this._mc = [];
            EventSingleton.getInstance().addEventListener(LangEvent.LANG_CHANGED, this.langChanged);
            EventSingleton.getInstance().addEventListener(LangEvent.TRANS_SAVED, this.transSaved);
            EventSingleton.getInstance().addEventListener(LangEvent.DISPLAY_CHANGED, this.onDisplayChange);
            return;
        }

        private function remake() : void
        {
            var m:MovieClip = null;
            var float:TextComponent = null;
            var s:String = null;
            var i:int = 0;
            while (i <= (this._mc.length - 1))
            {
                
                m = this._mc[i] as MovieClip;
                float = m.float as TextComponent;
                s = TransSingleton.getInstance().translate(LangUtils.getText(m));
                float.setText(s, Languages.getRightToLeft(LangModelSingleton.getInstance().getLang()), Languages.getFontName(LangModelSingleton.getInstance().getLang()));
                i++;
            }
            return;
        }

        public function register(m:MovieClip, data:Object) : void
        {
            this._mc.push(m);
            var float:TextComponent = new TextComponent();
            float.setSize(new Rectangle(data.bounds.x, data.bounds.y, data.bounds.width, data.bounds.height));
            var s:String = TransSingleton.getInstance().translate(LangUtils.getText(m));
            float.setText(s, Languages.getRightToLeft(LangModelSingleton.getInstance().getLang()), Languages.getFontName(LangModelSingleton.getInstance().getLang()));
            var vis:Boolean = LangModelSingleton.getInstance().getDisplay();
            LangUtils.getOrigTextField(m).visible = !vis;
            float.visible = vis;
            m.addChild(float);
            m.float = float;
            float.setParent(m);
            //text.addEventListener(MouseEvent.CLICK, this.onClick);
            return;
        }

        public function remove(m:MovieClip) : void
        {
            var i:int;
            try
            {
                i = this._mc.indexOf(m);
                m.removeChild(m.float);
                this._mc.splice(i, 1);
            }
            catch (e:Error)
            {
                trace("remove error " + e);
            }
            return;
        }

        private function langChanged(event:LangEvent) : void
        {
            this.remake();
            return;
        }

        private function onClick(event:MouseEvent) : void
        {
            var text:TextComponent = event.target as TextComponent;
            text.getParent().dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, true));
            return;
        }

        public function setVisible(vis:Boolean) : void
        {
            var m:MovieClip = null;
            var i:int = 0;
            while (i <= (this._mc.length - 1))
            {
                
                m = this._mc[i] as MovieClip;
                LangUtils.getOrigTextField(m).visible = !vis;
                (m.float as TextComponent).visible = vis;
                i++;
            }
            return;
        }

        public function sizeFont() : void
        {
            var m:MovieClip = null;
            var text:TextComponent = null;
            var i:int = 0;
            while (i <= (this._mc.length - 1))
            {
                
                m = this._mc[i] as MovieClip;
                text = m.float as TextComponent;
                text.sizeFont();
                i++;
            }
            return;
        }

        private function onDisplayChange(event:LangEvent) : void
        {
            var vis:Boolean = LangModelSingleton.getInstance().getDisplay();
            this.setVisible(vis);
            return;
        }

        public function setAlpha(a:Number) : void
        {
            return;
        }

        private function transSaved(event:LangEvent) : void
        {
            this.remake();
            return;
        }

        public static function getFontSize() : int
        {
            var s:int = LangModelSingleton.getInstance().getFontSize();
            return Math.round(MIN_FONT_SIZE + s / 100 * (MAX_FONT_SIZE - MIN_FONT_SIZE));
        }

    }
}
