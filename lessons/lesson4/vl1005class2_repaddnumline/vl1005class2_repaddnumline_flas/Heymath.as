package {
	import flash.geom.Point;
	import flash.display.*;
	public class Heymath extends MovieClip {
		private var resultWord:Array=new Array("Good!","Excellent!","Well Done!","Super!");
		public function localXY(c:String,val:Number,mc:MovieClip,cmc:MovieClip):Number {
			var pt:Point=new Point;
			pt[c]=mc[c];
			var pt1:Point=mc.parent.localToGlobal(pt);
			var pt2:Point=cmc.globalToLocal(pt1);
			return pt2[c];
		}
		//
		public function duplicateMovie(target):DisplayObject {
			var targetClass:Class=Object(target).constructor;
			var duplicate:DisplayObject=new targetClass;
			duplicate.transform=target.transform;
			target.parent.addChild(duplicate);
			return duplicate;
		}
		public function getPraiseWords():String {
			return resultWord[Math.floor(Math.random() * resultWord.length)];
		}
		public function randomBetween(val1,val2):Number {
			return Math.floor(Math.random() * ((val2+1)-(val1))) + val1;
		}
	}
}