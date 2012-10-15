package Heymath{
	import flash.display.*
	public class PickObject extends Main {
		private var garbage:Array = new Array();
		public function createCopys(obj,objectOrg,noOfObj,tempObj_ar,objPosition,selectObject,type) {
			clearCopys();
			var px=0;
			var py=0;
			var len=tempObj_ar.length;
			for (var i=1; i<=noOfObj; i++) {
				//var obj1 = duplicateMovie(objectOrg);
				var obj1:MovieClip=new obj();
				objectOrg.parent.addChild(obj1);

				garbage.push(obj1);
				for (var j=0; j<len; j++) {
					if (j!=selectObject) {
						obj1[tempObj_ar[j]].parent.removeChild(obj1[tempObj_ar[j]]);
					} else {
						var hh=obj1[tempObj_ar[j]].totalFrames;
						obj1[tempObj_ar[j]].gotoAndStop(randomBetween(1,hh));
					}
				}
				objPosition.addChild(obj1);
			}
			return garbage;
		}
		public function clearCopys() {
			for (var j1=0; j1<garbage.length; j1++) {
				garbage[j1].parent.removeChild(garbage[j1]);
			}
			garbage=[];
		}
	}
}