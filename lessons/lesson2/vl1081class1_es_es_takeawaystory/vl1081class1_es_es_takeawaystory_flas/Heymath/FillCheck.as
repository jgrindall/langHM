package Heymath{
	import flash.display.*;
	import flash.events.*;
	public class FillCheck {
		private var mainMov:MovieClip;
		private var result_ar:Array=new Array  ;
		public function FillCheck(mc:MovieClip,ans_ar:Array) {
			mainMov=mc;
			result_ar=ans_ar;
			init();
		}
		private function init() {
			for (var i=1; i<=1; i++) {
				var setObj=mainMov;
				setObj.i=i-1;
				setObj.check_btn.addEventListener(MouseEvent.CLICK,check_fn);
				for (var j=1; j<=1; j++) {
					var textObj=setObj["a"+j];
					textObj.text="?";
					textObj.addEventListener("focusIn",onSetFocus_fn);
					textObj.addEventListener("focusOut",onKillFocus_fn);
					textObj.maxChars=2;
					textObj.restrict="0-9";
					setObj["res"+j+"_mc"].right_mc.visible=false;
					setObj["res"+j+"_mc"].wrong_mc.visible=false;
					setObj["res"+j+"_mc"].pleaseAns_mc.visible=false;
				}
			}
		}
		private function onSetFocus_fn(evt:Event) {
			mainMov.parent["stopFbSound"]();
			var txtObj=evt.target;
			txtObj.text="";
			var no=txtObj.name.substr(1,1);
			txtObj.parent["res"+no+"_mc"].right_mc.visible=false;
			txtObj.parent["res"+no+"_mc"].wrong_mc.visible=false;
			txtObj.parent["res"+no+"_mc"].pleaseAns_mc.visible=false;
			//txtObj.parent.result_txt.text="";
		}
		private function onKillFocus_fn(evt:Event) {
			var txt=evt.target;
			if (txt.text=="") {
				txt.text="?";
			}
		}
		private function check_fn(evt:Event) {
			var setObj=evt.currentTarget.parent;
			var wrong=0;
			var please=0;
			var rightCount=0;
			var totalRight=0;
			var totalCount=1;
			for (var j=0; j<result_ar.length; j++) {
				var txtObj=setObj["a"+(j+1)];
				if (txtObj.text==result_ar[j]) {
					if (!setObj["res"+(j+1)+"_mc"].right_mc.visible) {
						rightCount++;
					}
					setObj["res"+(j+1)+"_mc"].right_mc.visible = true;

					mainMov.parent["playSound"]("good");
					mainMov.parent["playSnapSound"]("tick");
					setObj["res"+(j+1)+"_mc"].wrong_mc.visible = false;
					setObj["res"+(j+1)+"_mc"].pleaseAns_mc.visible=false;
					txtObj.mouseEnabled=false;
					totalRight++;
				} else if (txtObj.text!=""&& txtObj.text!="?") {
					setObj["res"+(j+1)+"_mc"].right_mc.visible = false;
					setObj["res"+(j+1)+"_mc"].wrong_mc.visible = true;
					mainMov.parent["playSound"]("tryAgain");
					setObj["res"+(j+1)+"_mc"].pleaseAns_mc.visible=false;
					wrong++;
				} else {
					setObj["res"+(j+1)+"_mc"].right_mc.visible = false;
					setObj["res"+(j+1)+"_mc"].wrong_mc.visible = false;
					setObj["res"+(j+1)+"_mc"].pleaseAns_mc.visible=true;
					mainMov.parent["playSound"]("plAnswer");
					please++;
				}
				if (totalRight==1) {
					setObj.check_btn.mouseEnabled=false;
					setObj.check_btn.visible=false;
					mainMov.playEnable();
				}
				mainMov.stage.focus=mainMov.dummy_txt;
			}
		}
	}
}