package archiviste.dd.classer
{
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.model.OG_ClasserSeries;
	
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
		public var cadre:MovieClip;
		
		/*---------------------------------*/
		private var model:OG_ClasserSeries;
		public function DragClicTarget()
		{
			super();
			cadre.stop();
		//	buttonMode=true;
			
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void
		{
			
			if (!isEnable()) dispatchEvent(new Event(DragClicTarget.GAMECOMPLETE));
			else dispatchEvent(new Event(DragClicTarget.GAMEINCOMPLETE));
		}		
		
		
		
		 public function setModel(model:OG_ClasserSeries):void {
			this.model=model;
			texte.htmlText=model.titre;
			cadre.img.visible=false;
			getImage(model.vignette);
		}
		
		 override public function getIds():Array {
			return [model.idSerie];
		}
		 
		 override protected function evt_dragMoverPress(event:EventDragClic):void
		 {
			 var gP:Point=localToGlobal(new Point(mouseX,mouseY));
			 if (isEnable() &&  hitTestPoint(gP.x,gP.y,true)) {
				 if (isTargetOf(event.idItem) ) {
					 new EventDragClic(EventDragClic.DRAG_MOVER_ACTION,event.idItem,this).dispatch();	
				 } else {
					 cadre.gotoAndStop(1);
				 }
			 }
			 
		 }
		
		 override protected  function evt_dragMoverAction(event:EventDragClic):void
		 {
			 if (isEnable() && isTargetOf(event.idItem)) {
				 cadre.img.visible=true;
				 cadre.gotoAndStop(3);
				 
				_enable=false;
			 } 
		 }		
		 
		
		
		
		 override public function setMoverOver(val:Boolean):void
		{
			 if (!isEnable()) return;
			 if (val) {
				 cadre.gotoAndStop(2);
			 } else {
				 cadre.gotoAndStop(1);
			 }
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
		
		
	}
}