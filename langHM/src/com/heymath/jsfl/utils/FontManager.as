package com.heymath.jsfl.utils
{
    import flash.text.*;
	
    public class FontManager extends Object
    {
        [Embed(systemFont="Arial", fontName="ArialEmbed", mimeType="application/x-font")]
        public static var ArialEmbed:Class;

        public function FontManager()
        {
            return;
        }

        public static function getArialEmbed() : String
        {
            return "ArialEmbed";
        }

        public static function getDefaultTextFormat(size:int) : TextFormat
        {
            var tf:TextFormat = new TextFormat();
            tf.size = size;
            tf.font = getArialEmbed();
            tf.color = "0x000000";
            return tf;
        }

    }
}
