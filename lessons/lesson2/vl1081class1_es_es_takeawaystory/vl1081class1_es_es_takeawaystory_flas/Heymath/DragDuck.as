package Heymath{
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	public class DragDuck extends Main {
		private var mainMov:MovieClip;
		private var totalLen:Number=0;
		private var currentMov:MovieClip;
		private var checkCount:Number=0;
		private var maxIndex:Number=0;
		private var objIndex:Number=0;
		private var obj1:String="";
		private var obj2:String="";
		private var count:Number;
		private var color_ar:Array=new Array  ;
		private var activityType:Number=1;
		private var resultTxt:GetResultTextActivity=new GetResultTextActivity();
		public var getVisibleArr=[];
		public function DragDuck(mc,cnt,tot,col,act) {
			mainMov=mc;
			totalLen=tot;
			obj1="duckL";
			obj2="duckR";
			count=cnt;
			color_ar=col;
			activityType=act;
			init();
		}
		function init() {
			mainMov.check_btn.enabled=true;
			mainMov.check_btn.addEventListener(MouseEvent.MOUSE_DOWN,check_fn);
			mainMov.result_txt.text="";
			for (var k=1; k<=totalLen; k++) {
				var amov=mainMov[obj1+k+"_mc"];
				amov.k=k;
				amov.px=amov.x;
				amov.py=amov.y;
				amov.state=0;
				amov.mv="";
				amov.enabled=true;
				amov.gotoAndStop(k);
				amov.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag1_fn);
				amov.mouseChildren=false;
				amov.buttonMode=true;
				amov.visible=true;
				amov.col=color_ar[k-1];
				var qmov=mainMov[obj2+k+"_mc"];
				qmov.state=0;
				qmov.k=k;
				qmov.gotoAndStop(k);
				qmov.visible=false;
				qmov.mouseChildren=false;
				qmov.buttonMode=true;
				qmov.col=color_ar[k-1];
				qmov.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag2_fn);
				var rmov=mainMov["wrong"+k+"_mc"];
				rmov.visible=false;
			}
			mainMov.addChild(mainMov.dummyDuck_mc);
			maxIndex=mainMov.getChildIndex(mainMov.dummyDuck_mc);
		}
		private function onStartDrag1_fn(evt:Event) {
			var mov=evt.currentTarget;
			var rmov=mainMov["wrong"+mov.k+"_mc"];
			var amov=duplicateMovie(evt.currentTarget);
			objIndex=amov.parent.getChildIndex(amov);
			amov.col=mov.col;
			amov.parent.swapChildrenAt(objIndex,maxIndex);
			amov.addEventListener(MouseEvent.MOUSE_UP,onStopDrag1_fn);
			amov.stage.addEventListener(MouseEvent.MOUSE_UP,onStopDrag1_fn);
			mainMov.result_txt.text="";
			amov.startDrag();
			amov.mv=mov;
			mov.alpha=.4;
			rmov.visible=true;
			currentMov=amov;
			mov.state=1;
			mov.mouseEnabled=false;
			mainMov.parent["stopFbSound"]();
		}
		private function onStartDrag2_fn(evt:Event) {
			var mov=evt.currentTarget;
			var amov=duplicateMovie(mov);
			objIndex=amov.parent.getChildIndex(amov);
			amov.col=mov.col;
			amov.parent.swapChildrenAt(objIndex,maxIndex);
			amov.addEventListener(MouseEvent.MOUSE_UP,onStopDrag2_fn);
			amov.stage.addEventListener(MouseEvent.MOUSE_UP,onStopDrag2_fn);
			mainMov.result_txt.text="";
			amov.startDrag();
			amov.mv=mov;
			currentMov=amov;
			mov.visible=false;
			mov.state=0;
			mov.mouseEnabled=false;
			mainMov.parent["stopFbSound"]();
		}
		private function onStopDrag1_fn(evt:Event) {
			var amov=currentMov;
			amov.stopDrag();
			mainMov.parent["playSnapSound"]("snap");
			amov.parent.swapChildrenAt(objIndex,maxIndex);
			amov.stage.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag1_fn);
			var flg=0;
			for (var l=1; l<=totalLen; l++) {
				var qmov=amov.parent[obj2+l+"_mc"];
				if (amov.hitTestObject(mainMov.bg2_mc)&&qmov.state==0&&amov.col==qmov.col) {
					qmov.visible=true;
					qmov.state=1;
					qmov.mouseEnabled=true;
					flg=1;
					break;
				}
			}
			if (flg==0) {
				amov.mv.alpha=1;
				amov.mv.state=0;
				amov.mv.mouseEnabled=true;
				mainMov["wrong"+amov.mv.k+"_mc"].visible=false;
			}
			amov.parent.removeChild(amov);
		}
		//
		private function onStopDrag2_fn(evt:Event) {
			var amov=currentMov;
			amov.stopDrag();
			mainMov.parent["playSnapSound"]("snap");
			amov.parent.swapChildrenAt(objIndex,maxIndex);
			amov.stage.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag2_fn);
			var flg=0;
			for (var l=1; l<=totalLen; l++) {
				var qmov=amov.parent[obj1+l+"_mc"];
				if (amov.hitTestObject(mainMov.bg1_mc)&&qmov.state==1&&amov.col==qmov.col) {
					qmov.alpha=1;
					qmov.state=0;
					mainMov["wrong"+qmov.k+"_mc"].visible=false;
					qmov.mouseEnabled=true;
					flg=1;
					break;
				}
			}
			if (flg==0) {
				amov.mv.visible=true;
				amov.mv.mouseEnabled=true;
				amov.mv.state=1;
			}
			amov.parent.removeChild(amov);
		}
		//
		private function check_fn(evt:Event) {
			var mov=evt.currentTarget;
			var chk1=0;
			var chk2=0;
			var myTextField:TextField=mainMov.result_txt;
			var newFormat:TextFormat = new TextFormat();
			for (var k=1; k<=totalLen; k++) {
				var amov=mov.parent[obj1+k+"_mc"];
				var qmov=mov.parent[obj2+k+"_mc"];
				if (activityType==3) {
					if (qmov.visible&&qmov.col==2) {
						chk2++;
					} else if (qmov.visible) {
						chk1++;
					}
				} else {
					if (qmov.visible) {
						chk1++;
					}
				}
			}
			if (chk1==0) {
				newFormat.size=22;
				if (activityType==1) {
					mainMov.result_txt.text="Arrastra "+count+" paticos para esconderlos en el pasto.";
					//mainMov.result_txt.text="Drag "+count+" ducklings to hide in the grass.";
					mainMov.parent["playSound"]("feedback1");
				} else if (activityType==2) {
					mainMov.result_txt.text="Saca "+count+" paticos y colócalos en el río.";
					//mainMov.result_txt.text="Take away "+count+" ducklings and put them in the river.";
					mainMov.parent["playSound"]("feedback4");
				} else if (activityType==3) {
					mainMov.result_txt.text="Saca todos los paticos que no son de Patoja.";
					//mainMov.result_txt.text="Take away all the ducklings that are not Quacky's.";
					mainMov.parent["playSound"]("feedback7");
				}
			} else if (chk1==count&&chk2<=0) {
				newFormat.size=22;
				mainMov.result_txt.text="¡Bien hecho!"
				//mainMov.result_txt.text="Well done!";
				mainMov.parent["playSound"]("welldone");
				mainMov.check_btn.mouseEnabled=false;
				mainMov.check_btn.visible=false;
				enableObjects(false);
				for (var j=1; j<=totalLen; j++) {
					var amov1=mainMov[obj1+j+"_mc"];
					var qmov1=mainMov[obj2+j+"_mc"];
					var rmov1=mainMov["wrong"+j+"_mc"];
					if (amov1.alpha<1) {
						getVisibleArr.push({mv:amov1,val:1});
						getVisibleArr.push({mv:rmov1,val:2});
					}
					if (qmov1.visible) {
						getVisibleArr.push({mv:qmov1,val:3});
					}
				}
				mainMov.playEnable();
			} else {
				if (chk1<count) {
					newFormat.size=22;
					if (activityType==1) {
						mainMov.result_txt.text="No has sacado "+count+" paticos.";
						//mainMov.result_txt.text="You have not taken away "+count+" ducklings.";
						mainMov.parent["playSound"]("feedback3");
					} else if (activityType==2) {
						mainMov.result_txt.text="No has sacado "+count+" paticos.";
						//mainMov.result_txt.text="You have not taken away "+count+" ducklings.";
						mainMov.parent["playSound"]("feedback6");
					} else if (activityType==3) {
						mainMov.result_txt.text="Saca todos los paticos que no son de Patoja.";
						//mainMov.result_txt.text="Take away all the ducklings that are not Quacky's.";
						mainMov.parent["playSound"]("feedback7");
					}
				} else {

					if (activityType==1) {
						//mainMov.result_txt.setTextFormat(
						mainMov.result_txt.text="Has sacado más de "+count+" paticos. Devuelve algunos.";
						//mainMov.result_txt.text="You have taken away more than "+count+" ducklings. Put some back.";
						mainMov.parent["playSound"]("feedback2");
						newFormat.size=18;

					} else if (activityType==2) {
						mainMov.result_txt.text="Has sacado más de "+count+" paticos. Devuelve algunos.";
						//mainMov.result_txt.text="You have taken away more than "+count+" ducklings. Put some back.";
						mainMov.parent["playSound"]("feedback5");
						newFormat.size=18;
					} else if (activityType==3) {
						if (chk2>1) {
							mainMov.result_txt.text="¡Has sacado también los paticos de Patoja!";
							//mainMov.result_txt.text="You have also taken away Quacky's ducklings!";
							mainMov.parent["playSound"]("feedback9");
						} else {
							mainMov.result_txt.text="¡Has sacado también un patico de Patoja!";
							//mainMov.result_txt.text="You have also taken away Quacky's duckling!";
							mainMov.parent["playSound"]("feedback8");
						}
						newFormat.size=22;
					}
				}
			}
			myTextField.setTextFormat(newFormat);
		}

		private function reset_fn(evt:Event) {
			var mov=evt.currentTarget;
			for (var k=1; k<=totalLen; k++) {
				var amov=mov.parent[obj1+k+"_mc"];
				var qmov=mov.parent[obj2+k+"_mc"];
				var rmov=mov.parent["wrong"+k+"_mc"];
				amov.mouseEnabled=true;
				amov.x=amov.px;
				amov.y=amov.py;
				amov.state=0;
				amov.mv="";
				qmov.state=0;
				qmov.mv="";
				qmov.visible=false;
				amov.alpha=1;
				rmov.visible=false;
			}
			mov.visible=false;
			mainMov.check_btn.mouseEnabled=true;
			mainMov.check_btn.visible=true;
			mainMov.result_txt.text="";
			mainMov.finalRes_mc.visible=false;
			mainMov.finalRes_mc.res_mc.result_txt.text="";
		}
		private function enableObjects(val:Boolean) {
			for (var k=1; k<=totalLen; k++) {
				var amov=mainMov[obj1+k+"_mc"];
				var qmov=mainMov[obj2+k+"_mc"];
				amov.mouseEnabled=val;
				qmov.mouseEnabled=val;
			}
		}
	}
}