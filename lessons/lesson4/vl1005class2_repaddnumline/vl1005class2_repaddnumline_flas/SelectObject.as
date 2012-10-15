package {
	import flash.display.*;
	public class SelectObject extends Heymath {
		private var garbage:Array = new Array();
		//private var garbage2:Array = new Array();

		public function createCopys(objectOrg,noOfObj,tempObj_ar,objPosition,selectObject,type) {
			objectOrg.visible = false;
			if (type == "s") {
				clearCopys();
			}
			var px = 0;
			var py = 0;
			var len = tempObj_ar.length;
			for (var i=1; i<=noOfObj; i++) {
				var obj1 = duplicateMovie(objectOrg);
				//garbage.push(obj1);
				for (var j=0; j<len; j++) {
					if (j!=selectObject) {
						obj1[tempObj_ar[j]].parent.removeChild(obj1[tempObj_ar[j]]);
					} else {
						//var hh = obj1[tempObj_ar[j]].totalFrames;
						garbage.push(obj1[tempObj_ar[j]]);
						obj1[tempObj_ar[j]].gotoAndStop(1);
						obj1[tempObj_ar[j]].rposx.visible = false;
						obj1[tempObj_ar[j]].ball_mc.visible = false;
					}
				}
				objPosition.addChild(obj1);
			}
			return garbage;
		}
		public function clearCopys() {
			for (var j1=0; j1<garbage.length; j1++) {
				garbage[j1].parent.parent.removeChild(garbage[j1].parent);
				//garbage2.push(garbage[j1].parent);
			}
			/*
			for (var j2=0; j2<garbage2.length; j2++) {
				trace(MovieClip(garbage2[j2].parent) + " chk");
			}
			garbage =[];*/
			garbage =[];
		}
	}
}