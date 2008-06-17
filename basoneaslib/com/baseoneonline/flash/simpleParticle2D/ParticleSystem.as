package com.baseoneonline.flash.simpleParticle2D
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class ParticleSystem
	{
		
		private var particles:Array = [];
		
		public var gravity:Point = new Point(0,1);
		
		public var damp:Number = .9999;
		
		function ParticleSystem() {
		
		}
		
		
		/**
		 * 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */
		public function createParticle(x:Number=0, y:Number=0):Particle {
			var p:Particle = new Particle(x,y);
			addParticle(p);
			return p;
		}
		
		/**
		 * 
		 * @param p
		 * 
		 */
		public function addParticle(p:Particle):void {
			for (var i:int=0; i<particles.length; i++) {
				if (particles[i] == p) throw new Error("Tried to add the same particle twice!");
			}
			particles.push(p);
		}
		
		/**
		 * 
		 * @param p
		 * 
		 */
		public function removeParticle(p:Particle):void {
			for (var i:int=0; i<particles.length; i++) {
				if (particles[i] == p) {
					particles.splice(i,1);
				}
			}
		}
		
		/**
		 * 
		 * @param t	Time correction
		 * 
		 */
		public function update(t:Number):void {
			var p:Particle;
			var vx:Number;
			var vy:Number;
			var tempx:Number;
			var tempy:Number;
			for (var i:int=0; i<particles.length; i++) {
				p = particles[i];
				
				// Already time corrected
				vx = p.x - p.ox;
				vy = p.y - p.oy;
				
				vx += gravity.x * t;
				vy += gravity.y * t;
				
				//vx *= damp*t;
				//vy *= damp*t;
				
				tempx = p.x;
				tempy = p.y;
				
				p.x += vx;
				p.y += vy;
				
				p.ox = tempx;
				p.oy = tempy;
				
				p.age += t;
				
				if (p.age > p.lifeSpan) {
					p.kill();
					removeParticle(p);
				}
				
			}
		}

		public function drawParticles(g:Graphics):void {
			
			for each(var p:Particle in particles) {
				
				g.lineStyle(1,0);
				g.moveTo(p.ox, p.oy);
				g.lineTo(p.x, p.y);
				g.lineStyle(1,0);
				//g.beginFill(0xFFFFFF);
				g.drawCircle(p.x,p.y, 1);
				//g.endFill();	
				
			} 
		}
		
	}
}