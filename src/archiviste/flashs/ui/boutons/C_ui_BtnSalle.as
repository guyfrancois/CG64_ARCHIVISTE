package archiviste.flashs.ui.boutons
{
	import archiviste.events.NavigationEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.boutons.C_BtnClass
	 */
	public class C_ui_BtnSalle extends ABS_BTN
	{
		
		public function C_ui_BtnSalle()
		{
			super();
			isActif=true;
			clicEvent = NavigationEvent.DO_SALLE_CLICKED;
			var ref:String = getQualifiedClassName(this);
			
			clicData = ref.substring(ref.indexOf("_")+1);
			initInteraction();
			addEventListener(MouseEvent.CLICK,evt_click,false,0,true);
		}
		
		protected function evt_click(event:MouseEvent):void
		{
			onClic_ABS_BTN(event);
		}
		
	}
}