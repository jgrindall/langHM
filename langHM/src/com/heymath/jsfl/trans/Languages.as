package com.heymath.jsfl.trans{
	
	public class Languages{
		
		public static const ENGLISH:String = "en";
		public static const FRENCH:String = "fr";
		public static const SPANISH:String = "es";
		public static const HEBREW:String = "he";
		public static const HINDI:String = "hi";
		public static const GERMAN:String = "de";
		public static const PORTUGESE:String = "po";
		
		public static function getRightToLeft(lang:String):Boolean{
			return (lang==Languages.HEBREW);
		}
		
	}
}