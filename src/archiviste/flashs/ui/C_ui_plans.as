package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_plans
	 */
	public class C_ui_plans extends MovieClip
	{
		
		public function C_ui_plans()
		{
			super();
			stop();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_PLAN,evt_showPlan,false);
		}
		
		protected function evt_added(event:Event):void
		{
			init();
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_PLAN,evt_showPlan,false,0,true);
		}
		
		protected function evt_showPlan(event:GameControllerEvent):void
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