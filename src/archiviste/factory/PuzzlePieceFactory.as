package archiviste.factory
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.engine.SpaceJustifier;
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [10 sept. 2012][GUYF] creation
	 *
	 * archiviste.factory.PuzzlePieceFactory
	 */
	public class PuzzlePieceFactory extends Sprite
	{
		private var result:BitmapData;
		private var s:Sprite;
		// placement empilé
		public var cx:Number;
		public var cy:Number;
		
		public var scale:Number=1;
		
		public function PuzzlePieceFactory(decoupe:Sprite,image:DisplayObject,scale:Number=1)
		{
			super();
			this.scale=scale;
			mouseChildren=false;
			mouseEnabled=false;
			//image.scaleX=image.scaleY=scale;
			//decoupe.width=image.width*scale;
			//decoupe.height=image.height*scale;
			var bmpd:BitmapData=new BitmapData(decoupe.width,decoupe.height,true,0);
			var ibmpd:BitmapData=new BitmapData(decoupe.width,decoupe.height,true,0);
			
			
			
			
			
			
			bmpd.draw(decoupe,new Matrix(1,0,0,1,decoupe.x,decoupe.y));
			ibmpd.draw(image,new Matrix(scale,0,0,scale,(decoupe.width-image.width*scale)/2,(decoupe.height-image.height*scale)/2));
			
			result = new BitmapData( decoupe.width,decoupe.height, true, 0 );
			
			result.copyPixels(ibmpd, result.rect, new Point(), bmpd, new Point(), false);
			
			s=new Sprite();
			
			
			cx=x=-decoupe.x;
			cy=y=-decoupe.y;
			
			s.addChild(new Bitmap(result));
			/*
			var g:Sprite=new Sprite();
			g.graphics.beginFill(0xFF);
			g.graphics.drawCircle(decoupe.x,decoupe.y,10);
			g.graphics.endFill();
			s.addChild(g);
			*/
			
			//s.scaleX=s.scaleY=scale
			addChild(s);
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
			
		}
		
		protected function evt_removed(event:Event):void
		{
			// TODO Auto-generated method stub
			removeEventListener(MouseEvent.MOUSE_UP,evt_up,false);
			removeEventListener(MouseEvent.MOUSE_MOVE,evt_move,false);
		}
		
		protected function evt_added(event:Event):void
		{
			// TODO Auto-generated method stub
			addEventListener(MouseEvent.MOUSE_UP,evt_up,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,evt_move,false,0,true);
		}
		protected function evt_move(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			var pColor : uint = result.getPixel32(s.mouseX,s.mouseY);
			var a: Number = (pColor>>24 & 0xFF);
			/*
			var r: Number = (pColor>>16 & 0xFF);
			var g: Number = (pColor>>8  & 0xFF);
			var b: Number = (pColor     & 0xFF);
			*/
			//trace("a",a,"r",r,"g",g,"b",b);
			if (a==0xFF) {
				mouseChildren=false;
				mouseEnabled=true;
				buttonMode=true;
				addEventListener(MouseEvent.MOUSE_DOWN,evt_down,false,0,true);
			} else {
				mouseChildren=false;
				mouseEnabled=false;
				buttonMode=false;
				removeEventListener(MouseEvent.MOUSE_DOWN,evt_down,false);
			}
		}
		
		protected function evt_up(event:MouseEvent):void
		{
			stopDrag();
			dispatchEvent(new Event("DROP"));
		}
		
		protected function evt_down(event:MouseEvent):void
		{
			parent.addChild(this);
			startDrag();
		}
		
	}
}