package testAstar
{
	import com.baseoneonline.flash.astar.TileGraph;
	import com.baseoneonline.flash.astar.TileNode;
	import com.baseoneonline.flash.geom.Vec2i;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	

	[Event(type="MapEditorEvent", name="pointChanged")]
	[Event(type="MapEditorEvent", name="mapChanged")]
	public class MapEditor extends Sprite
	{
		
				
		public var startPos:int = -1;
		public var goalPos:int = -1;
		
		private const tileSize:Number = 10;
		private const tileSpace:Number = 1;
		private const col_wall:uint = 0x000088;
		private const col_plain:uint = 0xFFFFFF;
		private const col_start:uint = 0x0088FF;
		private const col_goal:uint = 0xFF8800;
		private const col_path:uint = 0xFF00FF;
		private const col_visited:uint = 0xDD33DD;
		private const space:Number = tileSize+tileSpace;
		
		private var paintCost:Number = -1;
		private var isDrawing:Boolean = false;

		private var graph:TileGraph;
		
		private var startDot:Dot = new Dot(0xFF0000);
		private var goalDot:Dot = new Dot(0x00FF00);
		private var pathSprite:Sprite = new Sprite();
		private var visitedSprite:Sprite = new Sprite();
		private var spriteBG:Sprite = new Sprite();
		
		public function MapEditor(map:TileGraph)
		{
			setMap(map);
			
			addChild(spriteBG);
			addChild(pathSprite);
			addChild(visitedSprite);
			addChild(startDot);
			addChild(goalDot);
			
			pathSprite.mouseEnabled = false;
			visitedSprite.mouseEnabled = false;
			
			startPos = getRandomFreePos();
			goalPos = getRandomFreePos();
			redraw();
			
			spriteBG.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			spriteBG.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);

		}
		
		/**
		 * 	Return map tile at provided screen-space point.
		 */
		public function getTileAt(p:Point):TileNode {
			var pt:Vec2i = screenToGrid(p);
			return graph.getTileAt(pt.x, pt.y);
		}
		
		/**
		 * 	Set the datamodel
		 */
		private function setMap(map:TileGraph):void {
			this.graph = map;
			redraw();
		}
		
		/**
		 * 	Update all graphics
		 */
		public function redraw():void {
			redrawBG(spriteBG.graphics);
			positionPoints();
			fireMapChanged();
		}
		
		/**
		 * 	Convert screen-space point to grid-space point
		 */
		public function screenToGrid(p:Point):Vec2i {
			return new Vec2i(p.x/space, p.y/space);
		}
		
		/**
		 * 	Convert grid-space point to center of screen-space tile
		 */
		public function gridToScreen(p:Vec2i):Point {
			return new Point((p.x*space)+(tileSize/2),(p.y*space)+(tileSize/2));
		}
		
		/**
		 * 	Clear old path and draw a new one.
		 */
		public function drawPath(path:Vector.<TileNode>):void {
			var g:Graphics = pathSprite.graphics;
			g.clear();	
			if (path.length > 1) {
				g.lineStyle(3,col_path);
				var p:Point = gridToScreen(path[0]);
				g.moveTo(p.x, p.y);
				for (var i:int=1; i<path.length; i++) {
					p = gridToScreen(path[i]);
					g.lineTo(p.x, p.y);
				}
			}
		}
		
//		public function drawVisited(pts:Array):void {
//			var g:Graphics = visitedSprite.graphics;
//			g.clear();
//			if (pts.length > 1) { 
//				var n:AStarNode;
//				var ip1:IntPoint = new IntPoint();
//				var ip2:IntPoint = new IntPoint();
//				var dx:Number;
//				var dy:Number;
//				var p1:Point;
//				var p2:Point;
//				var d:Point;
//				for (var i:int=0; i<pts.length; i++) {
//					n = pts[i];
//					if (n.parent) {
//						ip1.x = n.x;
//						ip1.y = n.y; 
//						ip2.x = n.parent.x;
//						ip2.y = n.parent.y;
//						p1 = gridToScreen(ip1);
//						p2 = gridToScreen(ip2);
//						d = Point.interpolate(p2,p1,.2);
//						g.lineStyle(3,col_visited, .5);
//						g.moveTo(p1.x, p1.y);
//						g.lineTo(d.x, d.y);
//						g.lineStyle(2,col_visited, .3);
//						g.lineTo(p2.x, p2.y);
//					}
//				}
//			}
//		}
		
		private function onMouseDown(e:MouseEvent):void {
			var p:Vec2i = screenToGrid(new Point(mouseX, mouseY));
			isDrawing = false;
			if (e.ctrlKey) {
				startPos = graph.getTileAt(p.x,p.y).index;
				positionPoints();
				firePointChanged();
			} else if (e.shiftKey) {
				goalPos = graph.getTileAt(p.x,p.y).index;
				positionPoints();
				firePointChanged();
			} else {
				isDrawing = true;
				swapWall(true);
				fireMapChanged();
			}
			
		}
		
		private function onMouseMove(e:MouseEvent):void {
			if (e.buttonDown) {
				var idx:int = getTileAt(new Point(mouseX, mouseY)).index;
				if (isDrawing) {
					swapWall();
					fireMapChanged();
				} else if (e.ctrlKey) {
					startPos = idx;
					positionPoints();
					firePointChanged();		
				} else if (e.shiftKey) {
					goalPos = idx;
					positionPoints();
					firePointChanged();
				}
			}
		}

		/**
		 * 	Turn walkable into wall or vice versa
		 */
		private function swapWall(recordCost:Boolean=false):void {
			var ip:Vec2i = screenToGrid(new Point(mouseX, mouseY));
			if (ip.x >= 0 && ip.x < graph.getWidth()
				&& ip.y >= 0 && ip.y < graph.getHeight()) {
				var t:TileNode = graph.getTileAt(ip.x, ip.y);
				if (recordCost) paintCost = (t.cost == -1) ? 0 : -1;
				t.cost = paintCost; 
				redrawBG(spriteBG.graphics);
			}
		}
		
		/**
		 * 	Draw the tile map.
		 */
		private function redrawBG(g:Graphics):void {
			var col:uint;
			var pt:Point;
			g.clear();
			g.beginFill(0xFF0000, 0);
			g.drawRect(0,0,graph.getWidth()*space, graph.getHeight()*space);
			g.endFill();
			
			// Tiles
			for (var x:int=0; x<graph.getWidth(); x++) {
				for (var y:int=0; y<graph.getHeight(); y++) {
					col = graph.isWalkable(x,y) ? col_plain : col_wall;
					g.beginFill(col);
					g.drawRect(x*space, y*space, tileSize, tileSize);
					g.endFill();
				}
			}
		}
		
		/**
		 * 	Move dots to start and goal position
		 */
		private function positionPoints():void {
			var pt:Point;
			if (startPos != -1) {
				pt = gridToScreen(graph.getTile(startPos));
				startDot.x = pt.x;
				startDot.y = pt.y;
			
				pt = gridToScreen(graph.getTile(goalPos));
				goalDot.x = pt.x;
				goalDot.y = pt.y;
			}
		}
		
		private function getRandomFreePos():int {
			var n:TileNode = graph.getTile(Math.floor(Math.random()*graph.size()));
			while (!graph.isWalkable(n.x, n.y)) {
				n = graph.getTile(Math.floor(Math.random()*graph.size()));
			}
			return n.index;
		}
		
		/**
		 * 	Notify listeners about changes in this map.
		 */
		private function fireMapChanged():void {
			dispatchEvent(new MapEditorEvent(MapEditorEvent.MAP_CHANGED));
		}
		
		/**
		 * 	Notify listeners about changes to start/goal.
		 */
		private function firePointChanged():void {
			dispatchEvent(new MapEditorEvent(MapEditorEvent.POINT_CHANGED));
		}

	}
}

import flash.display.Sprite;

class Dot extends Sprite {
	
	function Dot(col:uint, size:Number=5) {
		graphics.beginFill(col);
		graphics.lineStyle(2, 0, .5);
		graphics.drawCircle(0,0,size);
		graphics.endFill();
	}
	
}


