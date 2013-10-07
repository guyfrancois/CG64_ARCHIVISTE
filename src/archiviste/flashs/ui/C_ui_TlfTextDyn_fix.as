package archiviste.flashs.ui
{
	import fl.text.TLFTextField;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_TlfTextDyn
	 */
	public class C_ui_TlfTextDyn_fix extends Sprite
	{
		
		private var _text:String;
		private var fltTF:TLFTextField;
		public function C_ui_TlfTextDyn_fix()
		{
			super();
		
			fltTF = getChildAt(0) as TLFTextField; 
			
			//fltTF.autoSize=TextFieldAutoSize.LEFT;
			fltTF.wordWrap=true;
			fltTF.selectable = false;
			fltTF.alwaysShowSelection = false;
			fltTF.mouseEnabled = false;
			fltTF.visible=false;
			mouseChildren=false;
			
			addEventListener(Event.ADDED_TO_STAGE,evt_added,true,0,false);
		}
		
		protected function evt_added(event:Event):void
		{
			
		}
		
		public function get text():String
		{
			return fltTF.text;
		}

		public function set text(value:String):void
		{
			_text = value;
			fltTF.text = _text;
			fltTF.visible=true
		}
		
		public function get htmlText():String
		{
			return fltTF.htmlText;
		}
		
		public function set htmlText(value:String):void
		{
			_text = value;
			fltTF.htmlText = _text;
			fltTF.visible=true
		}
		
		

	}
}