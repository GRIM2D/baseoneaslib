package testAstar {
	import com.baseoneonline.flash.astar.AStar;
	import com.baseoneonline.flash.astar.TileGraph;
	import com.baseoneonline.flash.utils.KeyCode;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;

	[SWF(frameRate=60, backgroundColor=0xEEEEEE, width=450, height=450)]
	public class AStarTest extends Sprite
	{
		
		private var graph:TileGraph;
		private var editor:MapEditor;
		private var astar:AStar;
		
		private var tfHelp:TextField;
		private var tfDistance:TextField;
		
		public function AStarTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			graph = new TileGraph();
			editor = new MapEditor(graph);
			editor.addEventListener(MapEditorEvent.MAP_CHANGED, onMapChanged);
			editor.addEventListener(MapEditorEvent.POINT_CHANGED, onPointChanged);
			addChild(editor);
			
			astar = new AStar(graph);
			
			onPointChanged();
			
			
			
			tfHelp = createText( "Click/Drag: Draw walls\n"
					+ "Click+CTRL: Change start point\n"
					+ "Click+SHIFT: Change goal point\n"
					+ "Backspace: Clear map\n"
					+ "1/2/3: Change distance function");
			addChild(tfHelp);
			tfHelp.y = editor.height;
			
			tfDistance = createText( "Manhattan");
			addChild(tfDistance);
			tfDistance.y = editor.height;
			tfDistance.x = 200;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
				switch(e.keyCode) {
					case Keyboard.BACKSPACE:
						graph.clear();
						update();
						break;
					case KeyCode.KEY_1:
//						astar.distanceFunction = AStar.distManhattan;
						tfDistance.text = "Manhattan";
						update();
						break;
					case KeyCode.KEY_2:
//						astar.distanceFunction = AStar.distEuclidian;
						tfDistance.text = "Euclidian";
						update();
						break;
					case KeyCode.KEY_3:
//						astar.distanceFunction = AStar.distEightWay;
						tfDistance.text = "Orthogonal/Diagonal";
						update();
						break;
					default:
				}

			});
			
		}
		
		private function update():void {
			onMapChanged();
			editor.redraw();
		}
		
		private function onMapChanged(e:MapEditorEvent=null):void {
//			astar.updateMap();
			onPointChanged();
		}

		private function onPointChanged(e:MapEditorEvent=null):void {
			var path:Vector.<int> = astar.solve(editor.startPos, editor.goalPos);
			editor.drawPath(graph.getNodes(path));
			//editor.drawVisited(astar.visited);
		}
		
		private function createText(t:String):TextField {
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.textColor = 0x555555;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = t
			return tf;
		}
	}
}
