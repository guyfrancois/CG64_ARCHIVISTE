package archiviste.flashs.ui.boutons
{
	import archiviste.events.NavigationEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ABS_BTN extends MovieClip
	{
		/**
		 * Le type d'évenement NavigationEvent qui sera dispatché on tap 
		 */
		protected var clicEvent:String;
		protected var clicData:Object;
		
		protected var isActif:Boolean;
		
		public function ABS_BTN()
		{
			super();
			stop();
		}
		
		protected function initInteraction():void {
			mouseChildren=false;
			buttonMode=true;
			addEventListener(MouseEvent.MOUSE_OVER,evtOver);
			addEventListener(MouseEvent.MOUSE_OUT,evtOut);
		}
		
		protected function onClic_ABS_BTN(event:Event):void
		{
			if (!mouseEnabled) return;
			if (clicEvent != null) NavigationEvent.dispatch(clicEvent, clicData);
		}
		
		
		protected function evtOver(e:Event=null):void {
			if(isActif) gotoAndPlay(2);
		}
		
		protected function evtOut(e:Event=null):void {
			if(isActif){
				gotoAndStop(1);
			} else {
				gotoAndStop(3);
			}
		}
		
	}
}