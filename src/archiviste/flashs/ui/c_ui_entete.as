package archiviste.flashs.ui
{
	import archiviste.events.NavigationEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 oct. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.c_ui_entete
	 */
	public class c_ui_entete extends Sprite
	{
		
		public function c_ui_entete()
		{
			super();
			buttonMode=true;
			addEventListener(MouseEvent.CLICK,evt_click,false,0,true);
		}
		
		protected function evt_click(event:MouseEvent):void
		{
			NavigationEvent.dispatch(NavigationEvent.BTN_RECOMMENCER_CLICKED);
		}
	}
}