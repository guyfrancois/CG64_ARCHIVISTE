package archiviste.model
{
	import archiviste.controllers.DataCollection;
	import archiviste.controllers.GameController;
	
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.utils.Dictionary;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_ABS_Doc
	 * <document id="num" image="imgFile.jpg" vignette="imgVignette.png">
	 * 		<titre><![CDATA[titre long du document]]></conclusion>
	 * 		<titreover><![CDATA[titre court (rollover) du document]]></titreover>
	 * 		<conclusion><![CDATA[texte de conclusion du doc]]></conclusion>
	 * </documment>
	 */
	public class OG_ABS_Doc extends AbstractXMLPopulatedModel
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var id:String;
		public var image:String;
		public var vignette:String;
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
		/**
		 * titre du document
		 */
		public var titre:String;
		public var titreover:String;
		
		public var conclusion:String;
		
		public function OG_ABS_Doc(xml:XML=null)
		{
			//TODO: implement function
			super(xml);
			titre	= getStringFromXml(xml.titre);
			titreover	= getStringFromXml(xml.titreover);
			//if (titreover=="") titreover=titre;
			conclusion	= getStringFromXml(xml.conclusion);
			
		}
		
		
		
		
		
	}
}