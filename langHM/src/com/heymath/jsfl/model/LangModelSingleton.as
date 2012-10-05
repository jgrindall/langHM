package com.heymath.jsfl.model
{
    import com.heymath.jsfl.events.*;
    
    import com.heymath.jsfl.trans.*;	
	
    public class LangModelSingleton extends Object
    {
        
        private var _display:Boolean = false;
        private var _on:Boolean = true;
        private var _lang:String = "";
        private var _state:int = 0;
        private var _fontSize:Number = 25;
        private var _alpha:int = 100;
        private static var _instance:LangModelSingleton = null;
        private static var _allow:Boolean = false;
        public static const SELECTED:int = 1;
        public static const NOT_EDITING:int = 0;
        public static const EDITING:int = 2;

        public function LangModelSingleton()
        {
            if (!_allow)
            {
                throw new Error("Use getInstance() method instead");
            }
            return;
        }

        public function setDisplay(tf:Boolean) : void
        {
            this._display = tf;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DISPLAY_CHANGED, true, true));
            return;
        }

        public function setNotEditing() : void
        {
            this._state = LangModelSingleton.NOT_EDITING;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.EDIT_STATE_CHANGE, true, true));
            return;
        }

        public function getDisplay() : Boolean
        {
            return this._display;
        }

        public function isEditing() : Boolean
        {
            return this._state == LangModelSingleton.EDITING;
        }

        public function setState(s:int) : void
        {
            this._state = s;
            return;
        }

        public function getOn() : Boolean
        {
            return this._on;
        }

        public function getState() : int
        {
            return this._state;
        }

        public function setAlpha(a:int) : void
        {
            this._alpha = a;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.ALPHA_CHANGED, true, true));
            return;
        }

        public function setSelected() : void
        {
            this._state = LangModelSingleton.SELECTED;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.EDIT_STATE_CHANGE, true, true));
            return;
        }

        public function setOn(on:Boolean) : void
        {
            this._on = on;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.ON_OFF_CHANGED, true, true));
            return;
        }

        public function isSelected() : Boolean
        {
            return this._state == LangModelSingleton.SELECTED;
        }

        public function getFontSize() : int
        {
            return this._fontSize;
        }

        public function isNotEditing() : Boolean
        {
            return this._state == LangModelSingleton.NOT_EDITING;
        }

        public function getAlpha() : int
        {
            return this._alpha;
        }

        public function getLang() : String
        {
            return this._lang;
        }

        public function setEditing() : void
        {
            this._state = LangModelSingleton.EDITING;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.EDIT_STATE_CHANGE, true, true));
            return;
        }

        public function setLang(lang:String) : void
        {
            this._lang = lang;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.LANG_CHANGED, true, true));
            return;
        }

        public function setFontSize(s:int) : void
        {
            this._fontSize = s;
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.FONT_SIZE_CHANGED, true, true));
            return;
        }

        public static function getInstance() : LangModelSingleton
        {
            if (_instance == null)
            {
                _allow = true;
                _instance = new LangModelSingleton;
                _allow = false;
            }
            return _instance;
        }

    }
}
