package archiviste.events
{
	import archiviste.flashs.ui.boutons.C_BtnClass;
	
	import utils.events.EventChannel;
	
	/**
	 * 
	 *
	 * @author SPS
	 * @version 1.0.0 [10 nov. 2011][Seb] creation
	 *
	 * citeespace.planisphere.events.NavigationEvent
	 */
	public class GameControllerEvent extends ArchivisteEvent
	{
		// --------------------------------------------------------------------
		// ELEMENTS GENERIQUES ------------------------------------------------
		// --------------------------------------------------------------------
		
		
		static public const SHOW_LVL:String='SHOW_LVL';
		static public const SHOW_VILLES:String='SHOW_VILLES';
		static public const SHOW_PLAN:String='SHOW_PLAN';
		static public const SHOW_SALLE:String='SHOW_SALLE';
		static public const SHOW_GAME:String='SHOW_GAME';
		static public const SHOW_GAME_CONCLUSION:String='SHOW_GAME_CONCLUSION';
		static public const SHOW_PUZZLE:String='SHOW_PUZZLE';
		static public const SHOW_PUZZLE_CONCLUSION:String='SHOW_PUZZLE_CONCLUSION';
		static public const ASK_GAME_CONCLUSION:String='ASK_GAME_CONCLUSION';
		static public const ASK_GAME_INTRODUCTION:String='ASK_GAME_INTRODUCTION';
		
		static public const SHOW_PROGRESSION_UPDATE:String='SHOW_PROGRESSION_UPDATE';
	
		public static const SHOW_PUZZLE_READY:String='SHOW_PUZZLE_READY';
		public static var SHOW_NEXTDOC:String="SHOW_NEXTDOC";
		
		
		
		
		
		
		
		static protected const EVENT_CHANNEL_NAME:String = 'gameControllerEventChannel';
		
		public function GameControllerEvent(type:String, initialData:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, initialData, bubbles, cancelable);
		}
		
		override public function dispatch():void 
		{
			GameControllerEvent.channel.dispatchEvent(this);
		}
		
		/**
		 * Alias pour un (new NavigationEvent(type, initialData)).dispatch() qui diffusera
		 * l'événement type dans l'EventChannel de ces événements
		 * 
		 * @param type
		 * @param initialData
		 * @return 
		 * 
		 */
		static public function dispatch(type:String, initialData:Object=null):GameControllerEvent
		{
			var notif:GameControllerEvent = new GameControllerEvent(type, initialData);
			notif.dispatch();
			return notif;
		}
		
		
		static private var _channel:EventChannel; 
		
		
		
		
		
		
		static public function get channel():EventChannel
		{
			if (_channel == null) {
				_channel = EventChannel.get(EVENT_CHANNEL_NAME);
			}
			return _channel;
		}
	}
}