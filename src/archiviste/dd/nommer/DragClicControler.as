package archiviste.dd.nommer
{

	
	import archiviste.controllers.GameController;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import pensetete.dragDrop.ABS_DragClicControleur;
	import pensetete.dragDrop.ABS_DragClicTarget;
	import pensetete.dragDrop.ABS_DragInitiator;
	import pensetete.dragDrop.DragContener;
	import pensetete.dragDrop.EventDragClic;
	import pensetete.dragDrop.I_DragClicMover;
	import pensetete.dragDrop.I_DragClicTarget;
	import pensetete.events.Dispatch;
	
	import pt.utils.Clips;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [28 sept. 2012][GUYF] creation
	 *
	 * archiviste.dd.DragClicControler
	 */
	public class DragClicControler extends ABS_DragClicControleur
	{
		private var drop:DragClicTarget;
		public function DragClicControler(dragContener:DragContener,drop:DragClicTarget)
		{
			super(dragContener);
			this.drop=drop;
		}
		
		override protected function buildDragItem(idItem:String,initiator:ABS_DragInitiator):I_DragClicMover
		{
			var _initiator:DragClicInitiateur = initiator as DragClicInitiateur
		
			_initiator.getModel();
			var cl:Class=Clips.classFromLib("libDrag_nommer",GameController.instance.main.loaderInfo.applicationDomain);
			var item:DragClicMover= new  cl() as DragClicMover;
			item.setModel(_initiator.getModel());
			return item as I_DragClicMover;
		}
		
		override protected function findTypeTargetUnderPoint(gP:Point, classToFind:Class, parentContenerDrag:DisplayObjectContainer, id:String):I_DragClicTarget
		{
			
				if (drop.hitTestPoint(gP.x,gP.y)) return drop;
			
			return null;
		}
		
		/*resolution d'un drop*/
		override protected function evt_dragAction(event:EventDragClic):void
		{
			// TODO Auto Generated method stub
			super.evt_dragAction(event);
		}
		
		
		
		
		
	}
}