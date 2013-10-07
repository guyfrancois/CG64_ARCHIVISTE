package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_ClasserDoc
	 */
	public class OG_ClasserDoc extends OG_ABS_Doc
	{
		
		public var idSerie:String
		
		
		public function OG_ClasserDoc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
		}
		
		
		
		
		/**
		 *  
		 * @param xmlList
		 * 
		 */	
		static public function feedFromList(xmlList:XMLList):Vector.<OG_ClasserDoc>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ClasserDoc>=new Vector.<OG_ClasserDoc>(Cnt);
			var item:OG_ClasserDoc;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_ClasserDoc(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}