package com.heymath.jsfl.lib{
	
	import com.heymath.jsfl.lib.events.FlashLangEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class FlashLang{
		
		private var _mc:MovieClip;
		private var _name:String;
		private var _bounds:Rectangle;
		
		public function FlashLang(m:MovieClip, name:String, bounds:Rectangle):void{
			_mc = m;
			_name = name;
			_bounds = bounds;
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
			_mc.dispatchEvent(new FlashLangEvent(FlashLangEvent.PROCESS, true,true, {"movieclip":_mc,"name":_name,"bounds":_bounds}));
		}	
		
	}
}





