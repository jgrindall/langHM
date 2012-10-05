package com.heymath.jsfl.window
{
    import flash.display.*;

    public class MoveHandle extends AHandle
    {

        public function MoveHandle()
        {
            return;
        }

        override protected function draw() : void
        {
            var size:int = 16;
            var arrow:int = 2;
            var g:Graphics = this.graphics;
            g.lineStyle(1, 9474192, 1);
            g.beginFill(16777215, 1);
            var len:int = size / 2 - arrow;
            g.drawRect((-size) / 2, (-size) / 2, size, size);
            g.endFill();
            g.lineStyle(1, 9474192, 1);
            g.moveTo(0, (-size) / 2 + arrow);
            g.lineTo(0, size / 2 - arrow);
            g.moveTo((-size) / 2 + arrow, 0);
            g.lineTo(size / 2 - arrow, 0);
            g.moveTo(0, -len);
            g.lineTo(arrow, -len + arrow);
            g.moveTo(0, -len);
            g.lineTo(-arrow, -len + arrow);
            g.moveTo(len, 0);
            g.lineTo(len - arrow, arrow);
            g.moveTo(len, 0);
            g.lineTo(len - arrow, -arrow);
            g.moveTo(0, len);
            g.lineTo(arrow, len - arrow);
            g.moveTo(0, len);
            g.lineTo(-arrow, len - arrow);
            g.moveTo(-len, 0);
            g.lineTo(-len + arrow, -arrow);
            g.moveTo(-len, 0);
            g.lineTo(-len + arrow, arrow);
            return;
        }

    }
}
