package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_IdentifierDoc
	 */
	public class OG_IdentifierDoc extends OG_ABS_Doc
	{
		
		
	
		public var v_serie:Vector.<OG_IdentifierSeries>;
		
		
		public function OG_IdentifierDoc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			v_serie=OG_IdentifierSeries.feedFromList(xml.serie);
		}
		
		
		
		
		/**
		 *  
		 * @param xmlList
		 * 
		 */	
		static public function feedFromList(xmlList:XMLList):Vector.<OG_IdentifierDoc>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_IdentifierDoc>=new Vector.<OG_IdentifierDoc>(Cnt);
			var item:OG_IdentifierDoc;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_IdentifierDoc(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}