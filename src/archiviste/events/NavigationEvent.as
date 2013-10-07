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
	public class NavigationEvent extends ArchivisteEvent
	{
		// --------------------------------------------------------------------
		// ELEMENTS GENERIQUES ------------------------------------------------
		// --------------------------------------------------------------------
		
		static public const DO_SALLE_CLICKED:String 		= "DO_SALLE_CLICKED";
		static public const DO_GAME_CLICKED:String 			= "DO_GAME_CLICKED";
		
		static public const DO_VALIDER:String 				= "DO_VALIDER";
		static public const DO_INVALIDER:String 			= "DO_INVALIDER";
		
		static public const DO_VALIDER_SALLE:String 			= "DO_VALIDER_SALLE";
		
		
		
		// --------------------------------------------------------------------
		// BOUTONS CLASS ------------------------------------------------
		// --------------------------------------------------------------------
		
		static public const BTN_FACILE_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_facile");
		static public const BTN_DIFFICILE_CLICKED:String 		= C_BtnClass.getClicEvent("lib_btn_difficile");
		static public const BTN_PLAN_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_plan");
		static public const BTN_ENQSUIVANT_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_enqSuivant");
		
		static public const BTN_BAT1_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_bat1");
		static public const BTN_BAT2_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_bat2");
		static public const ONGLET_BAT1_CLICKED:String 			= C_BtnClass.getClicEvent("lib_onglet_bat1");
		static public const ONGLET_BAT2_CLICKED:String 			= C_BtnClass.getClicEvent("lib_onglet_bat2");
		static public const BTN_ABANDON_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_abandon");
		static public const BTN_DOCSUIVANT_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_docSuivant");
		static public const BTN_PUZZLE_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_puzzle");
		
		static public const BTN_RECOMMENCER_CLICKED:String 			= C_BtnClass.getClicEvent("lib_btn_recommencer");
		
		// --------------------------------------------------------------------
		// INTERNE AU JEUX CLASS ------------------------------------------------
		// --------------------------------------------------------------------
		public static var SEND_PUZZLE_PIECE:String="SEND_PUZZLE_PIECE";
		
				
		
		
		
		
		static protected const EVENT_CHANNEL_NAME:String = 'archivisteNavigationChannel';
		
		public function NavigationEvent(type:String, initialData:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, initialData, bubbles, cancelable);
		}
		
		override public function dispatch():void 
		{
			NavigationEvent.channel.dispatchEvent(this);
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
		static public function dispatch(type:String, initialData:Object=null):NavigationEvent
		{
			var notif:NavigationEvent = new NavigationEvent(type, initialData);
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