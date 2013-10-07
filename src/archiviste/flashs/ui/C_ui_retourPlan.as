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
	public class C_ui_retourPlan extends MovieClip
	{
		
		public function C_ui_retourPlan()
		{
			super();
			stop();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(MouseEvent.CLICK,evtClick,false,0,true);
			
		}
		
		protected function evtClick(event:MouseEvent):void
		{
			NavigationEvent.dispatch(NavigationEvent.BTN_PLAN_CLICKED);
		}
		protected function evt_added(event:Event):void
		{
			init();
		}
		
		private function init():void{
			switch(GameController.instance.currentBat)
			{
				case GameController.BAT_2:
				{
					gotoAndStop(2);
					break;
				}
					
				default://GameController.Bat_1
				{
					gotoAndStop(1);
					break;
				}
			}
		}
		
	}
}