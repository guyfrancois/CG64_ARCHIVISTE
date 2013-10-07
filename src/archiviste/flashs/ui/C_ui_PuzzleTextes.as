package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_PuzzleTextes
	 */
	public class C_ui_PuzzleTextes extends Sprite
	{
		// elements present sur la scene
		public var titre:C_ui_TlfTextId;
		public var texte:C_ui_TlfTextScrollId;
		public var blocAbandon:MovieClip;
		public var blocRecommencer:MovieClip;
		
		//
		public function C_ui_PuzzleTextes()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_INTRODUCTION,evt_showIntrodution,false);
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_GAME_CONCLUSION,evt_showConclusion,false);
			
			
			
			
		}
		
		protected function evt_added(event:Event):void
		{
			
			showTitre();
			GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_INTRODUCTION,evt_showIntrodution,false,0,true);
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_GAME_CONCLUSION,evt_showConclusion,false,0,true);
			
		}
		
		protected function showTitre():void{
			var b:Rectangle;
			
			var id:String = GameController.instance.currentSalle;
			titre.id="jeu_titre_"+id;
			b=titre.getBounds(this);
			texte.y=b.bottom+10;
			texte.visible=false;
			blocAbandon.visible=false;
			blocRecommencer.visible=false;
			
			
		}
		protected function evt_showIntrodution(event:GameControllerEvent=null):void
		{
			var b:Rectangle;
			
			var id:String = GameController.instance.currentSalle;
			texte.visible=true;
			//texte.htmlText=
			texte.id="jeu_texte_"+id;
			b=texte.getBounds(this);
			
			//blocAbandon.y=b.bottom+10;
			blocAbandon.visible=true;
			
		}
		
		protected function evt_showConclusion(event:GameControllerEvent):void
		{
			// TODO Auto-generated method stub
			texte.visible=true;
			blocAbandon.visible=false;
//			var id:String = GameController.instance.currentSalle;
//			texte.id="conclusion_texte_"+id;
			texte.htmlText=event.data as String;
			blocRecommencer.visible=true;
		}
	}
}