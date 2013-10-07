package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_IdentifierSeries
	 */
	public class OG_IdentifierSeries extends OG_ABS_CocheSeries
	{
		
		
		public function OG_IdentifierSeries(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			
		}
		
		
		
		
		
		
		static public function feedFromList(xmlList:XMLList):Vector.<OG_IdentifierSeries>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_IdentifierSeries>=new Vector.<OG_IdentifierSeries>(Cnt);
			var item:OG_IdentifierSeries;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_IdentifierSeries(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}