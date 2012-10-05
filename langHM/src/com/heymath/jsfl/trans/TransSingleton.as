package com.heymath.jsfl.trans
{
    import com.heymath.jsfl.events.*;
    
    import com.heymath.jsfl.model.*;

    public class TransSingleton extends Object
    {
        private var _new:Array;
        private var _dirty:Boolean = false;
        private var _dict:Array;
        private static var _allow:Boolean = false;
        private static var _instance:TransSingleton = null;
		public static const DEFAULTS:Array = [Languages.ENGLISH, Languages.PORTUGESE, Languages.FRENCH, Languages.SPANISH, Languages.HINDI, Languages.HEBREW, Languages.GERMAN];
		
		
		
        public function TransSingleton()
        {
            this._dict = [];
            this._new = [];
            if (!_allow)
            {
                throw new Error("Use getInstance() method instead");
            }
            EventSingleton.getInstance().addEventListener(LangEvent.SAVE_NEW_COMPLETE, this.onXMLSaved);
            return;
        }

        public function getLanguages() : Array
        {
            var d:Dictionary = null;
            var r:Array = [];
            var i:int = this._dict.length - 1;
            while (i >= 0)
            {
                
                d = this._dict[i] as Dictionary;
                r.push(d.lang);
                i = i - 1;
            }
            return r;
        }

        public function add(s:String, r:String) : void
        {
            var lang:String = LangModelSingleton.getInstance().getLang();
            this.getDictByLang(lang).add(s, r);
            this._new.push({lang:lang, search:s, replacer:r});
            this.setDirty(true);
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.TRANS_SAVED, true, true));
            return;
        }

        public function setData(data:Array) : void
        {
            var i:int = 0;
            var lang:String = null;
            var s:String = null;
            var r:String = null;
            var d:Dictionary = null;
            var entry:Object = null;
            _dict = [];
            i = 0;
            while (i <= (data.length - 1))
            {
                
                entry = data[i];
                lang = entry.lang;
                s = entry.search;
                r = entry.replacer;
                d = this.getDictByLang(lang);
                if (!d)
                {
                    d = new Dictionary(lang);
                    this._dict.push(d);
                }
                d.add(s, r);
                i++;
            }
            this.setDefaults();
            LangModelSingleton.getInstance().setLang(this.getLanguages()[0]);
            return;
        }
		private function setDefaults():void{
			var langs:Array = this.getLanguages();
			for(var i:int=0;i<=TransSingleton.DEFAULTS.length-1;i++){
				var l:String = TransSingleton.DEFAULTS[i];
				if(langs.indexOf(l)==-1){
					var d:Dictionary = new Dictionary(l);
					_dict.push(d);
				}
			}
		}
        public function translate(s:String) : String
        {
            var dict:Dictionary = null;
            var lang:String = LangModelSingleton.getInstance().getLang();
            var r:String = s;
            var i:int = this._dict.length - 1;
            while (i >= 0)
            {
                dict = this._dict[i] as Dictionary;
                if (dict.lang == lang)
                {
                    r = dict.translate(s);
                    break;
                }
                i = i - 1;
            }
            return r;
        }

        private function onXMLSaved(event:LangEvent) : void
        {
            this.setDirty(false);
            return;
        }

        public function setDirty(d:Boolean) : void
        {
            if(this._dirty != d){
            	this._dirty = d;
            	EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DIRTY_CHANGED, true, true));
            }
            return;
        }

        private function getDictByLang(lang:String) : Dictionary
        {
            var d:Dictionary = null;
            var i:int = this._dict.length - 1;
            while (i >= 0)
            {
                
                d = this._dict[i] as Dictionary;
                if (d.lang == lang)
                {
                    return d;
                }
                i = i - 1;
            }
            return null;
        }

        public function getNew() : Array
        {
            return this._new;
        }

        public function getDirty() : Boolean
        {
            return this._dirty;
        }

        public static function getInstance() : TransSingleton
        {
            if (_instance == null)
            {
                _allow = true;
                _instance = new TransSingleton;
                _allow = false;
            }
            return _instance;
        }

    }
}
