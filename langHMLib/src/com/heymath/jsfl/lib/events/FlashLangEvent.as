package com.heymath.jsfl.lib.events
{
    import flash.events.*;

    public class FlashLangEvent extends Event
    {
        private var _data:Object;
        public static const PROCESS:String = "FlashLangEvent: PROCESS";

        public function FlashLangEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, data:Object = null)
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
