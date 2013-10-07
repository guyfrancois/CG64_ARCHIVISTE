package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_NommerSeries
	 */
	public class OG_NommerSeries extends AbstractXMLPopulatedModel
	{
		
		public var rep:Boolean;
		public var titre:String;
		
		public function OG_NommerSeries(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			titre	= getStringFromXml(xml.titre);
		}
		
		
		
		
	
		
		static public function feedFromList(xmlList:XMLList):Vector.<OG_NommerSeries>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_NommerSeries>=new Vector.<OG_NommerSeries>(Cnt);
			var item:OG_NommerSeries;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_NommerSeries(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}