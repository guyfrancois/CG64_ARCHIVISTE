package archiviste.view
{
	import archiviste.model.BlocSaisie;
	
	import com.greensock.TweenMax;
	
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.casalib.transitions.Tween;
	
	import pensetete.events.Dispatch;
	
	import pt.utils.Clips;
	
	import tools.FocusChange;
	
	import utils.DelayedCall;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [3 sept. 2012][GUYF] creation
	 *
	 * archiviste.view.BlocSaisieView
	 */
	public class BlocSaisieView extends MovieClip
	{
		public var rep:MovieClip;
		public var fond:MovieClip;
		public var texteClip:MovieClip;
		
		private var fltTF:TLFTextField;
		private var texte_ref:String;
		private var blocSaisie:BlocSaisie;
		private var flt_ref:TLFTextField;
		
		private var isInit:Boolean;
		
		public function BlocSaisieView()
		{
			super();
			trace("new BlocSaisieView");
			stop();
		
			
		}
		
		public function get isOk():Boolean
		{
			return blocSaisie.isOk;
		}

		public function set isOk(value:Boolean):void
		{
			blocSaisie.isOk = value;
		}

		
		
		public function init(blocSaisie:BlocSaisie,flt_ref:TLFTextField):void {
			this.blocSaisie=blocSaisie;
			this.flt_ref=flt_ref;
			if (stage) evt_added();
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			
		}
		
		protected function evt_added(event:Event=null):void
		{
			// TODO Auto-generated method stub
			_init()
		}		
		
		private function _init():void {
			if (isInit) return;
			isInit=true;
			fltTF = texteClip.getChildAt(0) as TLFTextField; 
			trace("init",blocSaisie.texte);
			trace(blocSaisie.startIndex,flt_ref.getLineIndexOfChar(blocSaisie.startIndex));
			trace(blocSaisie.endIndex,flt_ref.getLineIndexOfChar(blocSaisie.endIndex));
			
			var r:Rectangle=flt_ref.getCharBoundaries(blocSaisie.startIndex);
			
			
			var r2:Rectangle=flt_ref.getCharBoundaries(blocSaisie.endIndex);
			r=r.union(r2);
			r.inflate(0,5);
			x=r.x+flt_ref.x;
			y=r.y+flt_ref.y;
			rep.x=fond.width=r.width;
			rep.y=fond.height=r.height;
			//fltTF.autoSize=TextFieldAutoSize.CENTER;
			fltTF.htmlText=blocSaisie.texte;
			fltTF.maxChars=blocSaisie.texte.length;
			fltTF.restrict="^_"
			//fltTF.autoSize=TextFieldAutoSize.NONE;
			texte_ref=fltTF.text;
			fltTF.width=r.width;
			fltTF.text="";
			fltTF.type=TextFieldType.INPUT;
			fltTF.addEventListener(Event.CHANGE,evt_txtChange,false,0,true);
			fltTF.addEventListener(FocusEvent.FOCUS_IN,evt_in,false,0,true);
			fltTF.addEventListener(FocusEvent.FOCUS_OUT,evt_out,false,0,true);
			rep.visible=false;
			fond.gotoAndStop(2);
			fltTF.mouseEnabled;
			mouseChildren=true;
		}
		
		protected function evt_out(event:FocusEvent):void
		{
			trace("evt_out",fltTF.text);
			showTest();
		}
		
		protected function evt_in(event:FocusEvent):void
		{
			trace("evt_in",fltTF.text);
			gotoAndStop(2);
			fond.gotoAndStop(3);
			rep.visible=false;
			TweenMax.killTweensOf(rep);
		}
		
		protected function evt_txtChange(event:Event):void
		{
			trace("evt_txtChange",fltTF.text);
			if (compare_texte()) {
				_showTestTrue();
			} 
		}
		
		
		private function _showTestVide():void {
			gotoAndStop(1);
			fond.gotoAndStop(2);
			rep.visible=false;
		}
		private function _showTestTrue():void {
			helper__showTestTrue();
			
			dispatchEvent(new Event("VALIDE"));
			rep.alpha=1;
			rep.visible=true;
			rep.scaleX=rep.scaleY=0;
			TweenMax.to(rep,1,{scaleX:1,scaleY:1,onComplete:onComplete_repVisibleFalse});
			
		}
		public function abandon():void {
			if (isOk) return;
			helper__showTestTrue();
		}
		
		private function helper__showTestTrue():void {
			isOk=true;
			var tfor:TextFormat = fltTF.getTextFormat();
			gotoAndStop(3);
			fond.gotoAndStop(4);
			
			
			mouseEnabled=false;
			mouseChildren=false;
			fltTF.removeEventListener(Event.CHANGE,evt_txtChange);
			fltTF.removeEventListener(FocusEvent.FOCUS_IN,evt_in);
			fltTF.removeEventListener(FocusEvent.FOCUS_OUT,evt_out);
			var cl:Class=Clips.classFromLib("lib_input_text",this.loaderInfo.applicationDomain);
			var item:MovieClip= new  cl() as MovieClip;
			removeChild(texteClip);
			addChild(item);
			fltTF = item.getChildAt(0) as TLFTextField; 
			var ft:TextFormat=new TextFormat();
			ft.align=TextFormatAlign.CENTER;
			fltTF.width=fond.width;
			fltTF.type=TextFieldType.DYNAMIC;
			fltTF.htmlText=blocSaisie.texte;
			fltTF.setTextFormat(ft);
		}
		
		
		private function _showTestFalse():void {
			gotoAndStop(4);
			fond.gotoAndStop(5);
			
			rep.alpha=1;
			rep.visible=true;
			rep.scaleX=0;
			rep.scaleY=0;
			TweenMax.to(rep,1,{scaleX:1,scaleY:-1,onComplete:onComplete_repVisibleFalse});
		}
		
		private function showTest():void {
			if (StringUtils.removeExtraWhitespace(fltTF.text)=="") {
				_showTestVide();
			} else 	if (compare_texte()) {
				_showTestTrue();
			}  else {
				_showTestFalse();
			}
		}
		
		public function compare_texte():Boolean {
			// repuperer plutot une reponse possible hors texte
			var aComparer:String=texte_ref;
			var r:RegExp=/_/g;
			aComparer=aComparer.toUpperCase().replace(r," ");
			var texte:String=StringUtils.removeExtraWhitespace(fltTF.text).toUpperCase();
			var distance:uint=StringUtils.editDistance(texte,aComparer);
			trace("texte",texte,"aComparer",aComparer,"distance",distance);
// TODO voir si la distance est utile
			if (distance<1) {
				return true;
			} else {
				return false;
			}
		}
		private function onComplete_repVisibleFalse():void {
			if (isOk) {
				
				
			}
			TweenMax.to(rep,1,{alpha:0,visible:false});
			
		}
	}
}