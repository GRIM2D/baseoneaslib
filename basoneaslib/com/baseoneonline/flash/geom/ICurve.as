package com.baseoneonline.flash.geom
{
	import flash.geom.Point;
	
	public interface ICurve
	{
		function getPoint(mu:Number):Point;
		function getOffsetPoint(mu:Number, offset:Number):Point;
	}
}