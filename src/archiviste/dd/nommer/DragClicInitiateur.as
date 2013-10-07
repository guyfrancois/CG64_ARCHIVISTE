package archiviste.dd.nommer
{
	import archiviste.events.GameControllerEvent;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_NommerDoc;
	import archiviste.model.OG_NommerSeries;
	import archiviste.view.TextDechiffrerView;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import pensetete.dragDrop.ABS_DragInitiator;
	import pensetete.dragDrop.EventDragClic;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [28 sept. 2012][GUYF] creation
	 *
	 * archiviste.dd.DragClicInitiateur
	 */
	public class DragClicInitiateur extends ABS_DragInitiator
	{
		public static var IDLE:Number=1;
		public static var OVER:Number=2;
		public static var CHECK:Number=3;
		public static var UNCHECK:Number=4;
		
		public var titre:C_ui_TlfTextDyn_fix;
		public var rep:MovieClip;
		
		private var model:OG_NommerSeries;
		
		public function setModel(model:OG_NommerSeries):void {
			this.model=model;
			titre.htmlText=model.titre;
		}
		
		public function getModel():OG_NommerSeries {
			return model;
		}
		
		override public function getId():String {
			return model.rep.toString();
		}
		
		override public function getHoldEventKey():String {
			return MouseEvent.MOUSE_DOWN;
		}
		
	
		
		private var isMoving:Boolean=false;
		
		public function DragClicInitiateur()
		{
			super();
			rep.visible=false;
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false);
			
			EventDragClic.channel.removeEventListener(EventDragClic.DRAG_MOVER_PRESS,evt_dragMoverCancel);
			EventDragClic.channel.removeEventListener(EventDragClic.DRAG_MOVER_ACTION,evt_dragMoverAction);
		}
		
		protected function evt_added(event:Event):void
		{
			
			if (isEnable()){
				GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false,0,true);
				//EventDragClic.channel.addEventListener(EventDragClic.DRAG_INITIATOR_CLICK,evt_dragInitiatorClick,false,0,true);
				EventDragClic.channel.addEventListener(EventDragClic.DRAG_MOVER_PRESS,evt_dragMoverCancel,false,0,true);
				EventDragClic.channel.addEventListener(EventDragClic.DRAG_MOVER_ACTION,evt_dragMoverAction,false,0,true);
				dispatchEvent(new Event(TextDechiffrerView.GAMEINCOMPLETE));
			} else {
				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
			}
		}
		protected function evt_abandon(event:Event):void
		{
			if (!_enable) return;
			if ( getId()=="true") {
				gotoAndStop(CHECK);
				isMoving=false;
				_enable=false;
				initInteractionOff();
				
				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
				
			} else {
				gotoAndStop(UNCHECK);
				isMoving=false;
				_enable=false;
				initInteractionOff();
				
			}
		}
		
		
		private function onComplete_repVisibleFalse():void {
			TweenMax.to(rep,1,{alpha:0,visible:false});
		}
		
		protected function evt_dragMoverAction(event:EventDragClic):void
		{
			if (!_enable) return;
			if (event.idItem=="false" ) {
				if ( isMoving) {
				gotoAndStop(UNCHECK);
				isMoving=false;
				_enable=false;
				initInteractionOff();
				rep.alpha=1;
				rep.visible=true;
				rep.scaleX=rep.scaleY=0;
				TweenMax.to(rep,1,{scaleX:1,scaleY:-1,onComplete:onComplete_repVisibleFalse});
				}
				return;
			}
			if (event.idItem == getId()) {
				gotoAndStop(CHECK);
				isMoving=false;
				_enable=false;
				initInteractionOff();
				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
				rep.alpha=1;
				rep.visible=true;
				rep.scaleX=rep.scaleY=0;
				TweenMax.to(rep,1,{scaleX:1,scaleY:1,onComplete:onComplete_repVisibleFalse});
				
			} else {
				gotoAndStop(UNCHECK);
				isMoving=false;
				_enable=false;
				initInteractionOff();
				rep.alpha=1;
				rep.visible=true;
				rep.scaleX=rep.scaleY=0;
				TweenMax.to(rep,1,{scaleX:1,scaleY:1,onComplete:onComplete_repVisibleFalse});
				
			}
		}
		
		private function evt_dragMoverCancel(event:EventDragClic):void
		{
			if (_enable && event.idItem == getId()) {
				gotoAndStop(IDLE);
				isMoving=false;
			}
		}
		
		override protected function evtOut(e:Event):void
		{
			// TODO Auto Generated method stub
			super.evtOut(e);
			if (isEnable()) {
				if (isMoving) gotoAndStop(OVER);
				else  gotoAndStop(IDLE);
				
			} else {
				
			}
		}
		
		override protected function evtOver(e:Event):void
		{
			// TODO Auto Generated method stub
			super.evtOver(e);
			
			gotoAndStop(OVER);
		}
		
		override protected function evt_click(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			isMoving=true;
			super.evt_click(event);
			
		}
		
		
	}
}