package com.heymath.jsfl
{
    import com.adobe.serialization.json.*;
    import com.heymath.jsfl.events.*;
    import com.heymath.jsfl.lib.events.FlashLangEvent;
    import com.heymath.jsfl.trans.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
	
	
    public class LangManager extends Object
    {
        private var _player:MovieClip;
        private var _swf:MovieClip;
        private var _lang:Lang;
        private var _saveLoader:URLLoader;
        private var _lessonId:int;
        private var _debug:TextField;
        private var _options:Object;
        private var _userId:int;
        private var _swfLoader:Loader;
        private var _loadLoader:URLLoader;
        private var _langContainer:MovieClip;
        public static const BASE_URL:String = "http://www.numbersandpictures.com/index.php/pages";
		
		
        public function LangManager(player:MovieClip, lessonid:int, userid:int, options:Object = null)
        {
            this._lang = new Lang();
            this._player = player;
            this._options = options || new Object();
            this._lessonId = lessonid;
            this._userId = userid;
            this._langContainer = new MovieClip();
            this._langContainer.addEventListener(MouseEvent.MOUSE_DOWN, this.bringToTop);
            this._lang.setContainer(this._langContainer);
            this._player.addChild(this._langContainer);
            this._player.addEventListener(FlashLangEvent.PROCESS, this.onProcess);
            
            this.moveToTop();
            this.loadData();
            EventSingleton.getInstance().addEventListener(LangEvent.SAVE_NEW, this.onSave);
            EventSingleton.getInstance().addEventListener(LangEvent.DEBUG, this.onDebug);
            this.addDebug();
            return;
            
        }

        private function onSaveError(event:Event) : void
        {
            trace("error " + event.toString());
            return;
        }

        private function onSwfLoaded(event:Event) : void
        {
            this._swf = event.currentTarget.content as MovieClip;
            this._player.addChild(this._swf);
            this._swf.play();
            return;
        }

        private function moveToTop() : void
        {
            var myTimer:Timer = new Timer(2500, 0);
            myTimer.addEventListener(TimerEvent.TIMER, function () : void
            {
                bringToTop(null);
                return;
            }
            );
            myTimer.start();
            return;
        }

        private function loadSwf() : void
        {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onSwfLoaded);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onSwfFail);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSwfFail);
            loader.load(new URLRequest(this._options.loadLesson));
            return;
        }

        public function play() : void
        {
            this._swf.play();
            return;
        }
		
        private function handleLoadComplete(event:Event) : void
        {
            msg("loaded!");
            this._lang.setData(this._loadLoader.data);
            if (this._options.loadLesson != null)
            {
                msg("swf ");
                this.loadSwf();
            }
            return;
        }

        private function onProcess(event:FlashLangEvent) : void
        {
            this._lang.process(event.data);
            return;
        }

        private function bringToTop(event:MouseEvent) : void
        {
            if (this._langContainer && this._player.numChildren >= 1)
            {
                this._player.removeChild(this._langContainer);
                this._player.addChild(this._langContainer);
            }
            return;
        }

        private function onSwfFail(event:Event) : void
        {
            trace("swf fail " + event);
            return;
        }

        private function onLoadError(event:Event) : void
        {
            trace("error " + event.toString());
            return;
        }

        private function handleSaveComplete(event:Event) : void
        {
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.SAVE_NEW_COMPLETE));
            return;
        }

        private function addDebug() : void
        {
            if (this._options.debug)
            {
                this._debug = new TextField();
                this._langContainer.addChild(this._debug);
                this._debug.width = 200;
                this._debug.height = 75;
                this._debug.x = this._player.stage.stageWidth - this._debug.width;
                this._debug.y = 75;
                this._debug.border = true;
                this._debug.text = "Debug:\n";
                this._debug.alpha = 0.6;
            }
            return;
        }

        private function onDebug(event:LangEvent) : void
        {
            if (this._debug)
            {
                this._debug.appendText(event.data.message + "\n");
            }
            return;
        }
		private function msg(s:String):void{
			this._langContainer.dispatchEvent(new LangEvent(LangEvent.DEBUG, true,true,{"message":s}));
			EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG, true,true,{"message":s}));
		}
        private function loadData() : void
        {
            msg("load");
            var url:URLRequest = new URLRequest(BASE_URL + "/getTrans/" + this._lessonId);
            this._loadLoader = new URLLoader();
            url.method = URLRequestMethod.GET;
            this._loadLoader.addEventListener(Event.COMPLETE, this.handleLoadComplete);
            this._loadLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadError);
            this._loadLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onLoadError);
            this._loadLoader.load(url);
            return;
        }

        private function onSave(event:LangEvent) : void
        {
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG,true,true,{"message":"save URL ..."}));
            var url:URLRequest = new URLRequest(BASE_URL + "/addTrans");
            this._saveLoader = new URLLoader();
            url.method = URLRequestMethod.POST;
            var vars:URLVariables = new URLVariables();
            vars.data = JSON.encode(event.data.newData);
            vars.lessonid = this._lessonId;
            url.data = vars;
            this._saveLoader.addEventListener(Event.COMPLETE, this.handleSaveComplete);
            this._saveLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onSaveError);
            this._saveLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSaveError);
            this._saveLoader.load(url);
            return;
        }

    }
}
