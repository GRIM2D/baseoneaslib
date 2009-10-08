package testAstar
{
	import flash.events.Event;

	public class MapEditorEvent extends Event
	{
		
		public static const MAP_CHANGED:String = "mapChanged";
		public static const POINT_CHANGED:String = "pointChanged";
		
		public function MapEditorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}