package archiviste.flashs.ui.boutons
{
	import archiviste.controllers.GameController;
	import archiviste.events.NavigationEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.boutons.C_BtnClass
	 */
	public class C_ui_BtnGame extends ABS_BTN
	{
		public var cube:MovieClip;
		
		public function C_ui_BtnGame()
		{
			super();
			isActif=true;
			//clicEvent = NavigationEvent.DO_GAME_CLICKED;
			clicEvent = NavigationEvent.DO_SALLE_CLICKED;
			var ref:String = getQualifiedClassName(this);
			
			clicData = ref.substring(ref.indexOf("_")+1);
			initInteraction();
			addEventListener(MouseEvent.CLICK,evt_click,false,0,true);
			cube.ico.visible=!GameController.instance.etatSalle(clicData.toString());
		}
		
		protected function evt_click(event:MouseEvent):void
		{
			onClic_ABS_BTN(event);
		}
		
		
	}
}