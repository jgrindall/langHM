package com.heymath.jsfl.window
{
    import com.heymath.jsfl.events.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class AHandle extends Sprite
    {

        public function AHandle()
        {
            this.draw();
            this.init();
            this.mouseEnabled = true;
            this.useHandCursor = true;
            return;
        }

        private function init() : void
        {
            this.addListeners();
            return;
        }

        protected function draw() : void
        {
            return;
        }

        private function onMDown(event:MouseEvent) : void
        {
            this.startDrag(false);
            this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMMove);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMUp);
            this.dispatchEvent(new HandleEvent(HandleEvent.START, true, true, new Point(this.x, this.y)));
            return;
        }

        private function onMUp(event:MouseEvent) : void
        {
            this.stopDrag();
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMMove);
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMUp);
            this.dispatchEvent(new HandleEvent(HandleEvent.END, true, true, new Point(this.x, this.y)));
            return;
        }

        private function addListeners() : void
        {
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMDown);
            return;
        }

        private function onMMove(event:MouseEvent) : void
        {
            this.dispatchEvent(new HandleEvent(HandleEvent.MOVED, true, true, new Point(this.x, this.y)));
            return;
        }

    }
}
