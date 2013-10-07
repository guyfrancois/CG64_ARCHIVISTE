package archiviste.flashs.ui.boutons
{
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.boutons.C_BtnClass
	 */
	public class C_BtnClass extends ABS_BTN
	{
		public static const EVENT_CLIC:String="event_class_click";
		
		public function C_BtnClass()
		{
			super();
			isActif=true;
			clicEvent = C_BtnClass.getClicEvent(getQualifiedClassName(this));
			initInteraction();
			addEventListener(MouseEvent.CLICK,evt_click,false,0,true);
		}
		
		protected function evt_click(event:MouseEvent):void
		{
			onClic_ABS_BTN(event);
		}
		
		public static function getClicEvent(selfname:String):String {
			
			return EVENT_CLIC+"_"+selfname;
			
		}
	}
}