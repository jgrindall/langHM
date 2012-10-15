package {
	import flash.utils.Timer;
	import flash.events.*;
	import flash.display.*;
	//
	public class RandomMovie extends Heymath {
		//
		var object,object1,button1,button2;
		var object_ar:Array = new Array();
		var incm:Number;
		//
		public function RandomMovie(obj,obj1,btn1,btn2) {
			object = obj;
			object1 = obj1;
			button1 = btn1;
			button2 = btn2;
			object.visible = false;
			incm = 0;
			//object1.visible = false
		}
		//
		public function startAnimation() {
			object.parent.addEventListener(Event.ENTER_FRAME,createCopy);
			//object1.visible = true
		}
		//
		public function stopAnimation() {
			object.parent.removeEventListener(Event.ENTER_FRAME,createCopy);
			for (var i =0; i<object_ar.length; i++) {
				object_ar[i].parent.removeChild(object_ar[i]);
			}
			object_ar = [];
			incm = 0;
		}
		//
		function createCopy(evt:Event) {
			//trace(incm);
			if (incm <=200) {
				var mov = duplicateMovie(object);
				var higIndex = mov.parent.getChildIndex(mov);
				mov.gotoAndStop(randomBetween(1,3));
				mov.parent.addChild(mov);
				mov.x = randomBetween(10,750);
				mov.y = 650;
				object_ar.push(mov);
				incm++;
				if (object_ar.length >=5) {
					mov.parent.swapChildrenAt(mov.parent.getChildIndex(object1),higIndex);
					mov.parent.swapChildrenAt(mov.parent.getChildIndex(button1),higIndex-1);
					mov.parent.swapChildrenAt(mov.parent.getChildIndex(button2),higIndex-2);
				}
			} else {
				if (object_ar.length<=1) {
					stopAnimation();
				}
			}
			for (var i =0; i<object_ar.length; i++) {
				object_ar[i].y-=10;
				if (object_ar[i].y<-100) {
					object_ar[i].parent.removeChild(object_ar[i]);
					object_ar.splice(i,1);
				}
			}
		}
		//
	}
}