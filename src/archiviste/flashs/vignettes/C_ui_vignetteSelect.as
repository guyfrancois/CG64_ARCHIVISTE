package archiviste.flashs.vignettes
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import org.casalib.load.ImageLoad;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.C_ui_vignetteSelect
	 * libBtnVignettes
	 */
	public class C_ui_vignetteSelect extends MovieClip
	{
		public var container:MovieClip;
		public var rep:MovieClip;
		public var pointeur:MovieClip;
		
		private var _width:Number=0;
		override public function get width():Number {
			return _width
		}
		
		public function C_ui_vignetteSelect()
		{
			super();
			rep.visible=false;
			pointeur.visible=false;
			_width=container.masque.width
			stop();
		
		}
		
		public function setVignette(imgPath:String):void {
			getImage(imgPath);
		}
		
		private var  url:String;
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
			
			container.img.addChild((e.currentTarget as LoaderInfo).content);
			_width=rep.x=Math.min(container.img.width,container.masque.width);
			dispatchEvent(new Event("COMPLETE"));
		
			pointeur.x=_width/2;
			//rep.visible=true;
			initInteraction();
		}
		
		protected function initInteraction():void {
			mouseChildren=false;
			buttonMode=true;
			addEventListener(MouseEvent.MOUSE_OVER,evtOver);
			addEventListener(MouseEvent.MOUSE_OUT,evtOut);
		}
		
		private var isActif:Boolean;
		public function set selected(val:Boolean):void {
			isActif=!val;
			evtOut();
		}
		
		public function set isOk(val:Boolean):void {
			rep.visible=val;
		}
		public function get isOk():Boolean {
			return rep.visible;
		}
		
		protected function evtOver(e:Event=null):void {
			if(isActif){
				gotoAndPlay(2);
				pointeur.visible=false;
			}
		}
		
		protected function evtOut(e:Event=null):void {
			if(isActif){
				gotoAndStop(1);
				pointeur.visible=false;
			} else {
				gotoAndStop(3);
				pointeur.visible=true;
			}
		}
	}
}