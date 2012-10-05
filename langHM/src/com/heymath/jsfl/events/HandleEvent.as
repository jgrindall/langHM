package com.heymath.jsfl.events
{
    import flash.events.*;
    import flash.geom.*;

    public class HandleEvent extends Event
    {
        public var _p:Point;
        public static const START:String = "HandleEvent: START";
        public static const MOVED:String = "HandleEvent: MOVED";
        public static const END:String = "HandleEvent: END";

        public function HandleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, p:Point = null)
        {
            super(type, bubbles, cancelable);
            this._p = p;
            return;
        }

    }
}
