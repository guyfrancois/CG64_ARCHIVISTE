package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Classer
	 */
	public class OG_Classer extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var v_doc:Vector.<OG_ClasserDoc>;
		public var v_serie:Vector.<OG_ClasserSeries>;
		
		
		public function OG_Classer(xml:XML=null)
		{
			
			super(xml);
			v_doc=OG_ClasserDoc.feedFromList(xml.document);
			v_serie=OG_ClasserSeries.feedFromList(xml.serie);
		}
		
		
		
		
	}
}