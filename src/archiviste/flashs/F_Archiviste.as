package archiviste.flashs
{
	import archiviste.controllers.DataCollection;
	import archiviste.controllers.GameController;
	import archiviste.controllers.PuzzleDeliver;
	import archiviste.events.GameControllerEvent;
	import archiviste.model.OG_ABS;
	
	import flash.display.MovieClip;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import pt.utils.Cursors;
	
	import utils.events.EventChannel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.F_Archiviste
	 */
	public class F_Archiviste extends MovieClip
	{
		
		public function F_Archiviste()
		{
			super();
			gotoAndStop(1);
			if (stage) evt_added();
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event=null):void
		{
			var textsColl:DataCollection = DataCollection.instance;
			if (textsColl.xmlLoaded) onXmlDatasReady();
			else textsColl.addEventListener(Event.COMPLETE, onXmlDatasReady, false, 0, true);
			
			
		}
		
		protected function onXmlDatasReady(event:Event=null):void
		{
			OG_ABS.keepfeedFromList(DataCollection.instance.loadedXML.texts.game);
			initContents();
		}
		
		private function initContents():void
		{
			initGameControllerEventListeners();
			initContextMenu();
			GameController.instance.main = this;
			PuzzleDeliver.instance.initPuzzle();
			Cursors.registerCursorFromLib("CURS_ZOOM",this.loaderInfo.applicationDomain);
			
		}		
		
		private function initGameControllerEventListeners():void
		{
			var gameChannel:EventChannel = GameControllerEvent.channel;
			gameChannel.addEventListener(GameControllerEvent.SHOW_LVL,evt_show_lvl,false,0,true);
			gameChannel.addEventListener(GameControllerEvent.SHOW_VILLES,evt_show_villes,false,0,true);
			gameChannel.addEventListener(GameControllerEvent.SHOW_PLAN,evt_show_plan,false,0,true);
			gameChannel.addEventListener(GameControllerEvent.SHOW_SALLE,evt_show_salle,false,0,true);
			gameChannel.addEventListener(GameControllerEvent.SHOW_GAME,evt_show_game,false,0,true);
			gameChannel.addEventListener(GameControllerEvent.SHOW_PUZZLE,evt_show_puzzle,false,0,true);
			
		}
		
		protected function evt_show_lvl(event:Event):void
		{
			gotoAndStop("STATE_LVL");
			
		}
		
		protected function evt_show_villes(event:Event):void
		{
			gotoAndStop("STATE_VILLES");
		}
		
		protected function evt_show_plan(event:Event):void
		{
			gotoAndStop("STATE_PLAN");
		}
		
		protected function evt_show_salle(event:Event):void
		{
			gotoAndStop("STATE_SALLE");
		}
		
		protected function evt_show_game(event:Event):void
		{
			gotoAndStop("STATE_GAME");
		}
		
		protected function evt_show_puzzle(event:Event):void
		{
			gotoAndStop("STATE_PUZZLE");
		}		
		
		
	
		
		/**
		 * initialisation de menu contextuel
		 */
		private function initContextMenu():void {
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			var cmi:ContextMenuItem;
			
			
			
			
			cmi = new ContextMenuItem("version "+DataCollection.params.getString('version') + " du "+DataCollection.params.getString('versionDate'), true,false);
			cm.customItems.push(cmi);
			
			cmi = new ContextMenuItem("Réalisation Pense-Tête", true,true);
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onPenseTeteSelected);
			cm.customItems.push(cmi);
			
			this.contextMenu = cm;
			
		}
		protected function onPenseTeteSelected(event:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest('http://www.pense-tete.com/'));
		}	
		
	}
}