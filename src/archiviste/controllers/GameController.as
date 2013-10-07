package archiviste.controllers
{
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	import archiviste.model.OG_ABS;
	import archiviste.view.I_GameModelView;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import utils.MyTrace;
	import utils.events.EventChannel;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * archiviste.controllers.GameController
	 */
	public class GameController
	{
		public static var DEBUG:Boolean=false;
		public var gameMemory:Dictionary;
		
		
		private var _currentState:String = STATE_INIT;
		
		// ETATS GLOBAL DU JEU
		static public const STATE_INIT:String        				= 'STATE_INIT';
		static public const STATE_LVL:String        				= 'STATE_LVL';
		static public const STATE_VILLES:String        				= 'STATE_VILLES';
		static public const STATE_PLAN:String        				= 'STATE_PLAN';
		static public const STATE_SALLE:String        				= 'STATE_SALLE';
		static public const STATE_GAME:String        				= 'STATE_GAME';
		static public const STATE_GAME_CONCLUSION:String        	= 'STATE_GAME_CONCLUSION';
		static public const STATE_PUZZLE:String        				= 'STATE_PUZZLE';
		static public const STATE_PUZZLE_CONCLUSION:String        	= 'STATE_PUZZLE_CONCLUSION';
		
		// NIVEAUX
		static public const LVL_FACILE:String		= 'facile';
		static public const LVL_DIFFICILE:String	= 'difficile';
		
		static public const BAT_1:String	= 'BAT_1';
		static public const BAT_2:String	= 'BAT_2';
		
		
		public var currentLvl:String;
		public var currentBat:String;
		
		public var currentSalle:String;
		
		public var main:MovieClip;
		
		private var _progression:Number=0;
		private var _progressionMax:Number=6;
		public function get progression():Number {
			return _progression;
		}
		
		public function get currentState():String
		{
			return _currentState;
		}
		
		public function set currentState(value:String):void
		{
			MyTrace.put("currentState ---------->"+value);
			
			_currentState = value;
		}
		
		/* Gestion du singleton */
		static protected var _instance:GameController;
		static public function get instance():GameController
		{
			return (_instance != null) ? _instance : new GameController();
			
		}
		
		public function GameController()
		{
			if (_instance != null) return;
			_instance = this;
			initNavigationListeners();
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_LVL);
			currentState=STATE_LVL;
			
			gameMemoryReset()
			
		}
		
		
		private function initNavigationListeners():void {
			// On se prépare à écouter les événements importants
			var navigChan:EventChannel = NavigationEvent.channel;
			// Ecoute des événements généras suites aux actions de l'utilisateur
			navigChan.addEventListener(NavigationEvent.DO_VALIDER_SALLE, onValidationSalle_handler);
			navigChan.addEventListener(NavigationEvent.BTN_RECOMMENCER_CLICKED, onRecommencer_handler);
			
			navigChan.addEventListener(NavigationEvent.DO_VALIDER, onValidation_handler);
			navigChan.addEventListener(NavigationEvent.DO_INVALIDER, onInValidation_handler);
			navigChan.addEventListener(NavigationEvent.DO_GAME_CLICKED, onGame_handler);
			navigChan.addEventListener(NavigationEvent.DO_SALLE_CLICKED, onSalle_handler);
			navigChan.addEventListener(NavigationEvent.BTN_FACILE_CLICKED, onFacile_handler);
			navigChan.addEventListener(NavigationEvent.BTN_DIFFICILE_CLICKED, onDifficie_handler);
		
			
			navigChan.addEventListener(NavigationEvent.BTN_ENQSUIVANT_CLICKED, onPlan_handler);
			navigChan.addEventListener(NavigationEvent.BTN_PLAN_CLICKED, onPlan_handler);
			navigChan.addEventListener(NavigationEvent.BTN_BAT1_CLICKED, onBat1_handler);
			navigChan.addEventListener(NavigationEvent.BTN_BAT2_CLICKED, onBat2_handler);
			navigChan.addEventListener(NavigationEvent.ONGLET_BAT1_CLICKED, onBat1_handler);
			navigChan.addEventListener(NavigationEvent.ONGLET_BAT2_CLICKED, onBat2_handler);
			
			navigChan.addEventListener(NavigationEvent.BTN_ABANDON_CLICKED, onAbandon_handler);
			navigChan.addEventListener(NavigationEvent.BTN_PUZZLE_CLICKED, onPuzzle_handler);
			navigChan.addEventListener(NavigationEvent.BTN_DOCSUIVANT_CLICKED, onDocSuivant_handler);
		}
		
		protected function onRecommencer_handler(event:Event):void
		{
			gameMemoryReset()
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_LVL);
			currentState=STATE_LVL;
			
			
		}
		
		protected function onDocSuivant_handler(event:Event):void
		{
			// TODO Auto-generated method stub
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_NEXTDOC);
		}		
				
		
		
		protected function onDifficie_handler(event:Event):void
		{
			if (currentState==STATE_LVL) {
				currentLvl=LVL_DIFFICILE;
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_VILLES);
				currentState=STATE_VILLES;
				NavigationEvent.dispatch(NavigationEvent.DO_VALIDER_SALLE)
			} else {
				helper_ERREUR_ETAT("onDifficie_handler");
			}
		}
		
		protected function onFacile_handler(event:Event):void
		{
			if (currentState==STATE_LVL) {
				currentLvl=LVL_FACILE;
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_VILLES);
				currentState=STATE_VILLES;
				NavigationEvent.dispatch(NavigationEvent.DO_VALIDER_SALLE)
			} else {
				helper_ERREUR_ETAT("onDifficie_handler");
			}
		}
		
		protected function onBat1_handler(event:Event):void
		{
			if (currentState==STATE_PLAN || currentState==STATE_VILLES) {
				currentBat=BAT_1;
				onPlan_handler(null);
			}
		}		
		
		protected function onBat2_handler(event:Event):void
		{
			if (currentState==STATE_PLAN || currentState==STATE_VILLES) {
				currentBat=BAT_2;
				onPlan_handler(null);
			}
		}
		

		
		protected function onPlan_handler(event:Event):void
		{
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_PLAN);
			currentState=STATE_PLAN;
		}
		
		
		
		protected function onAbandon_handler(event:Event):void
		{
			switch(currentState)
			{
				case STATE_PUZZLE:
				{
					GameControllerEvent.dispatch(GameControllerEvent.SHOW_PUZZLE_CONCLUSION);
					break;
				}
				case STATE_GAME:
				{
					GameControllerEvent.dispatch(GameControllerEvent.ASK_GAME_CONCLUSION);
					break;
				}
					
				default:
				{
					helper_ERREUR_ETAT('onAbandon_handler');
					break;
				}
			}
			
		}

		
		protected function onInValidation_handler(event:NavigationEvent):void
		{
			GameControllerEvent.dispatch(GameControllerEvent.ASK_GAME_INTRODUCTION,event.data);
		}
		
		protected function onValidation_handler(event:NavigationEvent):void
		{
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_GAME_CONCLUSION,event.data);
		}
		
		protected function onSalle_handler(event:NavigationEvent):void
		{
			if (currentState==STATE_PLAN) {
				currentSalle=event.data as String;
				MyTrace.put("onSalle_handler ---------->"+currentSalle);
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_SALLE,currentSalle);
				currentState=STATE_SALLE;
			}
		}
		
		protected function onGame_handler(event:NavigationEvent):void
		{
			if (currentState==STATE_PLAN || currentState==STATE_SALLE) {
				
				currentSalle=event.data as String;
				MyTrace.put("onGame_handler ---------->"+currentSalle);
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_GAME,currentSalle);
				currentState=STATE_GAME;
			}
			
		}
		
		public function isProgessComplete():Boolean{
			return _progression==_progressionMax;
		}
		protected function onValidationSalle_handler(event:NavigationEvent):void
		{
			// TODO : valider la progression
			// une salle vient d'etre terminer -> afficher une piece du puzzle
			// incrementer la progression
			// afficher le bouton d'accès au puzzle lorsque la progession atteint le max
			trace("onValidationSalle_handler");
			if (isProgessComplete()) return;
			_progression++;
			
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_PROGRESSION_UPDATE,_progression);	
			if (isProgessComplete()) {
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_PUZZLE_READY);	
			}
		}
		
		
		protected function onPuzzle_handler(event:NavigationEvent):void
		{
				currentSalle=OG_ABS.TYPE_PUZZLE;
				
				MyTrace.put("onPuzzle_handler ---------->"+currentSalle);
				GameControllerEvent.dispatch(GameControllerEvent.SHOW_PUZZLE,currentSalle);
				currentState=STATE_PUZZLE;
			
		}
		
		public function etatSalle(key:String):Boolean{
			
			var lvl:String = GameController.instance.currentLvl;
			// trouver le type de jeu associé à cette salle
			
			
			if (GameController.instance.gameMemoryExist(key)) {
				return GameController.instance.gameMemoryGet(key).isComplete()
			} else {
				return false;
			}
		
		}
		
		
		public function gameMemoryReset():void {
			gameMemory=new Dictionary();
			_progression=0;
			GameControllerEvent.dispatch(GameControllerEvent.SHOW_PROGRESSION_UPDATE,0);	
		}
		
		public static var lastGameView:I_GameModelView;
		public function gameMemoryExist(gameKey:String):Boolean {
			return (gameMemory[gameKey] != null);
		}
		public function gameMemoryKeep(GameItem:I_GameModelView):I_GameModelView {
			return lastGameView=gameMemory[GameItem.getId()] = GameItem;
		}
		public function gameMemoryGet(gameKey:String):I_GameModelView {
			return lastGameView=gameMemory[gameKey];
		}
		
		private function helper_ERREUR_ETAT(msg:String):void {
			MyTrace.put("ERREUR_ETAT "+msg+" -> "+currentState+" non gere",MyTrace.LEVEL_ERROR);
		}
	}
}