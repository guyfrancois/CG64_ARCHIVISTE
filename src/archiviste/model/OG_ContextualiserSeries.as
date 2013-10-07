package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_ContextualiserSeries
	 */
	public class OG_ContextualiserSeries extends OG_ABS_CocheSeries
	{
		
		
		public function OG_ContextualiserSeries(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			
		}
		
		
		
		
		
		
		static public function feedFromList(xmlList:XMLList):Vector.<OG_ContextualiserSeries>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ContextualiserSeries>=new Vector.<OG_ContextualiserSeries>(Cnt);
			var item:OG_ContextualiserSeries;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_ContextualiserSeries(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}