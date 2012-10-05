package com.heymath.jsfl.components
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class MessageBox extends MovieClip
    {
        private var _label:Label;
        private var _timer:Timer;
        private var _progress:ProgressBar;
        public static const WIDTH:int = 400;
        public static const HEIGHT:int = 250;

        public function MessageBox()
        {
            this._timer = new Timer(200, 0);
            this._label = new Label(this, 0, 0, "Please wait...");
            this._progress = new ProgressBar(this, 0, 0);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            if (stage)
            {
                this.build(null);
            }
            else
            {
                this.addEventListener(Event.ADDED_TO_STAGE, this.build);
            }
            this.show(false);
            return;
        }

        public function show(vis:Boolean) : void
        {
            this.visible = vis;
            if (vis)
            {
                this._progress.value = 0;
                this._timer.start();
            }
            else
            {
                this._timer.stop();
            }
            return;
        }

        private function onTimer(event:TimerEvent) : void
        {
            var p:Number = this._progress.value;
            this._progress.value = Math.min(1, p + 0.04);
            return;
        }

        public function build(event:Event) : void
        {
            var x:int = 0;
            var g:Graphics = this.graphics;
            g.clear();
            g.lineStyle(0, 0, 0);
            g.beginFill(0, 0.2);
            g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            g.endFill();
            g.lineStyle(1, 9474192, 1);
            g.beginFill(16777215, 1);
            x = (stage.stageWidth - WIDTH) / 2;
            var y:int = (stage.stageHeight - HEIGHT) / 2;
            g.drawRect(x, y, WIDTH, HEIGHT);
            g.endFill();
            this._progress.x = x + (WIDTH - this._progress.width) / 2;
            this._progress.y = y + (HEIGHT - this._progress.height) / 2;
            this._label.x = x + (WIDTH - this._label.width) / 2;
            this._label.y = this._progress.y - 35;
            return;
        }

    }
}
