package archiviste.controllers
{
	import archiviste.events.GameControllerEvent;
	import archiviste.events.NavigationEvent;
	import archiviste.factory.PuzzlePieceFactory;
	import archiviste.model.OG_ABS;
	import archiviste.model.OG_Puzzle;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import pt.utils.Clips;
	
	import utils.MyTrace;
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [2 oct. 2012][GUYF] creation
	 *
	 * archiviste.view.PuzzleDeliver
	 */
	public class PuzzleDeliver extends EventDispatcher
	{
		/* Gestion du singleton */
		static protected var _instance:PuzzleDeliver;
		static public function get instance():PuzzleDeliver
		{
			return (_instance != null) ? _instance : new PuzzleDeliver();
			
		}
		
		
		public function PuzzleDeliver(target:IEventDispatcher=null)
		{
			super(target);
			_instance=this;
			
		}
		public function initPuzzle():void {
			
			s_puzzle=buildPuzzle();
			initGameListeners();
		}
		
		private function initGameListeners():void {
			GameControllerEvent.channel.addEventListener(GameControllerEvent.SHOW_PROGRESSION_UPDATE,evt_progressUpdate,false,0,false);
		}
		
		protected function evt_progressUpdate(event:GameControllerEvent):void
		{
			if (GameController.instance.progression<=0) {
			} else	if (GameController.instance.progression==1) {
				updatePuzzle();
			} else {
				NavigationEvent.dispatch(NavigationEvent.SEND_PUZZLE_PIECE,v_pieces[GameController.instance.progression-1]);
			}
			
		}
		
		
		private var model:OG_Puzzle;
		
		public function updatePuzzle():void {
			if (GameController.instance.currentLvl) {
				model = OG_ABS.getOGByIdLvl("puzzle",GameController.instance.currentLvl) as OG_Puzzle;
				getImage(model.image);
			}
		}
		
		
		private var url:String;
		private var imgContent:DisplayObject;
		private var s_puzzle:Sprite;
		private function getImage(file:String):void {
			imgContent=null;
			
			
			url =  ParamsHub.instance.getString('url_images'); 
			var tokens:Object = {};
			tokens.file = file ;
			
			url = TokenUtil.replaceTokens(url, tokens);
			
			var il:Loader=new Loader();
			il.contentLoaderInfo.addEventListener(Event.COMPLETE,completeImageHandler,false,0,true);
			il.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,evt_error,false,0,true);
			il.load(new URLRequest(url));
		}
		
		protected function evt_error(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			MyTrace.put("chargement impossible :"+url,MyTrace.LEVEL_ERROR);
			dispatchEvent(new Event("COMPLETE"));
		}
		
		private function completeImageHandler(e:Event ):void {
			trace(e);
			imgContent=(e.currentTarget as LoaderInfo).content;
			_createPieces();
			NavigationEvent.dispatch(NavigationEvent.SEND_PUZZLE_PIECE,v_pieces[GameController.instance.progression-1]);
		}
		private  var v_pieces:Vector.<PuzzlePieceFactory>;
		public function getPieces():Vector.<PuzzlePieceFactory> {
			return v_pieces;
		}
		public var fitScale:Number;
		private function _createPieces():void{
			imgContent
			
			var maxWitdh:Number=ParamsHub.getNumber("max_puzzle_width",636);
			var maxHeight:Number=ParamsHub.getNumber("max_puzzle_height",400);
			fitScale=Math.min(maxWitdh/imgContent.width,maxHeight/imgContent.height);
		//	imgContent.scaleX=imgContent.scaleY=fitScale;
			
			v_pieces=new Vector.<PuzzlePieceFactory>(s_puzzle.numChildren);
			for (var i:Number=0;i<v_pieces.length;i++) {
				var piece:PuzzlePieceFactory=new PuzzlePieceFactory(s_puzzle.getChildAt(i) as Sprite,imgContent,fitScale);
				v_pieces[i]=piece;
			}
		}
		
		private function buildPuzzle():Sprite {
			var cl:Class=Clips.classFromLib("lib_puzzleMap",GameController.instance.main.loaderInfo.applicationDomain);
			var item:Sprite= new  cl() as Sprite;
			return item;
		}
	}
}