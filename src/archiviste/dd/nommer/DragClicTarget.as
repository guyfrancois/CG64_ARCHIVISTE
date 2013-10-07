package archiviste.dd.nommer
{
	import archiviste.events.GameControllerEvent;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.model.OG_NommerSeries;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import pensetete.dragDrop.ABS_DragClicTarget;
	import pensetete.dragDrop.EventDragClic;
	import pensetete.dragDrop.I_DragClicTarget;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [28 sept. 2012][GUYF] creation
	 *
	 * archiviste.dd.DragClicTarget
	 */
	public class DragClicTarget extends ABS_DragClicTarget implements I_DragClicTarget
	{
		public static var GAMECOMPLETE:String="GAMECOMPLETE";
		public static var GAMEINCOMPLETE:String="GAMEINCOMPLETE";
		
		/* elements presents sur la scene */
		public var texte:C_ui_TlfTextDyn_fix;
		
		/*---------------------------------*/
		private var model:OG_NommerSeries;
		public function DragClicTarget()
		{
			super();
			texte.visible=false;
			//buttonMode=true;
			
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		override protected function evt_removed(event:Event):void
		{
			// TODO Auto Generated method stub
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon);
			super.evt_removed(event);
		}
		
		
		protected function evt_added(event:Event):void
		{
			if (isEnable()) GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon);
			if (!isEnable()) dispatchEvent(new Event(DragClicTarget.GAMECOMPLETE));
			else dispatchEvent(new Event(DragClicTarget.GAMEINCOMPLETE));
		}		
		
		protected function evt_abandon(event:Event):void
		{
			if (isEnable() ) {
				gotoAndStop(3);
				_enable=false;
				texte.visible=true;
				dispatchEvent(new Event(DragClicTarget.GAMECOMPLETE));
			} 
		}		
		
		
		 public function setModel(model:OG_NommerSeries):void {
			this.model=model;
			texte.htmlText=model.titre;
			
		}
		
		 override public function getIds():Array {
			return [model.rep.toString()];
		}
		 
		 override protected function evt_dragMoverPress(event:EventDragClic):void
		 {
			 var gP:Point=localToGlobal(new Point(mouseX,mouseY));
			 if (isEnable() &&  hitTestPoint(gP.x,gP.y,true)) {
				 if (isTargetOf(event.idItem) ) {
					 new EventDragClic(EventDragClic.DRAG_MOVER_ACTION,event.idItem,this).dispatch();	
				 } else {
					 gotoAndStop(1);
					 new EventDragClic(EventDragClic.DRAG_MOVER_ACTION,"false",this).dispatch();	
				 }
			 }
			 
		 }
		
		 override protected  function evt_dragMoverAction(event:EventDragClic):void
		 {
			 if (isEnable() && isTargetOf(event.idItem)) {
				 gotoAndStop(3);
				_enable=false;
				texte.visible=true;
				dispatchEvent(new Event(DragClicTarget.GAMECOMPLETE));
			 } 
		 }		
		 
		
		
		
		 override public function setMoverOver(val:Boolean):void
		{
			 if (!isEnable()) return;
			 if (val) {
				 gotoAndStop(2);
			 } else {
				 gotoAndStop(1);
			 }
		}
		 
		
		
		
	}
}