package com.heymath.jsfl.window
{
    import com.heymath.jsfl.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class LangBox extends MovieClip
    {
        private var mover:AHandle;
        private var resizer:AHandle;
        private var container:MovieClip;
        private var _x0:int = 50;
        private var _x1:int = 400;
        private var contents:LangContents;
        private var _h:int;
        private var _y0:int = 50;
        private var _y1:int = 250;
        private var _w:int;
        public static const WIDTH:int = 400;
        public static const HEIGHT:int = 250;

        public function LangBox(c:MovieClip)
        {
            this.resizer = new ResizeHandle();
            this.mover = new MoveHandle();
            this.contents = new LangContents();
            this.container = c;
            if (this.container.stage)
            {
                this.init();
            }
            else
            {
                this.container.addEventListener(Event.ADDED_TO_STAGE, this.init);
            }
            return;
        }

        private function init() : void
        {
            this.create();
            this.addListeners();
            this.resizer.x = this._x1;
            this.resizer.y = this._y1;
            this.mover.x = this._x0;
            this.mover.y = this._y0;
            return;
        }

        private function onResizerMoved(event:HandleEvent) : void
        {
            var p:Point = event._p;
            this._x1 = p.x;
            this._y1 = p.y;
            this.redraw();
            return;
        }

        private function addListeners() : void
        {
            this.resizer.addEventListener(HandleEvent.MOVED, this.onResizerMoved);
            this.mover.addEventListener(HandleEvent.MOVED, this.onMoverMoved);
            this.mover.addEventListener(HandleEvent.START, this.onMoverStart);
            return;
        }

        private function onMoverStart(event:HandleEvent) : void
        {
            this._w = this._x1 - this._x0;
            this._h = this._y1 - this._y0;
            return;
        }

        private function onMoverMoved(event:HandleEvent) : void
        {
            var p:Point = event._p;
            this._x0 = p.x;
            this._y0 = p.y;
            this._x1 = this._x0 + this._w;
            this._y1 = this._y0 + this._h;
            this.resizer.x = this._x1;
            this.resizer.y = this._y1;
            this.redraw();
            return;
        }

        private function create() : void
        {
            this.container.addChild(this.contents);
            this.container.addChild(this.mover);
            this.container.addChild(this.resizer);
            this.redraw();
            return;
        }

        private function redraw() : void
        {
            this.contents.resize(this._x0, this._y0, this._x1, this._y1);
            return;
        }

    }
}
