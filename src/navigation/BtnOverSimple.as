package navigation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BtnOverSimple extends MovieClip
	{
		public var activation:Boolean=true;
		public var visited:Boolean=false;
		public var image:String;
		public var i:int;
		public var countClick:int=0;
		public function BtnOverSimple()
		{
			super();
			initInteraction();
		}
		
		private function initInteraction():void {
			mouseChildren=false;
			buttonMode=true;
			addEventListener(MouseEvent.MOUSE_OVER,evtOver);
			addEventListener(MouseEvent.MOUSE_OUT,evtOut);
		}
		
		private function evtOver(e:Event):void {
			if(activation==true)gotoAndPlay(2);
		}
		private function evtOut(e:Event):void {
			if(activation==true){
				if(visited==true){
					gotoAndPlay(3);
				}else{
					gotoAndStop(1);
				}
			}
			
			
		}
		
	}
}