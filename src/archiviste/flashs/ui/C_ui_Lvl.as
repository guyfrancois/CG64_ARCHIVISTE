package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.NavigationEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_retourPlan
	 */
	public class C_ui_Lvl extends MovieClip
	{
		
		public function C_ui_Lvl()
		{
			super();
			stop();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void
		{
			init();
		}
		
		private function init():void{
			switch(GameController.instance.currentLvl)
			{
				case GameController.LVL_DIFFICILE:
				{
					gotoAndStop(2);
					break;
				}
					
				default://GameController.LVL_FACILE
				{
					gotoAndStop(1);
					break;
				}
			}
		}
		
	}
}