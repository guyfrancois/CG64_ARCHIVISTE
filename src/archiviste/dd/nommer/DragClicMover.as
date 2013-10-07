package archiviste.dd.nommer
{
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.model.OG_Nommer;
	import archiviste.model.OG_NommerDoc;
	import archiviste.model.OG_NommerSeries;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import pensetete.dragDrop.ABS_DragClicMover;
	import pensetete.dragDrop.I_DragClicMover;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [28 sept. 2012][GUYF] creation
	 *
	 * archiviste.dd.DragClicMover
	 */
	public class DragClicMover extends ABS_DragClicMover implements I_DragClicMover
	{
		public var texte:C_ui_TlfTextDyn_fix;
		
		private var model:OG_NommerSeries;
		public function setModel(model:OG_NommerSeries):void {
			this.model=model;
			texte.htmlText=model.titre;
		}
		
		
		public function getModel():OG_NommerSeries {
			return model;
		}
		
		override public function getFreeEventKey():String {
			return MouseEvent.MOUSE_UP;
		}
		
		override public function getId():String
		{
			// TODO Auto Generated method stub
			return model.rep.toString();
		}
		
		public function DragClicMover()
		{
			super();
		}
		
		
		
		override public function setInZone(val:Boolean):void
		{
			visible=val;
		}
		
		override public function setOver(val:Boolean):void
		{
			if (val) gotoAndStop(2);
			else gotoAndStop(1);
		}
		
	}
}