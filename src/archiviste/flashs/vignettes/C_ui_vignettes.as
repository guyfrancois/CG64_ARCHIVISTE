package archiviste.flashs.vignettes
{
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	import archiviste.model.OG_ABS_Doc;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import pt.utils.Clips;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [18 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.vignettes.C_ui_vignettes
	 * lib_system_vignettes
	 */
	public class C_ui_vignettes extends Sprite
	{
		public static var SELECTED:String="SELECTED";
		public var v_VignetteSelect:Vector.<C_ui_vignetteSelect>;
		private var wMax:Number=260;
		private var hMarge:Number=10;
		public function C_ui_vignettes()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_NEXTDOC,evt_showNextDoc,false);
		}
		
		protected function evt_added(event:Event):void
		{
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_NEXTDOC,evt_showNextDoc,false);
		}		
		
		protected function evt_showNextDoc(event:Event):void
		{
			var j:int = 0
			for (j; j < v_VignetteSelect.length; j++) 
			{
				
				if (!v_VignetteSelect[j].isOk) break;
				
			}
			vSelected=j;
			dispatchEvent(new Event("SELECTED"));
		}
		
		private var _vSelected:Number=0;;
		public function get vSelected():Number
		{
			return _vSelected;
		}

		public function set vSelected(value:Number):void
		{
			_vSelected = value;
			for (var j:int = 0; j < v_VignetteSelect.length; j++) 
			{
			
				v_VignetteSelect[j].selected=(j==vSelected);
				
			}
		}

		public function setVignettes(v_absDoc:Vector.<OG_ABS_Doc>):void {
			v_VignetteSelect = new Vector.<C_ui_vignetteSelect>(v_absDoc.length);
			for (var i:int = 0; i < v_absDoc.length; i++) 
			{
				v_VignetteSelect[i]=buildC_ui_vignetteSelect();
				v_VignetteSelect[i].addEventListener("COMPLETE",evt_vignetteComplete,false,0,true);
				v_VignetteSelect[i].setVignette(v_absDoc[i].vignette);
				//TODO ajouter le rollOver TitreCours
				
			}
		}
		
		private var _loadingProgress:Number=0;
		protected function evt_vignetteComplete(event:Event):void
		{
			_loadingProgress++;
			if (_loadingProgress==v_VignetteSelect.length) {
				allLoadComplete();
			}
			
		}		
		
		private function allLoadComplete():void
		{
			var totalWidth:Number=0;
			for (var i:int = 0; i < v_VignetteSelect.length; i++) 
			{
				totalWidth+=v_VignetteSelect[i].width;
			}
			hMarge=(260-totalWidth)/v_VignetteSelect.length;
			totalWidth+=hMarge*(v_VignetteSelect.length-1);
			var x0:Number=-totalWidth/2
			for (var j:int = 0; j < v_VignetteSelect.length; j++) 
			{
				v_VignetteSelect[j].x=x0;
				x0+=v_VignetteSelect[j].width+hMarge;
				addChild(v_VignetteSelect[j]);
				v_VignetteSelect[j].addEventListener(MouseEvent.CLICK,evt_vignetteClick,false,0,true);
				v_VignetteSelect[j].selected=(j==vSelected);
				
			}
		}
		
		protected function evt_vignetteClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			vSelected = v_VignetteSelect.indexOf(event.currentTarget)
			dispatchEvent(new Event("SELECTED"));
		}
		
		private function buildC_ui_vignetteSelect():C_ui_vignetteSelect {
			
			var cl:Class=Clips.classFromLib("libBtnVignettes",GameController.instance.main.loaderInfo.applicationDomain);
			var item:C_ui_vignetteSelect= new  cl() as C_ui_vignetteSelect;
			
			return item;
		}
	}
}