package archiviste.model
{
	import archiviste.controllers.DataCollection;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Classer
	 */
	public class OG_Puzzle extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var image:String;
		public var conclusion:String;
		
		public var minZoom:Number;
		public var maxZoom:Number;
		public var defautZoom:Number;
		
		public function getMinZoom():Number {
			if (minZoom) return minZoom
			else return DataCollection.params.getNumber("minZoom",.5);
			
		}
		public function getMaxZoom():Number {
			if (maxZoom) return maxZoom
			else return DataCollection.params.getNumber("maxZoom",1.5);
		}
		public function getDefautZoom():Number {
			if (defautZoom) return defautZoom
			else return DataCollection.params.getNumber("defautZoom",1);
		}
		
		public function OG_Puzzle(xml:XML=null)
		{
			
			super(xml);
			conclusion	= getStringFromXml(xml.conclusion);
		}
		
		
		
		
	}
}