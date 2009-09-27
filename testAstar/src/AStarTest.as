package {
	import com.baseoneonline.flash.astar.AStar;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	[SWF(frameRate=60, backgroundColor=0xEEEEEE)]
	public class AStarTest extends Sprite
	{
		
		private var map:Tilemap;
		private var editor:MapEditor;
		private var astar:AStar;
		
		public function AStarTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			map = new Tilemap(40,30);
			editor = new MapEditor(map);
			editor.addEventListener(MapEditorEvent.MAP_CHANGED, onMapChanged);
			editor.addEventListener(MapEditorEvent.POINT_CHANGED, onPointChanged);
			addChild(editor);
			
			astar = new AStar(map);
			
			createHelpText();
		}
		
		private function onMapChanged(e:MapEditorEvent):void {
			astar.updateMap();
			onPointChanged();
		}

		private function onPointChanged(e:MapEditorEvent=null):void {
			var path:Array = astar.solve(editor.startPos, editor.goalPos);
			editor.drawPath(path);
			editor.drawVisited(astar.visited);
		}
		
		private function createHelpText():void {
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.textColor = 0x555555;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "Click/Drag: Draw walls\n"
					+ "Click+CTRL: Change start point\n"
					+ "Click+SHIFT: Change goal point\n"; 
			addChild(tf);
			tf.y = editor.height;
		}
	}
}
