package archiviste.view
{
	import archiviste.controllers.GameController;
	import archiviste.dd.nommer.DragClicControler;
	import archiviste.dd.nommer.DragClicInitiateur;
	import archiviste.dd.nommer.DragClicMover;
	import archiviste.dd.nommer.DragClicTarget;
	import archiviste.events.NavigationEvent;
	import archiviste.flashs.ui.C_ClipTlf;
	import archiviste.flashs.ui.C_ui_TlfTextDyn;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.flashs.vignettes.C_ui_vignettes;
	import archiviste.flashs.zoom.C_ui_zoom;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_Dechiffrer;
	import archiviste.model.OG_Nommer;
	import archiviste.model.OG_NommerDoc;
	import archiviste.model.OG_NommerSeries;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import pensetete.dragDrop.ABS_DragClicTarget;
	import pensetete.dragDrop.DragContener;
	import pensetete.events.Dispatch;
	
	import pt.utils.Clips;
	
	import utils.DelayedCall;
	import utils.MyTrace;
	import utils.movieclip.MovieClipUtils;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.view.JeuDechiffrerView
	 * libZoneJeu_dechiffrer
	 */
	public class JeuNommerView extends Sprite implements I_GameModelView
	{
		/* elements presents dans sur la scene */
		
		public var image:MovieClip;
		public var textContainer:MovieClip;
		public var serieContainer:MovieClip;
		public var dragContener:DragContener;
		
		
		
		
		public var docZoom:C_ui_zoom;
		public var vignettes:C_ui_vignettes;
		
		//public var compteurDoc:String;
		/*-----------------------------------*/
		private var v_docsSeries:Vector.<JeuNommerSerieView>;
		private var v_docsClip:Vector.<DragClicTarget>;
		private var model : OG_Nommer;
		
		private var isInit:Boolean;
		
		private var _complete:Boolean=false;
		
		public function isComplete():Boolean
		{
			return _complete;
		}
		
		private var controler:DragClicControler;
		public function JeuNommerView()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		public function getId():String		{	return model.id;	}
		public function getType():String	{	return model.type;	}
		public function setModel(model:OG_ABS):void {	
			this.model=model as OG_Nommer;
		}
		protected function evt_added(event:Event):void	{	
			init();
			if (drop) {
				if (controler) controler.stop();
				controler = new DragClicControler(dragContener,drop);
			}
		
		}
		protected function evt_removed(event:Event):void	{
			if (controler) controler.stop();
		}
		
		private function init():void{
			if (isInit) return;
			isInit=true;
			v_docsClip=new Vector.<DragClicTarget>(model.v_doc.length);
			v_docsSeries = new Vector.<JeuNommerSerieView>(model.v_doc.length);
			var v_Vignette:Vector.<OG_ABS_Doc>=new Vector.<OG_ABS_Doc>(model.v_doc.length);
			for (var i:int = 0; i < model.v_doc.length; i++) 
			{
				v_Vignette[i]=model.v_doc[i] as OG_ABS_Doc;
			}
			vignettes.setVignettes(v_Vignette );
			vignettes.addEventListener(C_ui_vignettes.SELECTED,evt_selected_vignette,false,0,true);
			
			//init_serie()
			
			evt_selected_vignette();
			
		}
		
		
		
		
		
		private var drop:DragClicTarget;
		protected function evt_selected_vignette(event:Event=null):void
		{
			
			MovieClipUtils.removeAllChilds(textContainer);
			MovieClipUtils.removeAllChilds(serieContainer);
			var item:DragClicTarget;
			if (v_docsClip[vignettes.vSelected]) {
				drop=item = v_docsClip[vignettes.vSelected];
			} else {
				drop=item = v_docsClip[vignettes.vSelected]= buildBtnDropNommerView();
				var v_serie:Vector.<OG_NommerSeries>=model.v_doc[vignettes.vSelected].v_serie;
				var i:int=0;
				while (i<v_serie.length && v_serie[i].rep!=true) {
					i++;
				}
				v_docsClip[vignettes.vSelected].setModel(v_serie[i]);
			}
			var sItem:JeuNommerSerieView;
			if (v_docsSeries[vignettes.vSelected]) {
				sItem = v_docsSeries[vignettes.vSelected];
			} else {
				sItem = v_docsSeries[vignettes.vSelected]= buildSerieNommerView();
				
				v_docsSeries[vignettes.vSelected].setModel(model.v_doc[vignettes.vSelected]);
			}
			
			
			docZoom.minZoom=model.v_doc[vignettes.vSelected].getMinZoom();
			docZoom.maxZoom=model.v_doc[vignettes.vSelected].getMaxZoom();
			docZoom.defautZoom=model.v_doc[vignettes.vSelected].getDefautZoom();
			docZoom.image=model.v_doc[vignettes.vSelected].image;
			item.addEventListener(TextDechiffrerView.GAMECOMPLETE,evt_docComplete,false,0,true);
			item.addEventListener(TextDechiffrerView.GAMEINCOMPLETE,evt_docInComplete,false,0,true);
			
			
			
			if (controler) controler.stop();
			controler = new DragClicControler(dragContener,item);
			textContainer.addChild(item);
			serieContainer.addChild(sItem);
			getImage(model.v_doc[vignettes.vSelected].imageJeu);
			
			
			/*
			if (vignettes.v_VignetteSelect[vignettes.vSelected].isOk) {
				evt_docComplete(null);
			} else {
				evt_docInComplete(null);
			}
			*/
		}
		
		protected function evt_docInComplete(event:Event):void	{	
			new DelayedCall(NavigationEvent.dispatch,50,NavigationEvent.DO_INVALIDER);
			NavigationEvent.dispatch(NavigationEvent.DO_INVALIDER);		}
		
		
		protected function evt_docComplete(event:Event):void
		{
			new DelayedCall(NavigationEvent.dispatch,50,NavigationEvent.DO_VALIDER,model.v_doc[vignettes.vSelected].conclusion);
			NavigationEvent.dispatch(NavigationEvent.DO_VALIDER,model.v_doc[vignettes.vSelected].conclusion);
			vignettes.v_VignetteSelect[vignettes.vSelected].isOk=true;
			if (!_complete) {
				if ( _complete=testComplet()) NavigationEvent.dispatch(NavigationEvent.DO_VALIDER_SALLE)
			}
		}
		protected function testComplet():Boolean{
			for (var i:int = 0; i < vignettes.v_VignetteSelect.length; i++) 
			{
				if (vignettes.v_VignetteSelect[i].isOk==false) return false;
			}
			return true;
		}
		
		private function buildBtnDropNommerView():DragClicTarget {
			var cl:Class=Clips.classFromLib("lib_sys_nommer",GameController.instance.main.loaderInfo.applicationDomain);
			var item:DragClicTarget= new  cl() as DragClicTarget;
			return item;
		}
		
		private function buildSerieNommerView():JeuNommerSerieView {
			var cl:Class=Clips.classFromLib("lib_sys_serie_nommer",GameController.instance.main.loaderInfo.applicationDomain);
			var item:JeuNommerSerieView= new  cl() as JeuNommerSerieView;
			return item;
		}
		
		
		
		
		private var url:String
		private function getImage(file:String):void {
			MovieClipUtils.removeAllChilds(image.contenu);
			
				
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
			
			var item:DisplayObject=image.contenu.addChild((e.currentTarget as LoaderInfo).content);
			item.x=-item.width/2;
			item.y=-item.height/2;
			//_width=rep.x=Math.min(container.img.width,container.masque.width);
			
		}
		
		private function keep():void {
			DragClicControler;
			DragClicInitiateur;
			DragClicMover;
			DragClicTarget;
			
		}
	}
}