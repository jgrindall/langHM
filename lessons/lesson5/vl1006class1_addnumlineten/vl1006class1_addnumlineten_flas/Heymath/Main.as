package Heymath{
	import flash.geom.Point;
	import flash.display.*;
	public class Main extends MovieClip {
		private var resultWord:Array=new Array("Great!","Excellent!","Well Done!","Super!");
		private var resultSoundWord:Array=new Array("great","excellent","welldone","super");
		public function localXY(c:String,val:Number,mc:MovieClip,cmc:MovieClip):Number {
			var pt:Point=new Point  ;
			pt[c]=mc[c];
			var pt1:Point=mc.parent.localToGlobal(pt);
			var pt2:Point=cmc.globalToLocal(pt1);
			return pt2[c];
		}
		//
		public function duplicateMovie(target,mov):DisplayObject {
			/*var targetClass:Class=Object(target).constructor;
			var duplicate:DisplayObject=new targetClass;
			duplicate.transform=target.transform;
			target.parent.addChild(duplicate);
			return duplicate;*/
			//trace(target)
			var duplicate:DisplayObject = new target();
			mov.parent.addChild(duplicate);
			return duplicate;
		}
		public function getPraiseWords():String {
			var ran=Math.floor(Math.random() * resultWord.length)
			
			return String(resultWord[ran] + resultSoundWord[ran]);
		}
		public function randomBetween(val1,val2):Number {
			return Math.floor(Math.random() * ((val2+1)-(val1))) + val1;
		}
	}
}