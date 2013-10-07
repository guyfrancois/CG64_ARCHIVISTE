package archiviste.view
{
	import archiviste.controllers.GameController;
	import archiviste.events.NavigationEvent;
	import archiviste.flashs.ui.C_ClipTlf;
	import archiviste.flashs.ui.C_ui_TlfTextDyn;
	import archiviste.flashs.vignettes.C_ui_vignettes;
	import archiviste.flashs.zoom.C_ui_zoom;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_Dechiffrer;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
	public class JeuDechiffrerView extends Sprite implements I_GameModelView
	{
		/* elements presents dans sur la scene */
		
		public var titre:C_ui_TlfTextDyn;
		public var textContainer:MovieClip;
		public var docZoom:C_ui_zoom;
		public var vignettes:C_ui_vignettes;
		//public var compteurDoc:String;
		/*-----------------------------------*/
		private var v_docsClip:Vector.<TextDechiffrerView>;
		private var model : OG_Dechiffrer;
		
		private var isInit:Boolean;
		
		private var _complete:Boolean=false;
		
		public function isComplete():Boolean
		{
			return _complete;
		}
		
		public function JeuDechiffrerView()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		public function getId():String		{	return model.id;	}
		public function getType():String	{	return model.type;	}
		public function setModel(model:OG_ABS):void {	
			this.model=model as OG_Dechiffrer;
		}
		protected function evt_added(event:Event):void	{	init()	}
		protected function evt_removed(event:Event):void	{	}
		
		private function init():void{
			if (isInit) return;
			isInit=true;
			v_docsClip=new Vector.<TextDechiffrerView>(model.v_doc.length);
			var v_Vignette:Vector.<OG_ABS_Doc>=new Vector.<OG_ABS_Doc>(model.v_doc.length);
			for (var i:int = 0; i < model.v_doc.length; i++) 
			{
				v_Vignette[i]=model.v_doc[i] as OG_ABS_Doc;
			}
			vignettes.setVignettes(v_Vignette );
			vignettes.addEventListener(C_ui_vignettes.SELECTED,evt_selected_vignette,false,0,true);
			evt_selected_vignette();
		}
		
		protected function evt_selected_vignette(event:Event=null):void
		{
			titre.text=model.v_doc[vignettes.vSelected].titre;
			MovieClipUtils.removeAllChilds(textContainer);
			var item:TextDechiffrerView;
			if (v_docsClip[vignettes.vSelected]) {
				item = v_docsClip[vignettes.vSelected];
			} else {
				item = v_docsClip[vignettes.vSelected]= buildTextDechiffrerView();
				v_docsClip[vignettes.vSelected].setText(model.v_doc[vignettes.vSelected].textATrou);
			}
			docZoom.minZoom=model.v_doc[vignettes.vSelected].getMinZoom();
			docZoom.maxZoom=model.v_doc[vignettes.vSelected].getMaxZoom();
			docZoom.defautZoom=model.v_doc[vignettes.vSelected].getDefautZoom();
			docZoom.image=model.v_doc[vignettes.vSelected].image;
			item.addEventListener(TextDechiffrerView.GAMECOMPLETE,evt_docComplete,false,0,true);
			item.addEventListener(TextDechiffrerView.GAMEINCOMPLETE,evt_docInComplete,false,0,true);
			textContainer.addChild(item);
		}
		
		protected function evt_docInComplete(event:Event):void	{	
			new DelayedCall(NavigationEvent.dispatch,50,NavigationEvent.DO_INVALIDER);
			NavigationEvent.dispatch(NavigationEvent.DO_INVALIDER);	
		}
		
		
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
		
		private function buildTextDechiffrerView():TextDechiffrerView {
			var cl:Class=Clips.classFromLib("lib_sys_dechiffrer",GameController.instance.main.loaderInfo.applicationDomain);
			var item:TextDechiffrerView= new  cl() as TextDechiffrerView;
			return item;
		}
	}
}