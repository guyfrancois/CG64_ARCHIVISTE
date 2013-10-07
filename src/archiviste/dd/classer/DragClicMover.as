package archiviste.dd.classer
{
	import archiviste.model.OG_ClasserDoc;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import pensetete.dragDrop.ABS_DragClicMover;
	import pensetete.dragDrop.I_DragClicMover;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [28 sept. 2012][GUYF] creation
	 *
	 * archiviste.dd.DragClicMover
	 */
	public class DragClicMover extends ABS_DragClicMover implements I_DragClicMover
	{
		public var cadre:MovieClip;
		private var model:OG_ClasserDoc;
		public function setModel(model:OG_ClasserDoc):void {
			this.model=model;
			getImage(model.vignette);
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
			//_width=rep.x=Math.min(container.img.width,container.masque.width);
			
		}
		
		public function getModel():OG_ClasserDoc {
			return model;
		}
		
		override public function getFreeEventKey():String {
			return MouseEvent.MOUSE_UP;
		}
		
		override public function getId():String
		{
			// TODO Auto Generated method stub
			return model.idSerie
		}
		
		public function DragClicMover()
		{
			super();
		}
		
		
		
		override public function setInZone(val:Boolean):void
		{
			visible=val;
		}
		
		override public function setOver(val:Boolean):void
		{
			if (val) cadre.gotoAndStop(2);
			else cadre.gotoAndStop(1);
		}
		
	}
}