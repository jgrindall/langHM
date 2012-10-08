package com.heymath.jsfl.components
{
    import com.heymath.jsfl.float.*;
    import com.heymath.jsfl.utils.*;
    
    import fl.text.TLFTextField;
    
    import flash.display.*;
    import flash.geom.Rectangle;
    import flash.text.*;
    import flash.text.engine.FontLookup;
    
    import flashx.textLayout.edit.EditManager;
    import flashx.textLayout.edit.ISelectionManager;
    import flashx.textLayout.edit.SelectionState;
    import flashx.textLayout.formats.Direction;
    import flashx.textLayout.formats.TextLayoutFormat;
	
	
    public class TextComponent extends MovieClip
    {
        private var _parent:MovieClip;
		private var _text:TLFTextField;
		
        public function TextComponent()
        {
        	_text = new TLFTextField();
			addChild(_text);
			_text.text = "abcdefgh";
			_text.wordWrap = true;
			_text.border = true;
			_text.embedFonts = true;  
        }
		public function set text(s:String):void{
			_text.text = s;	
		}
		public function setSize(r:Rectangle):void{
			_text.x = r.x;
			_text.y = r.y;
			_text.width = r.width;
			_text.height = r.height;
		}
        public function getParent() : MovieClip
        {
            return this._parent;
        }
        public function sizeFont() : void
        {
           
        }        
        public function setParent(p:MovieClip) : void
        {
            this._parent = p;
            return;
        }
        private function format(rtl:Boolean, fontName:String):void{
        	var tFormat:TextLayoutFormat = new TextLayoutFormat();
			tFormat.fontFamily = fontName;
			tFormat.color   = 0x000000;
			tFormat.fontLookup = FontLookup.EMBEDDED_CFF;
			tFormat.fontSize    = 12;
			if(rtl){
				_text.direction = Direction.RTL;
			}
			else{
				_text.direction = Direction.LTR;
			}
			_text.textFlow.invalidateAllFormats();
			_text.textFlow.hostFormat = tFormat;
			var prevManager:ISelectionManager = _text.textFlow.interactionManager;
			var editManager:EditManager = new EditManager();
			var sel:SelectionState = new SelectionState(_text.textFlow, 0, _text.text.length);
			_text.textFlow.interactionManager = editManager;
			editManager.applyLeafFormat(tFormat, sel);
			_text.textFlow.flowComposer.updateAllControllers();
        }
        public function setText(s:String, rtl:Boolean, fontName:String) : void
        {
            _text.text = s;
            format(rtl,fontName);
            return;
        }
    }
}
