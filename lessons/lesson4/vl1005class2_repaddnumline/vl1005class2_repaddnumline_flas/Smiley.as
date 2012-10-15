package {
	public class Smiley {

		private var mainMov;
		private var smileCount = 0;
		private var smileTotal = 0;
		public function Smiley(mc) {
			var smileCount = 0;
			mainMov = mc;
			for (var j=1; j<=10; j++) {
				mainMov["smile"+j].visible =false;
			}
			mainMov.smileTotalMov.visible = false;
		}
		public function getSmiley() {
			smileCount++;
			if (smileCount%11 == 0) {
				mainMov.smileTotalMov.visible = true;
				smileTotal+=10;
				mainMov.smileTotalMov._txt.text = smileTotal;
				for (var n=1; n<=10; n++) {
					mainMov["smile"+n].visible =false;
				}
				smileCount = 1;
			}
			mainMov["smile"+smileCount].visible = true;
		}
	}
}