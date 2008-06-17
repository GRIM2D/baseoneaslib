package com.baseoneonline.flash.simpleParticle2D
{
	import flash.events.Event;

	public class ParticleEvent extends Event
	{
		
		public static const DIE:String = "die";
		
		public function ParticleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}