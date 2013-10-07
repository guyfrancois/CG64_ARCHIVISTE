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
	public class OG_ABS_CocheSeries extends AbstractXMLPopulatedModel
	{
		
		public var rep:Boolean;
		public var titre:String;
		
		public function OG_ABS_CocheSeries(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			titre	= getStringFromXml(xml.titre);
		}
		
		
		
		
		
		
		
		static public function feedFromList(xmlList:XMLList):Vector.<OG_ABS_CocheSeries>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ABS_CocheSeries>=new Vector.<OG_ABS_CocheSeries>(Cnt);
			var item:OG_ABS_CocheSeries;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_ABS_CocheSeries(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}