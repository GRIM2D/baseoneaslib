package com.baseoneonline.flash.simpleParticle2D
{
	import com.baseoneonline.flash.utils.NumberTools;
	
	import flash.events.EventDispatcher;
	
	[Event(type="com.baseoneonline.flash.simpleParticle2D.ParticleEvent", name="die")]
	public class Particle extends EventDispatcher
	{
		
		public var ox:Number;
		public var oy:Number;
		
		public var x:Number;
		public var y:Number;
		
		public var lifeSpan:Number = 1;
		public var age:Number = 0;
		
		
		function Particle(x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
			this.ox = x;
			this.oy = y;
		}
		
		public function randomVelocity(min:Number, max:Number, t:Number):void {
			var angle:Number = Math.random()*Math.PI*2;
			var velocity:Number = NumberTools.randRange(min,max)*t;
			var vx:Number = Math.cos(angle)*velocity;
			var vy:Number = Math.sin(angle)*velocity;
			addVelocity(vx,vy);
		}
		
		public function addVelocity(x:Number, y:Number):void {
			ox -= x;
			oy -= y;
		}
		
		public function kill():void {
			dispatchEvent(new ParticleEvent(ParticleEvent.DIE));
		}
		
	}
}