package archiviste.flashs.ui
{
	import archiviste.controllers.DataCollection;
	
	import flash.display.MovieClip;
	
	import pensetete.components.ScrollBarV;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_TlfTextId
	 */
	public class C_ui_TlfTextScrollId extends C_ui_TlfTextDyn
	{
		public var scrollbar:ScrollBarV;
		public var masque:MovieClip;
		private var _id:String;
		private var _lang:String=null;
		private var maxHeight:Number;
		
		
		public function C_ui_TlfTextScrollId()
		{
			super();
			maxHeight=masque.height;
			scrollbar.visibleH=masque.height;
			scrollbar.viewport=fltTF
			scrollbar.refresh();
		}
		
		
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
			var daCo:DataCollection = DataCollection.instance;
			var str:String = daCo.getText(value, _lang);
			var strIsHtml:Boolean = daCo.isHtml(_id, _lang); 
			if (strIsHtml) 
			{
				htmlText = str;
			} else {
				text = str;
			}
			
		}
		
		override public function set htmlText(value:String):void
		{
			// TODO Auto Generated method stub
			fltTF.y=0;
			super.htmlText = value;
		/*	if (fltTF.height>maxHeight) {
				masque.height = fltTF.height;
			} else {
				masque.height = maxHeight;
			}*/
			scrollbar.refresh();
		}
		
		override public function set text(value:String):void
		{
			// TODO Auto Generated method stub
			fltTF.y=0;
			super.text = value;
			scrollbar.refresh();
		}
		

	}
}