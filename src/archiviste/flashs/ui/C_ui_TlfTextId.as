package archiviste.flashs.ui
{
	import archiviste.controllers.DataCollection;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_TlfTextId
	 */
	public class C_ui_TlfTextId extends C_ui_TlfTextDyn
	{
		private var _id:String;
		private var _lang:String=null;
		
		public function C_ui_TlfTextId()
		{
			super();
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

	}
}