package archiviste
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [4 sept. 2012][GUYF] creation
	 *
	 * archiviste.TestPuzzle
	 */
	public class FirstTestPuzzle extends Sprite
	{
		public var test:MovieClip;
		public var img:MovieClip;
		
		private var bmp:Bitmap;
		private var s:Sprite;
		private var result:BitmapData;
		
		public function TestPuzzle()
		{
			super();
			removeChild(test);
			var masque:MovieClip = test.getChildAt(0)as MovieClip;
			var img:MovieClip = img;
			
			
			var bmpd:BitmapData=new BitmapData(masque.width,masque.height,true,0);
			var ibmpd:BitmapData=new BitmapData(masque.width,masque.height,true,0);
			
			
			
			
		
			
			bmpd.draw(masque);
			ibmpd.draw(img,new Matrix(1,0,0,1,(masque.width-img.width)/2,(masque.height-img.height)/2));
			
			result = new BitmapData( masque.width,masque.height, true, 0 );
			
			result.copyPixels(ibmpd, result.rect, new Point(), bmpd, new Point(), true);
			
			s=new Sprite();
			
			
			
			s.addEventListener(MouseEvent.MOUSE_UP,evt_up,false,0,true);
			s.addEventListener(MouseEvent.MOUSE_MOVE,evt_move,false,0,true);
			s.addChild(new Bitmap(result));
			addChild(s);
			
		}
		
		protected function evt_move(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var pColor : uint = result.getPixel32(event.localX,event.localY);
			var a: Number = (pColor>>24 & 0xFF);
			var r: Number = (pColor>>16 & 0xFF);
			var g: Number = (pColor>>8  & 0xFF);
			var b: Number = (pColor     & 0xFF);
			trace("a",a,"r",r,"g",g,"b",b);
			if (a==0xFF) {
				s.buttonMode=true;
				s.addEventListener(MouseEvent.MOUSE_DOWN,evt_down,false,0,true);
			} else {
				s.buttonMode=false;
				s.removeEventListener(MouseEvent.MOUSE_DOWN,evt_down,false);
			}
		}
		
		protected function evt_up(event:MouseEvent):void
		{
			s.stopDrag();
		}
		
		protected function evt_down(event:MouseEvent):void
		{
			s.startDrag();
		}
	}
}