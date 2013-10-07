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
	public class C_BtnName extends ABS_BTN
	{
		public static const EVENT_CLIC:String="event_name_click";
		
		public var selfname:String;
		
		public function C_BtnName()
		{
			super();
			isActif=true;
			selfname=name.substr(name.indexOf("_")+1);
			clicEvent = C_BtnName.getClicEvent(getQualifiedClassName(this));
			clicData = selfname;
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