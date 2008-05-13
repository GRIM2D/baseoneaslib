package com.baseoneonline.flash.durin.vo
{
	public class MediaType
	{
		public static const URL:String = 'url';
		public static const IMAGE:String = 'image';
		public static const VIDEO:String = 'video';
		public static const FILE:String = 'file';
		public static const NODE:String = 'node';
		public static const AUDIO:String = 'audio';
		
		public static const TYPE_LIST:Array = [
			NODE,
			FILE, 
			URL, 
			IMAGE, 
			VIDEO, 
			AUDIO
		];
		
	}
}