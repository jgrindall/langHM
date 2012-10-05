package com.heymath.jsfl.utils
{
    
    import com.heymath.jsfl.events.LangEvent;
    import com.heymath.jsfl.trans.*;
    
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
	
    public class LangUtils extends Object
    {

        public function LangUtils()
        {
            return;
        }
		
        public static function addTranslatedText(t:TextField, m:MovieClip) : void
        {
            var s:String = TransSingleton.getInstance().translate(LangUtils.getText(m));
            if (s)
            {
                t.text = s;
            }
            EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.DEBUG,true,true,{"message":"set as "+s}));
            return;
        }

        public static function getText(m:MovieClip) : String
        {
            var s:StaticText = LangUtils.getOrigTextField(m);
            if (s)
            {
                return LangUtils.getOrigTextField(m).text;
            }
            return null;
        }

        public static function getOrigTextField(m:MovieClip) : StaticText
        {
            var s:StaticText = null;
            var i:int = 0;
            while (i <= (m.numChildren - 1))
            {
                
                s = m.getChildAt(i) as StaticText;
                if (s && (!m.float || m.float != s))
                {
                    return s;
                }
                i++;
            }
            return null;
        }

    }
}
