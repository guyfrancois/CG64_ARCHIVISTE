package archiviste.view
{
	import archiviste.model.OG_ABS;
	

	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.view.I_GameModelView
	 */
	public interface I_GameModelView
	{
		
		function setModel(model:OG_ABS):void;
		function getType():String;
		function getId():String;
		function isComplete():Boolean;
	}
}