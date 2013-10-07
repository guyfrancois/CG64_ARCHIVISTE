package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_SalleTextes
	 */
	public class C_ui_SalleTextes extends Sprite
	{
		// elements present sur la scene
		public var titre:C_ui_TlfTextId;
		public var texte:C_ui_TlfTextId;
		public var jeuAssocie:MovieClip;
		//
		public function C_ui_SalleTextes()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		
		}
		
	
		
		protected function evt_added(event:Event):void
		{
			// TODO Auto-generated method stub
			var b:Rectangle;
			
			var id:String = GameController.instance.currentSalle;
			titre.id="salle_titre_"+id;
			b=titre.getBounds(this);
			texte.y=b.bottom+10;
			
			texte.id="salle_texte_"+id;
			b=texte.getBounds(this);
			
			jeuAssocie.y=b.bottom+10;
			jeuAssocie.titre.id="jeu_titre_"+id;
			if (jeuAssocie.titre.text=='') {
				jeuAssocie.visible=false;
			}
			jeuAssocie.ico.cube.ico.visible=!GameController.instance.etatSalle(id);
				
		}
		
		
	}
}