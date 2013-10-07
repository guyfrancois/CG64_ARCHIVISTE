package archiviste.dd.classer
{
	import archiviste.events.GameControllerEvent;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_ClasserDoc;
	import archiviste.view.TextDechiffrerView;
	
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
		
		public var cadre:MovieClip;
		
		private var model:OG_ClasserDoc;
		
		public function setModel(model:OG_ClasserDoc):void {
			this.model=model;
			getImage(model.vignette);
		}
		
		public function getModel():OG_ClasserDoc {
			return model;
		}
		
		override public function getId():String {
			return model.idSerie;
		}
		
		override public function getHoldEventKey():String {
			return MouseEvent.MOUSE_DOWN;
		}
		
		private var url:String;
		private function getImage(file:String):void {
			
			url =  ParamsHub.instance.getString('url_images'); 
			var tokens:Object = {};
			tokens.file = file ;
			
			url = TokenUtil.replaceTokens(url, tokens);
			
			var il:Loader=new Loader();
			il.contentLoaderInfo.addEventListener(Event.COMPLETE,completeImageHandler,false,0,true);
			il.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,evt_error,false,0,true);
			il.load(new URLRequest(url));
			
			
		}
		
		protected function evt_error(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			MyTrace.put("chargement impossible :"+url,MyTrace.LEVEL_ERROR);
			dispatchEvent(new Event("COMPLETE"));
		}
		
		private function completeImageHandler(e:Event ):void {
			trace(e);
			
			var item:DisplayObject=cadre.img.contenu.addChild((e.currentTarget as LoaderInfo).content);
			item.x=-item.width/2;
			item.y=-item.height/2;
		}
		
		
		public function DragClicInitiateur()
		{
			super();
			hitArea=cadre.hit;
			cadre.stop();
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
			new EventDragClic(EventDragClic.DRAG_MOVER_ACTION,getId(),this).dispatch();
		}
		
		protected function evt_dragMoverAction(event:EventDragClic):void
		{
			if (event.idItem == getId()) {
				cadre.gotoAndStop(3);
				cadre.img.visible=false;
				_enable=false;
				initInteractionOff();
				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
				
			}
		}
		
		private function evt_dragMoverCancel(event:EventDragClic):void
		{
			if (_enable && event.idItem == getId()) {
				cadre.gotoAndStop(1);
				cadre.img.visible=true;
			}
		}
		
		override protected function evtOut(e:Event):void
		{
			// TODO Auto Generated method stub
			super.evtOut(e);
			if (isEnable()) {
				if (cadre.img.visible) cadre.gotoAndStop(1);
				else cadre.gotoAndStop(2);
			} else {
				cadre.gotoAndStop(3);
			}
		}
		
		override protected function evtOver(e:Event):void
		{
			// TODO Auto Generated method stub
			super.evtOver(e);
			
			cadre.gotoAndStop(2);
		}
		
		override protected function evt_click(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.evt_click(event);
			cadre.img.visible=false;
		}
		
		
	}
}