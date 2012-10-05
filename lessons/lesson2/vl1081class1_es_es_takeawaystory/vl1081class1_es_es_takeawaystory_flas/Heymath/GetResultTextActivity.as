package Heymath{
	public class GetResultTextActivity extends Main {
		private var dataText:String;

		public function getTextResult(rightCount:Number,wrongCount:Number,plsCount:Number,totalCount:Number,totalRight:Number,totalRight1:Number):String {
			trace(rightCount+"  "+totalCount+"  "+totalRight);
			var flg=0;
			if (rightCount==0&&wrongCount==0) {
				dataText="Please answer.";
			} else if (plsCount==totalCount) {
				dataText="Please answer.";
			} else if (wrongCount==totalCount) {
				dataText="Try again.";
			} else if (rightCount>=1) {
				if (totalRight1==totalCount-1) {
					dataText="Good, just one more.";
				} else if (totalRight1<totalCount-1) {
					dataText="Good, try the other ones.";
				} else {
					//dataText="Great!";
					dataText=getPraiseWords();
					flg=1;
				}
			} else {
				dataText="Try again.";
				
			}
			return dataText+"#"+flg;
		}
	}
}