package com.heymath.jsfl.window
{
    import flash.display.*;

    public class ResizeHandle extends AHandle
    {

        public function ResizeHandle()
        {
            return;
        }

        override protected function draw() : void
        {
            var g:Graphics = this.graphics;
            var size:int = 16;
            var arrow:int = 4;
            var len:int = size / 2 - arrow;
            g.lineStyle(1, 9474192, 1);
            g.beginFill(16777215, 1);
            g.drawRect((-size) / 2, (-size) / 2, size, size);
            g.endFill();
            g.lineStyle(1, 9474192, 1);
            g.moveTo(-len, -len);
            g.lineTo(len, len);
            g.moveTo(-len, -len);
            g.lineTo(-len + arrow, -len);
            g.moveTo(-len, -len);
            g.lineTo(-len, -len + arrow);
            g.moveTo(len, len);
            g.lineTo(len - arrow, len);
            g.moveTo(len, len);
            g.lineTo(len, len - arrow);
            return;
        }

    }
}
