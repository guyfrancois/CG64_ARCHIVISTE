package archiviste.view
{
	import archiviste.dd.nommer.DragClicInitiateur;
	import archiviste.model.OG_NommerDoc;
	
	import flash.display.Sprite;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [1 oct. 2012][GUYF] creation
	 *
	 * archiviste.view.JeuNommerSerieView
	 */
	public class JeuNommerSerieView extends Sprite
	{
		private var v_docsSeries:Vector.<DragClicInitiateur>;
		public function JeuNommerSerieView()
		{
			super();
		}
		
		public function setModel(model:OG_NommerDoc):void {
			var i:int = 0;
			v_docsSeries=new Vector.<DragClicInitiateur>(model.v_serie.length);
			for (i; i < model.v_serie.length; i++) 
			{
				var item:DragClicInitiateur = getChildByName('serie_'+i)  as DragClicInitiateur;
				v_docsSeries[i]=item;
				item.setModel(model.v_serie[i]);
			}
			for (i; i < 3; i++) 
			{
				removeChild(getChildByName('serie_'+i));
			}
		}
	}
}