package com.baseoneonline.flash.curves
{
	import com.baseoneonline.flash.geom.Vec2f;

	public interface ICurve
	{
		/**
		 * Return a 2d position on this curve.
		 * 
		 * @param t		The position along the curve. Value from 0 to 1, 
		 * 				lower or higher values will return the first or last point.
		 * @param store	Provide a point to avoid recreating objects.
		 * @return 		Actual point on this curve.
		 * 
		 */
		function getPoint(u:Number, store:Vec2f=null):Vec2f;
		
		/**
		 * Retrieve one of the control vertices that define this curve.
		 * 
		 * @param index	Index of the control vertex to retrieve.
		 * @return 	A control vertex.
		 * 
		 */
		function getCV(index:int):Vec2f;
		
		
		/**
		 * 
		 * @return	Number of control vertices that define this curve. 
		 * 
		 */
		function numCVs():int;
		
		/**
		 * 	Get the approximate length of the curve.
		 * 
		 * @param precision	How many samples will be used to calculate the length.
		 * 					More samples means preciser estimation.
		 * @return			The actual length of the curve (approximation)
		 * 
		 */
		function getLength(samples:int):Number;
	}
}