package archiviste
{
	import archiviste.model.BlocSaisie;
	import archiviste.view.BlocSaisieView;
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.flash_proxy;
	
	import flashx.textLayout.events.StatusChangeEvent;
	import flashx.textLayout.events.UpdateCompleteEvent;
	
	import pensetete.components.ScrollBarV;
	
	import pt.utils.Clips;
	
	import utils.DelayedCall;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [31 août 2012][GUYF] creation
	 *
	 * .TestTlf
	 */
	public class TestTlf extends Sprite
	{
		public var texte:MovieClip;
		private var  fltTF:TLFTextField;
	//	private var matchexp:String="\\[((?:\\[|[^\\]])*)\\]";
		private var strTexte:String='test [Guy-François_à_l\'école] guy-françois à l\'école, consectetur adipiscing elit. Nam dignissim tristique bibendum. Nam quis hendrerit hendrerit hendrerit dui [REPO_NSE1]<br>Ante est, nec iaculis ligula. Aliquam a dignissim metus. Duis consequat nunc eros. Morbi non turpis magna, sit amet fermentum enim. Curabitur enim sem, mattis a dictum at, hendrerit pharetra odio. In gravida iaculis erat, nec tincidunt turpis [REPONSE2_nec_tincidunt_turpis] amet. Suspendisse nec nibh id elit mattis cursus. Etiam quis turpis risus, a semper tortor. Curabitur accumsan molestie varius. Donec quis quam nisi, eget suscipit sapien. Nam eleifend turpis enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In molestie vehicula purus quis [REPONSE3] Nam ac arcu id ante scelerisque elementum at in est [REPONSE4] sit amet. Suspendisse nec nibh id elit mattis cursus. Etiam quis turpis risus, a semper tortor. Curabitur accumsan molestie varius. Donec quis quam nisi, ' ;
		
		private var v_blocSaisies:Vector.<BlocSaisie>;
		
		public var masque:Sprite;
		
		public var scrollbar:ScrollBarV;
		
		public function TestTlf()
		{
			super();
		
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void
		{
			v_blocSaisies=new Vector.<BlocSaisie>();
			
			// TODO : affecter le texte à rechercher
			strTexte+=strTexte;
			
			fltTF = texte.getChildAt(0) as TLFTextField; 
			fltTF.autoSize=TextFieldAutoSize.LEFT;
			fltTF.htmlText = strTexte;
			trace(fltTF.text);
			
			//var tfor:TextFormat = new TextFormat(null, 18.4);
			//fltTF.setTextFormat(tfor);
			fltTF.selectable = false;
			fltTF.alwaysShowSelection = false;
			fltTF.mouseEnabled = false;
			fltTF.type=TextFieldType.DYNAMIC;
			texte.mouseChildren = true;
			texte.mouseEnabled = true;
			/*
			fltTF.textFlow.addEventListener(UpdateCompleteEvent.UPDATE_COMPLETE,fUpdate,false,0,true);
			fltTF.textFlow.addEventListener("inlineGraphicStatusChanged",iUpdate,false,0,true);
			
			*/
			init();
			//new DelayedCall(init,1000);
			scrollbar.viewport=texte;
			scrollbar.visibleH=masque.height;
			scrollbar.mouseWheelSpeed=5;
			scrollbar.refresh();
		}
		
		public function reset():void {
			scrollbar.scrollV=0;
			texte.y=0;
			scrollbar.refresh();
		}
	
		
		private function init():void{
		
			var str:String=fltTF.text;
			var bloc:BlocSaisie;
			
			for (var i:Number=0;i<str.length;i++) {
				if (!bloc && str.charAt(i)=='[') {
					bloc=new BlocSaisie(i,"",i);
					
					
				} else if (bloc && str.charAt(i)==']') {
					bloc.endIndex=i;
					bloc.texte=str.substr(bloc.startIndex+1,bloc.endIndex-bloc.startIndex-1);
					v_blocSaisies.push(bloc);
					buildFillText(bloc);
					bloc=null;
				}
			}
			
			
			
			
		}
		
	
		
		
		private function buildFillText(bloc:BlocSaisie):void {
			item_toFind++;
			var r:Rectangle=fltTF.getCharBoundaries(bloc.startIndex);
			var r2:Rectangle=fltTF.getCharBoundaries(bloc.endIndex);
			r=r.union(r2);
			r.inflate(5,5);
			//testDrawRec(r.x,r.y,r.width,r.height);
//
			
			var cl:Class=Clips.classFromLib("lib_blocTexte",this.loaderInfo.applicationDomain);
			var item:BlocSaisieView= new  cl() as BlocSaisieView;
			item.addEventListener("VALIDE",evt_valide,false,0,true);
			texte.addChild(item);
			item.init(bloc,fltTF);
			
		
		}
		
		
		public var item_toFind:Number=0;
		protected function evt_valide(event:Event):void
		{
			item_toFind=0;
			for each (var i:BlocSaisie in v_blocSaisies) 
			{
				if (!i.isOk) {
					
					item_toFind++;
				}
			}
/////////////////////////////////////////////////////////////////////	
			if (item_toFind==0) {
				trace("saisie complete");
			}
/////////////////////////////////////////////////////////////////////
			// TODO : valider l'activiter
			
		}
		
		/*
		private function testDrawRec(x:int,y:int,width:int,height:int):void {
			trace("testDrawRec",x,y,width,height);
			var s:Sprite=new Sprite();
			s.graphics.beginFill(0xFF0000,0.8);
			s.graphics.drawRect(0,0,width,height);
			s.graphics.endFill();
			s.x=x;
			s.y=y;
			texte.addChild(s);
			
			
		}
		*/
	}
}