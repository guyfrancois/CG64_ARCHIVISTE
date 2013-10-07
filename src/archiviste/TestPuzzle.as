package archiviste
{
	import archiviste.factory.PuzzlePieceFactory;
	
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [4 sept. 2012][GUYF] creation
	 *
	 * archiviste.TestPuzzle
	 */
	public class TestPuzzle extends Sprite
	{
		public var test:MovieClip;
		public var img:MovieClip;
		
		private var v_pieces:Vector.<PuzzlePieceFactory>;
		
		public function TestPuzzle()
		{
			super();
			var container:Sprite=new Sprite();
			container.scaleX=container.scaleY=0.5;
			container.x=400;
			container.y=300;
			removeChild(test);
			removeChild(img);
			v_pieces=new Vector.<PuzzlePieceFactory>(test.numChildren);
			for (var i:Number=0;i<test.numChildren;i++) {
				var piece:PuzzlePieceFactory=new PuzzlePieceFactory(test.getChildAt(i) as Sprite,img);
				container.addChild(piece);
				piece.addEventListener("DROP",evt_drop,false,0,true);
				v_pieces[i]=piece;
				
			}
			addChild(container);
			
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
			} else {
				trace("!PuzzleDone");
			}
			
			
		}		
		
		private function replaceAll():void
		{
			var p:Point = new Point(v_pieces[0].x,v_pieces[0].y);
			for each (var it:PuzzlePieceFactory in v_pieces) {
				TweenMax.to(it,1,{x:p.x,y:p.y});
			}
		}
		
	}
}