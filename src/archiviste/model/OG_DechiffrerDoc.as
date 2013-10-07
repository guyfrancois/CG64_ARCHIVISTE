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
	public class OG_DechiffrerDoc extends OG_ABS_Doc
	{
		
		public var textATrou:String
		
		public function OG_DechiffrerDoc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			textATrou	= getStringFromXml(xml.textATrou);
		}
		
		
		
		
		/**
		 *  
		 * @param xmlList
		 * 
		 */	
		static public function feedFromList(xmlList:XMLList):Vector.<OG_DechiffrerDoc>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_DechiffrerDoc>=new Vector.<OG_DechiffrerDoc>(Cnt);
			var item:OG_DechiffrerDoc;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_DechiffrerDoc(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}