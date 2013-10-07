package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Identifier
	 */
	public class OG_Identifier extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var v_doc:Vector.<OG_IdentifierDoc>;
		
		
		
		public function OG_Identifier(xml:XML=null)
		{
			
			super(xml);
			v_doc=OG_IdentifierDoc.feedFromList(xml.document);
			
		}
		
		
		
		
	}
}