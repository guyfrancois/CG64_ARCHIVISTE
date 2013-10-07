package archiviste.flashs.ui
{
	import archiviste.events.NavigationEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import pt.utils.Clips;
	
	import utils.movieclip.MovieClipUtils;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [2 oct. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_pieceShow
	 */
	public class C_ui_pieceShow extends MovieClip
	{
		public var content:MovieClip;
		public function C_ui_pieceShow()
		{
			super();
			stop();
			visible=false;
			mouseChildren=false;
			mouseEnabled=false;
			//NavigationEvent.dispatch(NavigationEvent.SEND_PUZZLE_PIECE,v_pieces[GameController.instance.progression-1]);
			
			
			NavigationEvent.channel.addEventListener(NavigationEvent.SEND_PUZZLE_PIECE,evt_pieceToShow);
		}
		
		protected function evt_pieceToShow(event:NavigationEvent):void
		{
			// TODO Auto-generated method stub
			gotoAndPlay(1);
			MovieClipUtils.removeAllChilds(content);
			content.addChild(event.data as DisplayObject);
			
			visible=true;
			
			
		}
	}
}