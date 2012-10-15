package Heymath{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	class ScrollMovie {
		var mov:MovieClip;
		var rectange:Rectangle;
		var currentClicked:MovieClip;
		var scrollIntPx:Number;
		var initSp:Number = 700;
		var initSpLen:Number = 10;
		public var scLen:Number;
		var lenchk:Number;
		var adjust:Number;
		var chkval:Number;
		var currentPos:Number;
		var initScale:Number;
		var incmcount:Number = 0;
		public function ScrollMovie(mc) {
			mov = mc;
			adjust = 6;
			currentClicked = mov.scrollBar;
			scrollIntPx =currentClicked.x;
			currentClicked.x = 350;
			rectange = new Rectangle(initSp,currentClicked.y,initSpLen,0);
			//currentClicked.x = 700;
			currentClicked.scaleX = 16;
			initScale = currentClicked.scaleX;
			currentClicked.buttonMode = true;
			currentClicked.useHandCursor = true;
			currentClicked.addEventListener(MouseEvent.MOUSE_DOWN,startDragMov);
			currentClicked.addEventListener(MouseEvent.MOUSE_UP,stopDragMov);
			mov.length;
			scLen = 730;
			lenchk = 0;
		}
		private function startDragMov(evt:Event) {
			var mc = currentClicked;
			mc.startDrag(false,rectange);
			mc.stage.addEventListener(MouseEvent.MOUSE_UP,stopDragMov);
			mov.addEventListener(Event.ENTER_FRAME,scroll_fn);
		}
		private function stopDragMov(evt:Event) {
			var mc = currentClicked;
			mc.stopDrag();
			mc.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragMov);
			mov.removeEventListener(Event.ENTER_FRAME,scroll_fn);
		}
		private function scroll_fn(evt:Event) {
			//var chkval = (7/700)*initSpLen;
			var chkval = incmcount
			//mov.scale_mc.x =((-currentClicked.x*chkval)/initSpLen)*(lenchk);
			mov.scale_mc.x =currentPos+(initSpLen-(currentClicked.x-initSp))*chkval;
		}
		public function updateScrollPosition() {
			incmcount+=1;
			lenchk=-(mov.scale_mc.x/5);
			currentClicked.scaleX = initScale/incmcount;
			initSp=Number(currentClicked.width)*1.1;
			initSpLen=730-initSp;
			rectange = new Rectangle(initSp,currentClicked.y,initSpLen,0);
			adjust -=2 ;
			currentPos = mov.scale_mc.x;
			currentClicked.x = initSpLen+initSp;
		}
		public function resetScrollPosition() {
			currentClicked.x = 730;
			lenchk = 0 ;
			initSpLen = 10;
			initSp= 730;
			initScale=currentClicked.scaleX = 16;
			currentClicked.mouseEnabled = false;
			incmcount = 1;
			rectange = new Rectangle(initSp,currentClicked.y,initSpLen,0);
			//rectange = new Rectangle(scrollIntPx,currentClicked.y,0,0);
		}
		public function activateScroll() {
			currentClicked.mouseEnabled = true;
		}
	}
}
//