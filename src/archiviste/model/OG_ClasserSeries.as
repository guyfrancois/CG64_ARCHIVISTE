package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_ClasserSeries
	 */
	public class OG_ClasserSeries extends AbstractXMLPopulatedModel
	{
		
		public var idSerie:String
		public var titre:String
		public var vignette:String
		
		public function OG_ClasserSeries(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			titre	= getStringFromXml(xml.titre);
		}
		
		
		
		
		
		
		static public function feedFromList(xmlList:XMLList):Vector.<OG_ClasserSeries>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_ClasserSeries>=new Vector.<OG_ClasserSeries>(Cnt);
			var item:OG_ClasserSeries;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_ClasserSeries(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}