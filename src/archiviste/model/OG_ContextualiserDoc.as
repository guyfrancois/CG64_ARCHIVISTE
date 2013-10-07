package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_ContextualiserDoc
	 */
	public class OG_ContextualiserDoc extends OG_ABS_Doc
	{
		
		
		public var blur:Number=1;
		public var v_serie:Vector.<OG_ContextualiserSeries>;
		
		
		public function OG_ContextualiserDoc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			v_serie=OG_ContextualiserSeries.feedFromList(xml.serie);
		}
		
		
		
		
		/**
		 *  
		 * @param xmlList
		 * 
		 */	
		static public function feedFromList(xmlList:XMLList):Vector.<OG_ContextualiserDoc>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ContextualiserDoc>=new Vector.<OG_ContextualiserDoc>(Cnt);
			var item:OG_ContextualiserDoc;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_ContextualiserDoc(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}