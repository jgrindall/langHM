package com.heymath.jsfl.lib{
	
	import com.heymath.jsfl.lib.events.FlashLangEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class FlashLang{
		
		private var _mc:MovieClip;
		private var _name:String;
		
		public function FlashLang(m:MovieClip, name:String):void{
			_mc = m;
			_name = name;
			init();	
		}
		private function init():void{
			if(_mc.stage){
				onEnterFrame(null);
			}
			else{
				_mc.addEventListener(Event.ADDED_TO_STAGE, onEnterFrame);
			}
			_mc.stop();
		}
		public function onEnterFrame(e:Event):void{
			var obj:Object = {"movieclip":_mc,"name":_name};
			_mc.dispatchEvent(new FlashLangEvent(FlashLangEvent.PROCESS, true,true, obj));
		}	
		
	}
}





