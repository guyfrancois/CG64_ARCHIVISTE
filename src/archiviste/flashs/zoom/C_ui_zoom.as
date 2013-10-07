package archiviste.flashs.zoom
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import utils.MyTrace;
	import utils.movieclip.MovieClipUtils;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [18 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.zoom.C_ui_zoom
	 * libDocZoom
	 */
	public class C_ui_zoom extends Sprite
	{
		/* elements presents sur la scene */
		public var masque:MovieClip;
		public var container:MovieClip;
	
		public var btns_zoom:MovieClip; // btn_plus , btn_moins
		/*---------------------------------*/
		// curseur : CURS_ZOOM
		
		
		private var _zoomEnable:Boolean=false;
		private var _zoomVisible:Boolean=false;
		
		private var _zoomFact:Number;

		public function get blur():Number
		{
			return _blur;
		}

		public function set blur(value:Number):void
		{
			 _blur = value;
			 updateBlur()
		}

		public function get defautZoom():Number
		{
			return _defautZoom;
		}

		public function set defautZoom(value:Number):void
		{
			if (value) _defautZoom = value;
		}

		public function get maxZoom():Number
		{
			return _maxZoom;
		}

		public function set maxZoom(value:Number):void
		{
			if (value) _maxZoom = value;
		}

		public function get minZoom():Number
		{
			return _minZoom;
		}

		public function set minZoom(value:Number):void
		{
			if (value)  _minZoom = value;
		}

		public function get zoomFact():Number
		{
			return _zoomFact;
		}
		
		private var _blur:Number=0;

		public function set zoomFact(value:Number):void
		{
			value =Math.min( Math.max(value,minZoom),maxZoom);
			if (value == minZoom || minZoom == maxZoom) {
				TweenMax.killTweensOf(this);
			}
			var dFact:Number=value/_zoomFact;
			_zoomFact = value;
			zoomContent.scaleX=zoomContent.scaleY=value;
			
			
			zoomContent.x=(zoomContent.x-masque.width/2)*dFact+masque.width/2;
			zoomContent.y=(zoomContent.y-masque.height/2)*dFact+masque.height/2;
			/*
			zoomContent.x*=dFact;
			
			
			zoomContent.y*=dFact;
			*/
			recadreInLimites();
		}
		private var cmi:ContextMenuItem;
		private function initContextMenu():void {
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			
			
			
			
			
			
			cmi = new ContextMenuItem("zoom", true,true);
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onZoomSelected);
			cm.customItems.push(cmi);
			
			this.contextMenu = cm;
			
		}
		
		protected function onZoomSelected(event:ContextMenuEvent):void
		{
			// TODO Auto-generated method stub
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,zoomFact);
		}		
		
		private var _minZoom:Number=.5;
		private var _maxZoom:Number=1.5;
		private var _defautZoom:Number=1;

		public function get image():String
		{
			return _image;
		}

		public function set image(value:String):void
		{
			_image = value;
			getImage(_image);
		}

		public function get zoomVisible():Boolean
		{
			return _zoomVisible;
		}

		public function set zoomVisible(value:Boolean):void
		{
			_zoomVisible = value;
			btns_zoom.visible=_zoomVisible;
		}

		public function get zoomEnable():Boolean
		{
			return _zoomEnable;
		}

		public function set zoomEnable(value:Boolean):void
		{
			_zoomEnable = value;
			btns_zoom.mouseChildren=_zoomEnable;
			if (_zoomEnable) {
				btns_zoom.gotoAndStop(1);
				btns_zoom.btn_plus.addEventListener(MouseEvent.MOUSE_DOWN,evtZoomPlus,false,0,true);
				btns_zoom.btn_plus.addEventListener(MouseEvent.MOUSE_UP,evtZoomPlusEnd,false,0,true);
				btns_zoom.btn_moins.addEventListener(MouseEvent.MOUSE_DOWN,evtZoomMoins,false,0,true);
				btns_zoom.btn_moins.addEventListener(MouseEvent.MOUSE_UP,evtZoomMoinsEnd,false,0,true);
			} else {
				
				btns_zoom.gotoAndStop(2);
			}
		}
		
		public function C_ui_zoom()
		{
			super();
			initContextMenu()
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void {
			if (zoomContent ) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,evt_Move,false,0,true);
			}
		}
		protected function evt_removed(event:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,evt_Move);
		}
		
		private var _image:String;
		
		private var url:String;
		
		private function getImage(file:String):void {
			zoomContent=null;
			MovieClipUtils.removeAllChilds(container);
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
		private var zoomContent:Bitmap;
		private function completeImageHandler(e:Event ):void {
			trace(e);
			zoomContent = (e.currentTarget as LoaderInfo).content as Bitmap;
			//zoomContent.pixelSnapping=PixelSnapping.ALWAYS;
			zoomContent.smoothing=true;
			container.addChild(zoomContent);
			if(stage) {
				stage.addEventListener(MouseEvent.MOUSE_MOVE,evt_Move,false,0,true);
			}
			zoomFact=defautZoom;
			btns_zoom.btn_plus.addEventListener(MouseEvent.MOUSE_DOWN,evtZoomPlus,false,0,true);
			btns_zoom.btn_plus.addEventListener(MouseEvent.MOUSE_UP,evtZoomPlusEnd,false,0,true);
			btns_zoom.btn_moins.addEventListener(MouseEvent.MOUSE_DOWN,evtZoomMoins,false,0,true);
			btns_zoom.btn_moins.addEventListener(MouseEvent.MOUSE_UP,evtZoomMoinsEnd,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN,evtMoveStart,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,evtMoveStop,false,0,true);
			
			zoomContent.x=(masque.width-zoomContent.width)/2;
			zoomContent.y=(masque.height-zoomContent.height)/2;
			
			updateBlur()
		}
		
		private var moving:Boolean=false;
		protected function evtMoveStop(event:MouseEvent):void
		{
			moving=true;
			
		}
		
		protected function evtMoveStart(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			moving=false;
		}		
		
		private function evtZoomPlus(event:MouseEvent=null):void
		{
			TweenMax.to(this,1,{zoomFact:zoomFact*1.5,ease : Linear.easeNone,onComplete:evtZoomPlus});
		}
		
		
		private function evtZoomPlusEnd(event:MouseEvent):void
		{
			TweenMax.killTweensOf(this);
		}
		private function evtZoomMoins(event:MouseEvent=null):void
		{
			TweenMax.to(this,1,{zoomFact:zoomFact*0.5,ease : Linear.easeNone,onComplete:evtZoomMoins});
		}
		
		private function evtZoomMoinsEnd(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			TweenMax.killTweensOf(this);
		}
		
		private var pM:Point;
		protected function evt_Move(event:MouseEvent):void
		{
			
			// test du survole de zone pour affichage du curseur courant
			var gp:Point=localToGlobal(new Point(mouseX,mouseY));
				if (pM==null) {
					pM=gp;
					return;
				}
				
				if (hitTestPoint(gp.x,gp.y,true) && !btns_zoom.hitTestPoint(gp.x,gp.y,true)) {
					
						Mouse.cursor = "CURS_ZOOM";
						if (event.buttonDown) {
							doMove(gp);
						} else {
							pM=gp;
						}
					
				} else {
					
					Mouse.cursor=MouseCursor.AUTO;
				}
		}
		
		private function doMove(gp:Point):void
		{
			var dp:Point= gp.subtract(pM)
			zoomContent.x+=dp.x;
			zoomContent.y+=dp.y;
			pM=gp;
			recadreInLimites();
			
		}
		
		private function recadreInLimites():void{
			if (zoomContent.x>0) zoomContent.x=0;
			if (zoomContent.y>0) zoomContent.y=0;
			if (zoomContent.x+zoomContent.width<masque.width) zoomContent.x=masque.width-zoomContent.width;
			if (zoomContent.y+zoomContent.height<masque.height) zoomContent.y=masque.height-zoomContent.height;
			if (zoomContent.width < masque.width) zoomContent.x=(masque.width-zoomContent.width)/2;
			if (zoomContent.height < masque.height) zoomContent.y=(masque.height-zoomContent.height)/2;
			cmi.caption="zoom : "+zoomFact;
		}
		
		public static var XBLUR:Number=1;
		public static var YBLUR:Number=1;
		public static var QUALITYBLUR:Number=3;
		private function updateBlur():void {
			if (zoomContent==null) return;
			
			if(_blur>0) {
				zoomContent.filters=[new BlurFilter(_blur*255, _blur*255, QUALITYBLUR)]
			} else {
				zoomContent.filters=[];
			}
		}
		
		public function tweenUnblur():void {
			TweenMax.to(this,1, {blur:0});
			
		}
	}
}