package archiviste.model
{
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [31 août 2012][GUYF] creation
	 *
	 * archiviste.model.BlocSaisie
	 */
	public class BlocSaisie
	{
		public var startIndex:int;
		public var endIndex:int;
		public var texte:String;
		public var isOk:Boolean=false;
		public function BlocSaisie(startIndex:int,texte:String,endIndex:int)
		{
			this.startIndex=startIndex;
			this.texte=texte;
			this.endIndex=endIndex;
		}
	}
}