package Heymath{
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.*;
	import Heymath.SelectObject;
	public class Hopper extends Main {
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
		private var selectObj:SelectObject;
		private var rabbit_ar:Array=new Array  ;
		private var selRabbit;
		private var scalePivot:Number=730;
		private var finarrow:MovieClip;
		private var dumyRabbit:Array=new Array  ;
		private var arrNo=1;
		private var dumHigh:MovieClip;
		private var scaleLen:Number=11;
		//
		public function Hopper(mc) {
			mainMov=mc;
			mainMov.scaleX*=2;
			mainMov.scaleY*=2;
			mainMov.scale_mc.scalePt.visible=false;
			mainMov.scrollBar.visible=false;
			setScaleLength();
			//scrlMovie=new ScrollMovie(mainMov);
			mainMov.scale_mc.rabbit.visible=false;
			selectObj=new SelectObject  ;
			for (var i=0; i <= 10; i++) {
				rabbit_ar.push("rabbit" + i);
			}
		}
		//
		public function setScaleLength() {
			var px=mainMov.scale_mc.scalePt.x;
			var py=mainMov.scale_mc.scalePt.y;
			for (var i=1; i <= scaleLen; i++) {
				//var mov:MovieClip=MovieClip(duplicateMovie(mainMov.scale_mc.scalePt));
				var mov:MovieClip=new scalePtL();
				mainMov.scale_mc.addChild(mov);
				//
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
			finalVal=11;
		}
		//
		public function goHopper() {
			resetHopper();
			mainMov.scale_mc.rabbit.addEventListener(Event.ENTER_FRAME,move_fn);
			var get_ar=selectObj.createCopys(rabbits,mainMov.scale_mc.rabbit,1,rabbit_ar,mainMov.scale_mc,jumLen1,"s");
			selRabbit=MovieClip(get_ar[0]);
			selRabbit.parent.scaleX=mainMov.scale_mc.rabbit.scaleX;
			selRabbit.parent.scaleY=mainMov.scale_mc.rabbit.scaleY;
			arrNo=1;
			selRabbit.gotoAndPlay(2);
			selRabbit.dupRab.visible=false;
		}
		public function resetHopper() {
			inc=jumLen2*5.8;
			totJump=0;
			scalePivot=730;
			mainMov.scale_mc.rabbit.visible=false;
			//trace("innnn")
			selectObj.clearCopys();
		}
		//
		function move_fn(evt:Event) {
			if (selRabbit.currentFrame==selRabbit.totalFrames) {
				//
				var rdx=localXY("x",1,selRabbit.rposx,selRabbit.parent.parent);
				dumHigh.visible=false;

				selRabbit.gotoAndStop(selRabbit.totalFrames);
				selRabbit.dupRab.visible=false;
				//
				var get_ar=selectObj.createCopys(rabbits,mainMov.scale_mc.rabbit,1,rabbit_ar,mainMov.scale_mc,jumLen2,"m");
				selRabbit=get_ar[arrNo];
				arrNo++;
				selRabbit.parent.x=rdx;
				selRabbit.parent.scaleX=mainMov.scale_mc.rabbit.scaleX;
				selRabbit.parent.scaleY=mainMov.scale_mc.rabbit.scaleY;
				for (var m=10; m>=1; m--) {
					scale_ar[m].arrow_mc.visible=false
				}
				totJump++;
				if (totJump<=1) {
					selRabbit.gotoAndPlay(1);
					mainMov.parent.playSound("rabbitJump" +jumLen2);
				} else {
					mainMov.scale_mc.rabbit.removeEventListener(Event.ENTER_FRAME,move_fn);
					selRabbit.gotoAndStop(1);
					mainMov.parent.finalQuestion();
				}
			} else {
				if (selRabbit.dupRab.visible) {
					for (var i=0; i < scale_ar.length; i++) {
						if (scale_ar[i].pivot.hitTestObject(selRabbit.dupRab)) {
							if (! scale_ar[i].highLight.visible) {
								scale_ar[i].highLight.gotoAndPlay(1);
								scale_ar[i].highLight.visible=true;
								var chkJump;
								if (totJump==0) {
									chkJump=jumLen1;
								} else {
									chkJump=jumLen2;
								}
								var finJ=Number(scale_ar[i].txt.text);
								for (var l=finJ; l>finJ-chkJump; l--) {
									scale_ar[l].arrow_mc.visible=true;
									scale_ar[l].arrow_mc.gotoAndPlay(1)
								}

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
				//var dx=localXY("x",1,selRabbit.ball_mc,selRabbit.parent.parent);

			}
		}
		//
		private function updateScale() {
			mainMov.scale_mc.x-=700;
			scalePivot+=730;
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