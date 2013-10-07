package archiviste.flashs.ui
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [3 oct. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_BlocPuzzle
	 */
	public class C_ui_BlocPuzzle extends Sprite
	{
		
		public function C_ui_BlocPuzzle()
		{
			visible=false;
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		//GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_PUZZLE_READY,evt_showConclusion,false);
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_PUZZLE_READY,evt_show,false);
			}
		
		protected function evt_added(event:Event):void
		{
			
			if (GameController.instance.isProgessComplete()) evt_show(null);
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_PUZZLE_READY,evt_show,false,0,true);
			
		}
		
		protected function evt_show(event:Event):void
		{
			visible=true;
		}
	}
}