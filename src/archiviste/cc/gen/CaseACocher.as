package archiviste.cc.gen
{
	import archiviste.events.GameControllerEvent;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_ABS_CocheSeries;
	
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import pensetete.dragDrop.EventDragClic;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [2 oct. 2012][GUYF] creation
	 *
	 * archiviste.cc.gen.CaseACocher
	 */
	public class CaseACocher extends MovieClip
	{
		public static var COMPLETE:String="COMPLETE";
		public static var IDLE:Number=1;
		public static var OVER:Number=2;
		public static var CHECK:Number=3;
		public static var UNCHECK:Number=4;
		
		/* elements presents sur la scene */
		public var rep : MovieClip;
		
		public var titre:C_ui_TlfTextDyn_fix;
		
		/**********************************/
		
		public var isRep:Boolean;
		public var isCheck:Boolean;
		
		private var _isEnable:Boolean=true;
		
		public function isEnable():Boolean
		{
			// TODO Auto Generated method stub
			return _isEnable;
		}
		
		
		public function CaseACocher()
		{
			super();
			stop();
			rep.visible=false;
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false);
		}
		
		protected function evt_added(event:Event):void
		{
			
			if (isEnable()){
				GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false,0,true);
//				dispatchEvent(new Event(TextDechiffrerView.GAMEINCOMPLETE));
				addEventListener(MouseEvent.MOUSE_OVER,evt_over,false,0,true);
				addEventListener(MouseEvent.MOUSE_OUT,evt_out,false,0,true);
				addEventListener(MouseEvent.CLICK,evt_click,false,0,true);
				
			} else {
//				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
			}
		}
		
		protected function evt_out(event:MouseEvent):void
		{
			if (isEnable()) gotoAndStop(IDLE);
			
		}
		
		protected function evt_over(event:MouseEvent):void
		{
			if (isEnable()) gotoAndStop(OVER);
		}
		
		protected function evt_click(event:MouseEvent):void
		{
			showReponse();
			if (isRep) {
				rep.alpha=1;
				rep.visible=true;
				rep.scaleX=rep.scaleY=0;
				TweenMax.to(rep,1,{scaleX:1,scaleY:1,onComplete:onComplete_repVisibleFalse});
			} else {
				rep.alpha=1;
				rep.visible=true;
				rep.scaleX=rep.scaleY=0;
				TweenMax.to(rep,1,{scaleX:1,scaleY:-1,onComplete:onComplete_repVisibleFalse});
			}
			dispatchEvent(new Event(COMPLETE));
		}		
		private function onComplete_repVisibleFalse():void {
			TweenMax.to(rep,1,{alpha:0,visible:false});
		}
		
		public function showReponse():void {
			_isEnable=false;
			if (isRep) {
				gotoAndStop(CHECK);
			} else {
				gotoAndStop(UNCHECK);
			}
			
		}
		
		
		
		protected function evt_abandon(event:Event):void
		{
			showReponse()
		}
		
		/* a transferer dans l'heritage */
		public function setModel(model:OG_ABS_CocheSeries):void {
			isRep = model.rep;
			titre.htmlText = model.titre;
		}
		
		public function isGood():Boolean {
			return isRep==isCheck
		}
		
		
		
		
	}
}