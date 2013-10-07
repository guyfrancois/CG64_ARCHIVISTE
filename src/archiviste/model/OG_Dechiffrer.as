package archiviste.model
{
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.model.OG_Dechiffrer
	 */
	public class OG_Dechiffrer extends OG_ABS
	{
		
		// Elements peuplés automatiquement via AbstractXMLPopulatedModel
		
		public var v_doc:Vector.<OG_DechiffrerDoc>;
		
		
		public function OG_Dechiffrer(xml:XML=null)
		{
			
			super(xml);
			v_doc=OG_DechiffrerDoc.feedFromList(xml.document);
		}
		
		
		
		
	}
}