package {
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	public class DrawArc {
		var posx:Number;
		var posy:Number;
		var speed:Number;
		var stpos:Number;
		var k=0;
		var arc:Shape=new Shape();
		var radius=20;
		var inc:Number;
		var mov:MovieClip;
		var omega:Number;
		var drawTime:Timer

		public function DrawArc() {
			drawTime= new Timer(15);
			drawTime.addEventListener(TimerEvent.TIMER,drawShape);
		}
		public function initArc(stpx,stpy) {
			posx=stpx;
			posy=stpy;
			arc.graphics.clear();
			arc.graphics.lineStyle(1,0xFF00FF,1);
			arc.graphics.moveTo(posx,posy);
		}
		public function drawArc(mc,rad,spd) {
			mov=mc;
			//mov.addEventListener(Event.ENTER_FRAME,drawShape);
			drawTime.start();
			radius=rad;
			speed=spd;
			stpos=posx;
			k=16;
			inc=0;
			omega=.1;
		}
		public function drawShape(evt:TimerEvent) {
			if (radius * Math.cos(k * omega) < 0) {
				arc.graphics.lineTo(stpos + inc * 2,posy + radius * Math.cos(k * omega));
				inc+= speed;
				stpos=posx + inc;
				k+= 1;
			} else {
				k+= .55;
			}
			mov.addChild(arc);
		}
		public function stopDraw() {
			//mov.removeEventListener(Event.ENTER_FRAME,drawShape);
			drawTime.stop();
		}
		public function resetArc() {
			arc.graphics.clear();
		}
	}
}