package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_NommerDoc
	 */
	public class OG_NommerDoc extends OG_ABS_Doc
	{
		
		
		public var imageJeu:String;
		public var v_serie:Vector.<OG_NommerSeries>;
		
		
		public function OG_NommerDoc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			v_serie=OG_NommerSeries.feedFromList(xml.serie);
		}
		
		
		
		
		/**
		 *  
		 * @param xmlList
		 * 
		 */	
		static public function feedFromList(xmlList:XMLList):Vector.<OG_NommerDoc>
		{
			
			var Cnt:int = xmlList.length();
			var v:Vector.<OG_NommerDoc>=new Vector.<OG_NommerDoc>(Cnt);
			var item:OG_NommerDoc;
			var xml:XML;
			for (var i:int = 0; i < Cnt; i++) 
			{
				xml = xmlList[i];
				item = new OG_NommerDoc(xml);
				v[i]=(item);
			}
			return v;
		}
		
		
	}
}