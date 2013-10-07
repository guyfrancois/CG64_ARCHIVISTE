package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Nommer
	 */
	public class OG_Nommer extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var v_doc:Vector.<OG_NommerDoc>;
		
		
		
		public function OG_Nommer(xml:XML=null)
		{
			
			super(xml);
			v_doc=OG_NommerDoc.feedFromList(xml.document);
			
		}
		
		
		
		
	}
}