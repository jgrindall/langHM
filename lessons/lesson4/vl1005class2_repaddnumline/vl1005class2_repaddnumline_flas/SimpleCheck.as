package {
	import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	public class SimpleCheck {
		private var mov:MovieClip;
		public function initCheck(mc:MovieClip):void {
			mov=mc;
			trace(mc);
			mov.ans1.text="?";
			mov.ans1.maxChars=2;
			mov.ans1.restrict="0-9";
			mov.ans1.type=TextFieldType.INPUT;
			mov.resultMov.tryAgain.visible=false;
			mov.resultMov.right.visible=false;
			mov.resultMov.wrong.visible=false;
			mov.resultMov.pleaseAnswer.visible=false;
			mov.resultMov.pleaseAnswer.addEventListener(MouseEvent.MOUSE_DOWN,clearScreen);
			mov.resultMov.tryAgain.addEventListener(MouseEvent.MOUSE_DOWN,clearScreen);
			mov.check_btn.addEventListener(MouseEvent.CLICK, checkAnswer);
			mov.ans1.addEventListener("focusIn",setFocus_fn);
			mov.ans1.addEventListener("focusOut",setFocusOut_fn);
			mov.ans2.visible=false;
			mov.ans2.type=TextFieldType.DYNAMIC;
			try {
				MovieClip(mov.parent).stop();
				MovieClip(mov.parent.parent).disablePlayPause();
			} catch (e:Event) {
				trace(e);
			}
		}
		//
		private function checkAnswer(evt:MouseEvent):void {
			//trace(mov.ans1.text);
			mov.check_btn.visible=false;
			mov.stage.focus=mov.ans2;
			if (mov.ans1.text!="?") {
				//trace("inn");
				if (Number(mov.ans1.text)==mov.corrAns) {
					//trace("A");
					if (mov.corrAns==8) {
						MovieClip(mov.parent).playSound("welldone");
					} else if (mov.corrAns==24) {
						MovieClip(mov.parent).playSound("excellent");
					} else if (mov.corrAns==15) {
						MovieClip(mov.parent).playSound("good");
					}
					mov.resultMov.right.visible=true;
					mov.resultMov.wrong.visible=false;
					mov.ans1.selectable=false;
					mov.ans1.type=TextFieldType.DYNAMIC;
					mov.ans1.removeEventListener("focusIn",setFocus_fn);
					mov.ans1.removeEventListener("focusOut",setFocusOut_fn);
					mov.check_btn.visible=false;
					MovieClip(mov.parent.parent).showPlay();
				} else {
					//trace("B");
					mov.resultMov.tryAgain.visible=true;
					mov.resultMov.right.visible=false;
					mov.resultMov.wrong.visible=true;
					MovieClip(mov.parent).playSound("tryAgain");

				}
			} else {
				mov.resultMov.pleaseAnswer.visible=true;
				MovieClip(mov.parent).playSound("pleaseAnswer");
			}
		}
		//
		private function setFocus_fn(evt:Event):void {
			trace("inn");
			TextField(evt.target).text="";
			mov.resultMov.wrong.visible=false;
			mov.resultMov.right.visible=false;
			mov.resultMov.pleaseAnswer.visible=false;
			mov.resultMov.tryAgain.visible=false;
			mov.check_btn.visible=true;
		}
		//
		private function setFocusOut_fn(evt:Event):void {
			if (TextField(evt.target).text=="") {
				TextField(evt.target).text="?";
			}
		}
		//
		private function clearScreen(evt:MouseEvent) {
			mov.resultMov.tryAgain.visible=false;
			mov.resultMov.wrong.visible=false;
			mov.resultMov.right.visible=false;
			mov.resultMov.pleaseAnswer.visible=false;
			mov.check_btn.visible=true;
			mov.ans1.text="?";
		}
	}
}