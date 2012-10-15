package {
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	//import DrawArc;
	import ScrollMovie;
	import SelectObject;
	public class Hopper extends Heymath {
		private var inc:Number;
		private var rabpx:Number;
		private var totJump=0;
		private var inc1=0;
		private var mainMov;
		private var finalVal;
		private var len;
		public var jumLen1:Number=0;
		public var jumLen2:Number=0;
		private var scale_ar:Array=new Array  ;
		private var arc:Shape=new Shape  ;
		private var addPX:Number=0;
		private var addPY:Number=0;
		//private var drawshp:DrawArc;
		private var scrlMovie:ScrollMovie;
		private var selectObj:SelectObject;
		private var rabbit_ar:Array=new Array  ;
		private var selRabbit;
		private var scalePivot:Number=730;
		private var finarrow:MovieClip;
		private var dumyRabbit:Array=new Array  ;
		private var arrNo=1;
		private var dumHigh:MovieClip;
		private var dummyMovieLines:Array = new Array();
		//
		public function Hopper(mc) {
			mainMov=mc;
			mainMov.scale_mc.scalePt.visible=false;
			setScaleLength();
			//
			//drawshp=new DrawArc  ;
			scrlMovie=new ScrollMovie(mainMov);
			selectObj=new SelectObject  ;
			for (var i=0; i <= 10; i++) {
				rabbit_ar.push("rabbit" + i);
			}
		}
		//
		public function setScaleLength() {
			var px=mainMov.scale_mc.scalePt.x;
			var py=mainMov.scale_mc.scalePt.y;
			for (var i=1; i <= 101; i++) {
				var mov:MovieClip=MovieClip(duplicateMovie(mainMov.scale_mc.scalePt));
				mov.x=px;
				mov.y=py;
				mov.name="scpt"+i;
				scale_ar.push(mov);
				px+=35;
				mov.txt.text=i-1;
				mov.star_mc.visible=false;
				mov.arrow_mc.visible=false;
				mov.highLight.visible=false;
				mainMov.scale_mc.addChild(mov);
			}
			finalVal=21;
		}
		//
		public function goHopper() {
			resetHopper();

			mainMov.scale_mc.rabbit.addEventListener(Event.ENTER_FRAME,move_fn);
			var get_ar=selectObj.createCopys(mainMov.scale_mc.rabbit,1,rabbit_ar,mainMov.scale_mc,jumLen2,"s");
			selRabbit=MovieClip(get_ar[0]);
			arrNo=1;
			selRabbit.gotoAndPlay(2);
			selRabbit.dupRab.visible=false;
			mainMov.scale_mc.mask_mc.visible=false;
			//trace(dummyMovieLines  +"  " +" after")
			//dummyMovieLines.push(selRabbit)
		}
		public function resetHopper() {
			inc=jumLen2*5.8;
			totJump=0;
			scalePivot=730;
			mainMov.scale_mc.rabbit.visible=false;
			//trace(dummyMovieLines)
			/*for(var i=0;i<dummyMovieLines.length;i++)
			{
			dummyMovieLines[i].parent.removeChild(dummyMovieLines[i])
			}*/
			selectObj.clearCopys();
			scrlMovie.resetScrollPosition();
		}
		//
		function move_fn(evt:Event) {
			if (selRabbit.currentFrame==selRabbit.totalFrames) {
				//
				var rdx=localXY("x",1,selRabbit.rposx,selRabbit.parent.parent);
				dumHigh.visible=false;
				/*for (var k1=0; k1 < mainMov.parent.tempMov_ar.length; k1++) {
				mainMov.parent.tempMov_ar[k1].glow_mc.visible=false;
				}*/
				//
				/*var mov:MovieClip=MovieClip(duplicateMovie(selRabbit));
				mainMov.scale_mc.addChild(mov);
				mov.gotoAndStop(mov.totalFrames);
				mov.scaleX = .28;
				mov.x = selRabbit.parent.x*/
				var mcNo:Array=selectObj.createCopys(mainMov.scale_mc.rabbit,1,rabbit_ar,mainMov.scale_mc,jumLen2,"m");
				var mov=MovieClip(mcNo[arrNo]);
				arrNo++;
				mov.parent.x=selRabbit.parent.x;
				mov.gotoAndStop(mov.totalFrames);
				mov.dupRab.visible=false;
				selRabbit.gotoAndPlay(2);
				selRabbit.parent.x=rdx;
				//dummyMovieLines.push(mov)
				//selRabbit.visible =false
				//mov.gotoAndStop(mov.totalFrames);
				
				totJump++;
				if (totJump<jumLen1) {
					selRabbit.gotoAndPlay(1);
					//selRabbit.visible = false;
					mainMov.parent.playSound("rabbitJump" +jumLen2);
				} else {
					mainMov.scale_mc.rabbit.removeEventListener(Event.ENTER_FRAME,move_fn);
					scrlMovie.activateScroll();
					selRabbit.gotoAndStop(1);
					//drawshp.stopDraw();
					mainMov.parent.finalQuestion();
				}
			} else {
				if (selRabbit.dupRab.visible) {
					for (var i=0; i < scale_ar.length; i++) {
						if (scale_ar[i].pivot.hitTestObject(selRabbit.dupRab)) {
							if (! scale_ar[i].highLight.visible) {
								scale_ar[i].highLight.gotoAndPlay(1);
								scale_ar[i].highLight.visible=true;
								dumHigh=scale_ar[i].highLight;
								//
								for (var k=0; k < mainMov.parent.tempMov_ar.length; k++) {
									mainMov.parent.tempMov_ar[k].glow_mc.visible=false;
								}
								mainMov.parent.tempMov_ar[totJump].glow_mc.visible=true;
								mainMov.parent.tempMov_ar[totJump].glow_mc.gotoAndPlay(1);
								//
							}
						} else {
							scale_ar[i].highLight.visible=false;
						}
					}
				}
				//
				var dx=localXY("x",1,selRabbit.ball_mc,selRabbit.parent.parent);
				if (dx>=scalePivot) {
					updateScale();
				}
			}
		}
		//
		private function updateScale() {
			mainMov.scale_mc.x-=700;
			scalePivot+=730;
			scrlMovie.updateScrollPosition();
		}
		//
		public function resetScale() {
			for (var i=0; i < scale_ar.length; i++) {
				scale_ar[i].parent.removeChild(scale_ar[i]);
			}
			scale_ar=[];
			mainMov.scale_mc.rabbit.x=0;
			mainMov.scale_mc.rabbit.gotoAndStop(1);
			setScaleLength();
			mainMov.scale_mc.x=0;
		}
	}
}
//