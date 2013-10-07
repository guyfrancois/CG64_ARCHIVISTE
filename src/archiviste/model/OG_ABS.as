package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Dechiffrer
	 */
	public class OG_ABS extends AbstractXMLPopulatedModel
	{
		public static const TYPE_DECHIFFRER:String="dechiffrer";
		public static const TYPE_CLASSER:String="classer";
		public static const TYPE_IDENTIFIER:String="identifier";
		public static const TYPE_CONTEXTUALISER:String="contextualiser";
		public static const TYPE_NOMMER:String="nommer";
		public static const TYPE_PUZZLE:String="puzzle";
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		public var id:String;
		public var lvl:String;
		public var type:String;
		
		
		public function OG_ABS(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			
		}
		
		
		
		
		
		static protected function feedFromList(xmlList:XMLList):Vector.<OG_ABS>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ABS>=new Vector.<OG_ABS>(Cnt);
			var item:OG_ABS;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				var type:String= xml.@type;
				switch (type) {
					case TYPE_DECHIFFRER :
						item = new OG_Dechiffrer(xml);
						break;
					case TYPE_CLASSER :
						item = new OG_Classer(xml);
						break;
					case TYPE_CONTEXTUALISER :
						item = new OG_Contextualiser(xml);
						break;
					case TYPE_IDENTIFIER :
						item = new OG_Identifier(xml);
						break;
					case TYPE_NOMMER :
						item = new OG_Nommer(xml);
						break;
					case TYPE_PUZZLE :
						item = new OG_Puzzle(xml);
						break;
				}
				
				v[i]=(item);
			}
			return v;
		}
		
		private static var _OG:Vector.<OG_ABS>;
		static public function keepfeedFromList(xmlList:XMLList):void
		{
			
			_OG=feedFromList(xmlList);
		}
		static public function getOGByIdLvl(searchID:String,lvl:String):OG_ABS
		{
			var oG:OG_ABS;
			
			for (var i:int = 0; i < _OG.length; i++) 
			{
				if (_OG[i].id == searchID && _OG[i].lvl==lvl) {
					oG =_OG[i];
					break;
				}
			}
			
			return oG;
		}
	}
}