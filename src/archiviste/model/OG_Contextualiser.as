package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Contextualiser
	 */
	public class OG_Contextualiser extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var v_doc:Vector.<OG_ContextualiserDoc>;
		
		
		
		public function OG_Contextualiser(xml:XML=null)
		{
			
			super(xml);
			v_doc=OG_ContextualiserDoc.feedFromList(xml.document);
			
		}
		
		
		
		
	}
}