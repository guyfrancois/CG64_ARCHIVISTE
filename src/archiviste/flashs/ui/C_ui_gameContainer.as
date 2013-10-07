package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	import archiviste.model.OG_ABS;
	import archiviste.view.I_GameModelView;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import pt.utils.Clips;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_gameContainer
	 */
	public class C_ui_gameContainer extends Sprite
	{
		
		
		
		public function C_ui_gameContainer()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
			
		}
		
	
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_GAME_CONCLUSION,evt_showConclusion,false);
		}
		
		protected function evt_added(event:Event):void
		{
			init();
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_GAME_CONCLUSION,evt_showConclusion,false,0,true);
			
			
		}
		
		protected function evt_showConclusion(event:GameControllerEvent):void
		{
			//init();
		}
		
		private function init():void{
			var key:String = GameController.instance.currentSalle;
			var lvl:String = GameController.instance.currentLvl;
			// trouver le type de jeu associé à cette salle
			
			var gameView:I_GameModelView;
			if (GameController.instance.gameMemoryExist(key)) {
				gameView = GameController.instance.gameMemoryGet(key);
			} else {
				// trouver la base XML, associer la bonne classe
				
				gameView = GameController.instance.gameMemoryKeep(buildZoneJeu(OG_ABS.getOGByIdLvl(key,lvl)));
			}
			// créer ou recharger le jeu associé à la salle
			addChild(gameView as Sprite);
			
		}
		
		
		private function buildZoneJeu(model:OG_ABS):I_GameModelView {
			
			var cl:Class=Clips.classFromLib("libZoneJeu_"+model.type,GameController.instance.main.loaderInfo.applicationDomain);
			var item:I_GameModelView= new  cl() as I_GameModelView;
			item.setModel(model);
			return item;
		}
	}
}