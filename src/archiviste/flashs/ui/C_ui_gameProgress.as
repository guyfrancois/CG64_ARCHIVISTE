package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [2 oct. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_gameProgress
	 */
	public class C_ui_gameProgress extends MovieClip
	{
		
		public function C_ui_gameProgress()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
			if (GameController.DEBUG) {
				addEventListener(MouseEvent.CLICK,evt_clickDebug,false,0,true);
			}
		}
		
		protected function evt_clickDebug(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			NavigationEvent.dispatch(NavigationEvent.BTN_PUZZLE_CLICKED);
		}
		
		protected function evt_removed(event:Event):void
		{
			// TODO Auto-generated method stub
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_PROGRESSION_UPDATE,evt_progressUpdate);
		}
		
		protected function evt_added(event:Event):void
		{
			// TODO Auto-generated method stub
			
			updateProgression(GameController.instance.progression);
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_PROGRESSION_UPDATE,evt_progressUpdate);
		}
		
		protected function evt_progressUpdate(event:GameControllerEvent):void
		{
			// TODO Auto-generated method stub
			updateProgression(event.data as Number);
		}
		
		private function updateProgression(val:Number):void {
			gotoAndStop(val+1);
		}
	}
}