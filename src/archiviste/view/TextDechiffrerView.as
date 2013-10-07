package archiviste.view
{
	import archiviste.controllers.DataCollection;
	import archiviste.controllers.GameController;
	import archiviste.events.GameControllerEvent;
	import archiviste.flashs.ui.C_ui_TlfTextDyn;
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
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.tlf_internal;
	
	import pensetete.components.ScrollBarV;
	
	import pt.utils.Bitmaps;
	import pt.utils.Clips;
	
	import utils.DelayedCall;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [31 août 2012][GUYF] creation
	 *
	 * .TestTlf
	 */
	public class TextDechiffrerView extends Sprite
	{
		public static var GAMECOMPLETE:String="GAMECOMPLETE";
		public static var GAMEINCOMPLETE:String="GAMEINCOMPLETE";
		
		/* elements presents sur la scene */
		public var texte:MovieClip;
		public var masque:Sprite;
		public var scrollbar:ScrollBarV;
		public var motRestants:C_ui_TlfTextDyn;
		
		/*---------------------------------*/
		private var  fltTF:TLFTextField;
		
		
	//	private var matchexp:String="\\[((?:\\[|[^\\]])*)\\]";
		private var strTexte:String;
		
		private var v_blocSaisies:Vector.<BlocSaisie>;
		private var v_blocSaisiesView:Vector.<BlocSaisieView>;
		
		private var isInit:Boolean;
		
		public function TextDechiffrerView()
		{
			super();
		
		}
		
		public function setText(texte:String):void {
			strTexte=texte;
		
			if (stage) evt_added();
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
			
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false);
		}
		
		protected function evt_added(event:Event=null):void
		{
			// TODO Auto-generated method stub
			initTextView();
			if (isValide) dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
			else dispatchEvent(new Event(TextDechiffrerView.GAMEINCOMPLETE));
			GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false,0,true);
		}		
		
		
		
		protected function initTextView():void
		{
			if (isInit) return;
			isInit=true;
			v_blocSaisies=new Vector.<BlocSaisie>();
		
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
	
		private var atBarrer:Boolean=false;
		private function init():void{
		
			var str:String=fltTF.text;
			var bloc:BlocSaisie;
			v_blocSaisiesView=new Vector.<BlocSaisieView>();
			for (var i:Number=0;i<str.length;i++) {
				if (str.charAt(i)=='~') {
					fltTF.setTextFormat(new TextFormat("null",10,0xFFFFFF),i,i+1);
					atBarrer=!atBarrer;
					//strike(i);
				} else	if (atBarrer) {
					strike(i);
				}
				
				if (!bloc && str.charAt(i)=='[') {
					bloc=new BlocSaisie(i,"",i);
					
					
				} else if (bloc && str.charAt(i)==']') {
					bloc.endIndex=i;
					bloc.texte=str.substr(bloc.startIndex+1,bloc.endIndex-bloc.startIndex-1);
					v_blocSaisies.push(bloc);
					v_blocSaisiesView.push(buildFillText(bloc));
					bloc=null;
				}
				
				
			}
			
			update_motRestants(v_blocSaisies.length);
			
			
		}
		
		private function update_motRestants(nb:Number):void{
			var daCo:DataCollection = DataCollection.instance;
			var str:String = daCo.getText("ui_mot_restant", null,{nb:nb});
			var strIsHtml:Boolean = daCo.isHtml("ui_mot_restant", null); 
			if (strIsHtml) 
			{
				motRestants.htmlText=str;
			} else {
				motRestants.text = str;
			}
			
			
		}
		
		
		private function buildFillText(bloc:BlocSaisie):BlocSaisieView {
			item_toFind++;
			var r:Rectangle=fltTF.getCharBoundaries(bloc.startIndex);
			var r2:Rectangle=fltTF.getCharBoundaries(bloc.endIndex);
			r=r.union(r2);
			r.inflate(5,5);
			//testDrawRec(r.x,r.y,r.width,r.height);
//
			
			var cl:Class=Clips.classFromLib("lib_blocTexte",GameController.instance.main.loaderInfo.applicationDomain);
			var item:BlocSaisieView= new  cl() as BlocSaisieView;
			item.addEventListener("VALIDE",evt_valide,false,0,true);
			item.init(bloc,fltTF);
			texte.addChild(item);
			return item;
			
		
		}
		
		
		public var item_toFind:Number=0;
		public var isValide:Boolean=false;
		
		protected function evt_valide(event:Event=null):void
		{
			item_toFind=0;
			for each (var i:BlocSaisie in v_blocSaisies) 
			{
				if (!i.isOk) {
					
					item_toFind++;
				}
			}
			update_motRestants(item_toFind);
/////////////////////////////////////////////////////////////////////	
			if (item_toFind==0) {
				isValide=true;
				dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
			}
/////////////////////////////////////////////////////////////////////
			// TODO : valider l'activiter
			
		}
		protected function evt_abandon(event:Event):void
		{
			for (var i:int = 0; i < v_blocSaisiesView.length; i++) 
			{
				v_blocSaisiesView[i].abandon();
			}
			update_motRestants(0);
			isValide=true;
			dispatchEvent(new Event(TextDechiffrerView.GAMECOMPLETE));
		}
		
		private function strike(iChar:Number):void{
			trace("strike "+iChar);
			var r:Rectangle=fltTF.getCharBoundaries(iChar);
			var s:Sprite=new Sprite();
			//s.graphics.lineBitmapStyle(Bitmaps.bitmapFromLib("lib_barre",GameController.instance.main.loaderInfo.applicationDomain),null,true,true);
			s.graphics.lineStyle(2,0x000000,1,true);
			s.graphics.moveTo(0,r.height/2);
			s.graphics.lineTo(r.width,r.height/2);
			s.graphics.endFill();
			s.x=r.x;
			s.y=r.y;
			texte.addChild(s);
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