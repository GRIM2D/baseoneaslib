package com.baseoneonline.flash.tileengine
{
	public interface ILayer
	{
		
		function ILayer(w:uint, h:uint):void;
		
		function setSize(w:uint, h:uint):void;
		
		function getTile(x:uint, y:uint):ITile;
		function setTile(x:uint, y:uint, t:ITile):void;
	}
}