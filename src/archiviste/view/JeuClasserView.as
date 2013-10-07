package archiviste.view
{
	import archiviste.controllers.GameController;
	import archiviste.dd.classer.DragClicControler;
	import archiviste.dd.classer.DragClicInitiateur;
	import archiviste.dd.classer.DragClicMover;
	import archiviste.dd.classer.DragClicTarget;
	import archiviste.events.NavigationEvent;
	import archiviste.flashs.ui.C_ClipTlf;
	import archiviste.flashs.ui.C_ui_TlfTextDyn;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.flashs.vignettes.C_ui_vignettes;
	import archiviste.flashs.zoom.C_ui_zoom;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_Classer;
	import archiviste.model.OG_Dechiffrer;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import pensetete.dragDrop.ABS_DragClicTarget;
	import pensetete.dragDrop.DragContener;
	import pensetete.events.Dispatch;
	
	import pt.utils.Clips;
	
	import utils.DelayedCall;
	import utils.movieclip.MovieClipUtils;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.view.JeuDechiffrerView
	 * libZoneJeu_dechiffrer
	 */
	public class JeuClasserView extends Sprite implements I_GameModelView
	{
		/* elements presents dans sur la scene */
		
		public var titre:C_ui_TlfTextDyn_fix;
		public var textContainer:MovieClip;
		public var dragContener:DragContener;
		
		public var serie_0:DragClicTarget;
		public var serie_1:DragClicTarget;
		public var serie_2:DragClicTarget;
		
		
		public var docZoom:C_ui_zoom;
		public var vignettes:C_ui_vignettes;
		
		//public var compteurDoc:String;
		/*-----------------------------------*/
		private var v_docsSeries:Vector.<DragClicTarget>;
		private var v_docsClip:Vector.<DragClicInitiateur>;
		private var model : OG_Classer;
		
		private var isInit:Boolean;
		
		private var controler:DragClicControler;
		
		private var _complete:Boolean=false;
		
		public function isComplete():Boolean
		{
			return _complete;
		}
		
		
		public function JeuClasserView()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		public function getId():String		{	return model.id;	}
		public function getType():String	{	return model.type;	}
		public function setModel(model:OG_ABS):void {	
			this.model=model as OG_Classer;	
		}
		protected function evt_added(event:Event):void	{	init()	}
		protected function evt_removed(event:Event):void	{
			if (controler) controler.stop();
		}
		
		private function init():void{
			if (isInit) return;
			isInit=true;
			v_docsClip=new Vector.<DragClicInitiateur>(model.v_doc.length);
			var v_Vignette:Vector.<OG_ABS_Doc>=new Vector.<OG_ABS_Doc>(model.v_doc.length);
			for (var i:int = 0; i < model.v_doc.length; i++) 
			{
				v_Vignette[i]=model.v_doc[i] as OG_ABS_Doc;
			}
			vignettes.setVignettes(v_Vignette );
			vignettes.addEventListener(C_ui_vignettes.SELECTED,evt_selected_vignette,false,0,true);
			
			init_serie()
			
			evt_selected_vignette();
			
		}
		
		
		
		
		private function init_serie():void {
			var i:int = 0;
			v_docsSeries=new Vector.<DragClicTarget>(model.v_serie.length);
			for (i; i < model.v_serie.length; i++) 
			{
				var item:DragClicTarget = getChildByName('serie_'+i)  as DragClicTarget;
				v_docsSeries[i]=item;
				item.setModel(model.v_serie[i]);
			}
			for (i; i < 3; i++) 
			{
				removeChild(getChildByName('serie_'+i));
			}
		}
		
		protected function evt_selected_vignette(event:Event=null):void
		{
			titre.htmlText=model.v_doc[vignettes.vSelected].titre;
			MovieClipUtils.removeAllChilds(textContainer);
			var item:DragClicInitiateur;
			if (v_docsClip[vignettes.vSelected]) {
				item = v_docsClip[vignettes.vSelected];
			} else {
				item = v_docsClip[vignettes.vSelected]= buildBtnDragClasserView();
				v_docsClip[vignettes.vSelected].setModel(model.v_doc[vignettes.vSelected]);
			}
			docZoom.minZoom=model.v_doc[vignettes.vSelected].getMinZoom();
			docZoom.maxZoom=model.v_doc[vignettes.vSelected].getMaxZoom();
			docZoom.defautZoom=model.v_doc[vignettes.vSelected].getDefautZoom();
			docZoom.image=model.v_doc[vignettes.vSelected].image;
			item.addEventListener(TextDechiffrerView.GAMECOMPLETE,evt_docComplete,false,0,true);
			item.addEventListener(TextDechiffrerView.GAMEINCOMPLETE,evt_docInComplete,false,0,true);
			
			
			
			if (controler) controler.stop();
			controler = new DragClicControler(dragContener,v_docsSeries);
			textContainer.addChild(item);
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
		
		private function buildBtnDragClasserView():DragClicInitiateur {
			var cl:Class=Clips.classFromLib("lib_sys_classer",GameController.instance.main.loaderInfo.applicationDomain);
			var item:DragClicInitiateur= new  cl() as DragClicInitiateur;
			return item;
		}
		
		private function keep():void {
			DragClicControler;
			DragClicInitiateur;
			DragClicMover;
			DragClicTarget;
			
		}
	}
}