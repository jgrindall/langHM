package com.heymath.jsfl.components
{
    import com.heymath.jsfl.float.*;
    import com.heymath.jsfl.utils.*;
    
    import flash.display.*;
    import flash.events.MouseEvent;
    import flash.text.*;
	
	
	
    public class TextComponent extends TextField
    {
        private var _parent:MovieClip;

        public function TextComponent()
        {
            
            this.background = false;
            this.border = false;
            this.backgroundColor = 16777215;
            this.type = TextFieldType.DYNAMIC;
            this.selectable = false;
            this.embedFonts = true;
            var tf:TextFormat = FontManager.getDefaultTextFormat(LangFloat.getFontSize());
            this.defaultTextFormat = tf;
            this.setTextFormat(tf);
            this.addEventListener(MouseEvent.CLICK, onClick);
            return;
        }
		
		private function onClick(e:MouseEvent):void{
			this._parent.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,true));
		}
		
        public function getParent() : MovieClip
        {
            return this._parent;
        }

        public function sizeFont() : void
        {
            var tf:TextFormat = this.getTextFormat();
            tf.size = LangFloat.getFontSize();
            this.defaultTextFormat = tf;
            this.setTextFormat(tf);
            return;
        }

        public function setSize(x:int, y:int, w:int, h:int) : void
        {
            this.x = x;
            this.y = y;
            this.width = w;
            this.height = h;
            return;
        }
        public function setParent(p:MovieClip) : void
        {
            this._parent = p;
            return;
        }
		private function getLocal(s:String, rtl:Boolean):String{
			return s;
		}
        public function setText(s:String, rtl:Boolean = false) : void
        {
            this.text = getLocal(s, rtl);
            return;
        }

    }
}
