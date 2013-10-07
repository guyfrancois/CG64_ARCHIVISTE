package archiviste.view
{
	import archiviste.controllers.GameController;
	import archiviste.controllers.PuzzleDeliver;
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	import archiviste.factory.PuzzlePieceFactory;
	import archiviste.flashs.ui.C_ClipTlf;
	import archiviste.flashs.ui.C_ui_TlfTextDyn;
	import archiviste.flashs.ui.C_ui_TlfTextDyn_fix;
	import archiviste.flashs.vignettes.C_ui_vignettes;
	import archiviste.flashs.zoom.C_ui_zoom;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_ABS_Doc;
	import archiviste.model.OG_Dechiffrer;
	import archiviste.model.OG_Identifier;
	import archiviste.model.OG_IdentifierDoc;
	import archiviste.model.OG_IdentifierSeries;
	import archiviste.model.OG_Puzzle;
	
	import com.greensock.TweenMax;
	import com.yourmajesty.models.AbstractXMLPopulatedModel;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import org.casalib.util.ArrayUtil;
	
	import pensetete.dragDrop.ABS_DragClicTarget;
	import pensetete.dragDrop.DragContener;
	import pensetete.events.Dispatch;
	
	import pt.utils.Clips;
	
	import utils.DelayedCall;
	import utils.MyTrace;
	import utils.movieclip.MovieClipUtils;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [14 sept. 2012][GUYF] creation
	 *
	 * archiviste.view.JeuIdentifierView
	 * libZoneJeu_identifier
	 */
	public class JeuPuzzleView extends Sprite implements I_GameModelView
	{
		/* elements presents dans sur la scene */
		public var docZoom:C_ui_zoom;
		public var conteneur:MovieClip;
		
		//public var compteurDoc:String;
		/*-----------------------------------*/
		private var v_pieces:Vector.<PuzzlePieceFactory>;
		private var model : OG_Puzzle;
		
		private var isInit:Boolean;
		
		private var _complete:Boolean=false;
		
		public function isComplete():Boolean
		{
			return _complete;
		}
		

		public function JeuPuzzleView()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		public function getId():String		{	return model.id;	}
		public function getType():String	{	return model.type;	}
		public function setModel(model:OG_ABS):void {	
			this.model=model as OG_Puzzle;
		}
		
		
		
		protected function evt_added(event:Event):void	{	
			init();
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_PUZZLE_CONCLUSION,evt_abandon,false,0,true);
			
		}

		protected function evt_removed(event:Event):void	{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.SHOW_PUZZLE_CONCLUSION,evt_abandon,false);
		}
		
		protected function evt_abandon(event:Event):void
		{
			_complete=true;
			replaceAll();
		}
		
		private function init():void{
			if (isInit) {
				if (isComplete()) {
					evt_docComplete(null);
				} else {
					evt_docInComplete(null);
				}
				return;
			}
			isInit=true;
			removeChild(docZoom);
			var pieceFilters:Array=conteneur.imgPieces.filters;
			
			conteneur.imgPieces.filters=[];
				
			docZoom.visible=false;
			docZoom.minZoom=model.getMinZoom();
			docZoom.maxZoom=model.getMaxZoom();
			docZoom.defautZoom=model.getDefautZoom();
			docZoom.image=model.image;
			var pieceReceiver:Sprite=new Sprite();
			pieceReceiver.mouseEnabled=false;
			conteneur.imgPieces.addChild(pieceReceiver);
			//pieceReceiver.scaleX=pieceReceiver.scaleY=PuzzleDeliver.instance.fitScale;
				
			v_pieces=PuzzleDeliver.instance.getPieces();
			for (var i:Number=0;i<v_pieces.length;i++) {
				
				//pieceReceiver.filters=pieceFilters;
				pieceReceiver.addChild(v_pieces[i]);
				v_pieces[i].filters=pieceFilters;
				v_pieces[i].addEventListener("DROP",evt_drop,false,0,true);
			
			}
			evt_docInComplete(null);
		
		}
		
		private function isPuzzleDone():Boolean {
			var r:Rectangle;
			for each (var it:PuzzlePieceFactory in v_pieces) {
				var p2:Point = new Point(it.x,it.y);
				if (r) {
					if (!r.containsPoint(p2)) {
						return false;
					}
				} else {
					r=new Rectangle(p2.x,p2.y);
					r.inflate(30,30);
				}
			}
			return true;
		}
		
		protected function evt_drop(event:Event):void
		{
			// TODO Auto-generated method stub
			if (isPuzzleDone()){
				trace("PuzzleDone");
				replaceAll();
				_complete=true;
			} else {
				trace("!PuzzleDone");
			}
			
			
		}		
		
		private function replaceAll():void
		{
			var p:Point = new Point(0,0);
			
			//TweenMax.allTo(v_pieces,1,{x:p.x,y:p.y},0,onCompleteTweenEnd);
			for each (var it:PuzzlePieceFactory in v_pieces) {
				TweenMax.to(it,1,{x:-it.width/2,y:-it.height/2,onComplete:onCompleteTweenEnd});
				
			}
		}	
		
		private function onCompleteTweenEnd():void {
			if (docZoom.visible) return;
			//removeChild(conteneur);
			addChild(docZoom);
			//conteneur.visible=false;
			docZoom.visible=true;
			docZoom.alpha=0;
			TweenMax.to(docZoom,1,{alpha:1});
			TweenMax.to(conteneur,1,{alpha:0});
			evt_docComplete(null);
		}
	
		
		
		protected function evt_docInComplete(event:Event):void	{	
			new DelayedCall(NavigationEvent.dispatch,50,NavigationEvent.DO_INVALIDER);
			NavigationEvent.dispatch(NavigationEvent.DO_INVALIDER);	
		}
		protected function evt_docComplete(event:Event):void
		{
			new DelayedCall(NavigationEvent.dispatch,50,NavigationEvent.DO_VALIDER,model.conclusion);
			NavigationEvent.dispatch(NavigationEvent.DO_VALIDER,model.conclusion);
		}
	}
}