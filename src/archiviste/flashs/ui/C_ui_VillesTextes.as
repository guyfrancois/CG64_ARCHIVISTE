package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	
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
	public class C_ui_VillesTextes extends Sprite
	{
		// elements present sur la scene
		public var titre:C_ui_TlfTextId;
		public var texte:C_ui_TlfTextId;
		//
		public function C_ui_VillesTextes()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void
		{
			// TODO Auto-generated method stub
		
			titre.id="titre_villes";
			texte.id="texte_villes";
			
		}
	}
}