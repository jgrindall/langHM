package {
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	class ScrollMovie {
		private var mov:MovieClip;
		private var rectange:Rectangle;
		private var currentClicked:MovieClip;
		private var currentClicked1:MovieClip;
		private var scrollIntPx:Number;
		private var initSp:Number = 700;
		private var initSpLen:Number = 10;
		public var scLen:Number;
		private var lenchk:Number;
		private var adjust:Number;
		private var chkval:Number;
		private var currentPos:Number;
		private var initScale:Number;
		private var incmcount:Number = 0;
		private var movFlg = 0;
		private var FarEndScrollX = 730;
		private var ScrollAreaWidth = 700;
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
			mov.scroll_l.addEventListener(MouseEvent.MOUSE_DOWN,startDragLeft);
			mov.scroll_r.addEventListener(MouseEvent.MOUSE_DOWN,startDragRight);
			mov.scroll_l.addEventListener(MouseEvent.MOUSE_UP,stopDragLeft);
			mov.scroll_r.addEventListener(MouseEvent.MOUSE_UP,stopDragRight);
			mov.scroll_l.buttonMode = true;
			mov.scroll_r.buttonMode = true;
			mov.scroll_l.useHandCursor = true;
			mov.scroll_r.useHandCursor = true;
			mov.length;
			scLen = FarEndScrollX;
			lenchk = 0;
		}
		private function startDragMov(evt:Event) {
			var mc = currentClicked;
			mc.startDrag(false,rectange);
			mc.stage.addEventListener(MouseEvent.MOUSE_UP,stopDragMov);
			mov.addEventListener(Event.ENTER_FRAME,scroll_fn);
			movFlg = 0;
		}
		private function stopDragMov(evt:Event) {
			var mc = currentClicked;
			mc.stopDrag();
			mc.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragMov);
			mov.removeEventListener(Event.ENTER_FRAME,scroll_fn);
		}
		private function scroll_fn(evt:Event) {
			if (movFlg == 1) {
				/*if (!mov.scrollBar.hitTestObject(mov.scroll_l)) {
				mov.scrollBar.x -= 10;
				} else {
				mov.scrollBar.x = mov.scroll_l.x+mov.scrollBar.width;
				}*/
				var endPos = FarEndScrollX-initSpLen;
				if (mov.scrollBar.x > endPos) {
					mov.scrollBar.x -= 10;
					if (mov.scrollBar.x <endPos) {
						mov.scrollBar.x = endPos;
					}
				}
			}
			if (movFlg == 2) {
				/*if (!mov.scrollBar.hitTestObject(mov.scroll_r)) {
				mov.scrollBar.x += 10;
				} else {
				mov.scrollBar.x = mov.scroll_r.x;
				}*/
				if (mov.scrollBar.x < mov.scroll_r.x) {
					mov.scrollBar.x += 10;
					if (mov.scrollBar.x>mov.scroll_r.x) {
						mov.scrollBar.x=mov.scroll_r.x;
					}
				}
			}
			var chkval = incmcount;
			mov.scale_mc.x =currentPos+((FarEndScrollX-initSp)-(currentClicked.x-initSp))*chkval;
		}
		//
		private function startDragLeft(evt:Event) {
			movFlg = 1;
			currentClicked1 = evt.currentTarget as MovieClip;
			currentClicked1.stage.addEventListener(MouseEvent.MOUSE_UP,stopDragLeft);
			mov.addEventListener(Event.ENTER_FRAME,scroll_fn);
		}
		private function startDragRight(evt:Event) {
			movFlg = 2;
			currentClicked1 = evt.currentTarget as MovieClip;
			currentClicked1.stage.addEventListener(MouseEvent.MOUSE_UP,stopDragRight);
			mov.addEventListener(Event.ENTER_FRAME,scroll_fn);
		}
		//
		private function stopDragLeft(evt:Event) {
			mov.removeEventListener(Event.ENTER_FRAME,scroll_fn);
			currentClicked1.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragLeft);
		}
		private function stopDragRight(evt:Event) {
			mov.removeEventListener(Event.ENTER_FRAME,scroll_fn);
			currentClicked1.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragRight);
		}
		//
		public function updateScrollPosition() {
			incmcount+=1;
			lenchk=-(mov.scale_mc.x/5);
			currentClicked.scaleX = initScale/incmcount;
			initSp=currentClicked.width;
			initSpLen=ScrollAreaWidth-initSp;
			rectange = new Rectangle(FarEndScrollX-initSpLen,currentClicked.y,initSpLen,0);
			currentPos = mov.scale_mc.x;
			//currentClicked.x = initSpLen+initSp;
			currentClicked.x = FarEndScrollX

		}
		public function resetScrollPosition() {
			currentClicked.x = FarEndScrollX;
			lenchk = 0 ;
			initSpLen = 10;
			initSp= FarEndScrollX;
			initScale=currentClicked.scaleX = 16;
			currentClicked.mouseEnabled = false;
			incmcount = 1;
			rectange = new Rectangle(initSp,currentClicked.y,initSpLen,0);
		}
		public function activateScroll() {
			currentClicked.mouseEnabled = true;
		}
	}
}
//