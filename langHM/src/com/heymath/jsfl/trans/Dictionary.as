package com.heymath.jsfl.trans
{

    public class Dictionary extends Object
    {
        private var _lang:String;
        private var _search:Array;
        private var _replacer:Array;

        public function Dictionary(lang:String)
        {
            this._search = [];
            this._replacer = [];
            this._lang = lang;
            return;
        }

        public function get lang() : String
        {
            return this._lang;
        }

        public function translate(s:String) : String
        {
            var i:int = this._search.length - 1;
            while (i >= 0)
            {
                
                if (this._search[i] == s)
                {
                    return this._replacer[i];
                }
                i = i - 1;
            }
            return s;
        }

        public function add(s:String, r:String) : void
        {
            this._search.push(s);
            this._replacer.push(r);
            return;
        }

    }
}
