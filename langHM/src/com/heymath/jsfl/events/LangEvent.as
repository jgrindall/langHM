package com.heymath.jsfl.events
{
    import flash.events.*;

    public class LangEvent extends Event
    {
        private var _data:Object;
        public static const LANG_CHANGED:String = "LangEvent: LANG_CHANGED";
        public static const ON_OFF_CHANGED:String = "LangEvent: ON_OFF_CHANGED";
        public static const DIRTY_CHANGED:String = "LangEvent: DIRTY_CHANGED";
        public static const FONT_SIZE_CHANGED:String = "LangEvent: FONT_SIZE_CHANGED";
        public static const EDIT_STATE_CHANGE:String = "LangEvent: EDIT_STATE_CHANGE";
        public static const ALPHA_CHANGED:String = "LangEvent: ALPHA_CHANGED";
        public static const ROLL_OVER:String = "LangEvent: ROLL_OVER";
        public static const SAVE_NEW_COMPLETE:String = "LangEvent: SAVE_XML_COMPLETE";
        public static const CLICK:String = "LangEvent: CLICK";
        public static const CONTENT_LOADED:String = "LangEvent: CONTENT_LOADED";
        public static const ROLL_OUT:String = "LangEvent: ROLL_OUT";
        public static const TRANS_SAVED:String = "LangEvent: TRANS_SAVED";
        public static const DISPLAY_CHANGED:String = "LangEvent: DISPLAY_CHANGED";
        public static const DEBUG:String = "LangEvent: DEBUG";
        public static const SAVE_NEW:String = "LangEvent: SAVE_XML";

        public function LangEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, data:Object = null)
        {
            super(type, bubbles, cancelable);
            this._data = data;
            return;
        }

        public function get data() : Object
        {
            return this._data;
        }

    }
}
