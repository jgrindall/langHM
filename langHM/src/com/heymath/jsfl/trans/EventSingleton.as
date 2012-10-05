package com.heymath.jsfl.trans
{
    import flash.events.*;

    public class EventSingleton extends EventDispatcher
    {
        private static var _allow:Boolean = false;
        private static var _instance:EventSingleton = null;

        public function EventSingleton()
        {
            if (!_allow)
            {
                throw new Error("Use getInstance() method instead");
            }
            return;
        }

        public static function getInstance() : EventSingleton
        {
            if (_instance == null)
            {
                _allow = true;
                _instance = new EventSingleton;
                _allow = false;
            }
            return _instance;
        }

    }
}
