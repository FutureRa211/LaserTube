package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author jjp
	 */
	public class Main extends Sprite 
	{
		private var videotube:Videotube;
		private var gamedisc:Gamedisc;
		private var gameeditor:GameEditor;
		private var gameplayer:GamePlayer;
		
		public function Main():void 
		{
			gamedisc = new Gamedisc("The Last Eichhof - Longplay.flv");
			videotube = gamedisc.CreateVideotube();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(videotube);
			toggleGame();
			stage.addEventListener(KeyboardEvent.KEY_UP, onKey);
			videotube.play();
		}
		private function toggleGame():void
		{
			if (gameeditor == null)
			{
				if (gameplayer != null)
				{
					removeChild(gameplayer);
					gameplayer = null;
				}
				
				gameeditor = new GameEditor(videotube, gamedisc);
				addChild(gameeditor);
			}
			else
			{
				removeChild(gameeditor);
				gameeditor = null;
				
				gameplayer = new GamePlayer(videotube, gamedisc);
				addChild(gameplayer);
			}
			videotube.seek(0);
		}
		private function onKey(key:KeyboardEvent):void
		{
			if (key.keyCode == Keyboard.SPACE)
				toggleGame();
		}
	}
}