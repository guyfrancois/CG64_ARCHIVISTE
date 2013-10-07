package archiviste.flashs.ui
{
	
	
	import archiviste.controllers.DataCollection;
	
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getQualifiedClassName;

	/**
	 * Clases de controle d'un champs texte tf répartir sur 3 frames pour potionnement/stylage selon la langue
	 *
	 * @author Sps
	 * @version 1.0.0 [6 janv. 2012][Sps] creation
	 *
	 * citeespace.planisphere.flashs.clips.C_ClipTxtLocalizable
	 */
	public class C_ClipTlf extends Sprite
	{
		
		/* -------- Éléments définis dans le Flash ------------------------- */
		
		/* ----------------------------------------------------------------- */
		
		private var _lang:String=null;
		private var fltTF:TLFTextField;
		public function C_ClipTlf()
		{
			super();
		
			
			fltTF = getChildAt(0) as TLFTextField; 
			
			fltTF.autoSize=TextFieldAutoSize.LEFT;
			fltTF.wordWrap=true;
			fltTF.selectable = false;
			fltTF.alwaysShowSelection = false;
			fltTF.mouseEnabled = false;
			fltTF.visible=false;
			mouseChildren=false;
			
			
			if (stage) onAddedToStage_C_ClipTxtLocalizable(null);
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage_C_ClipTxtLocalizable, false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage_C_ClipTxtLocalizable, false,0,true);
			
		}
		
		
		protected function onAddedToStage_C_ClipTxtLocalizable(event:Event):void
		{
			updateText();
		}
		
		protected function onRemovedFromStage_C_ClipTxtLocalizable(event:Event):void
		{
			
		}
		
		
		
		protected function updateText():void {
			
			var ref:String = getQualifiedClassName(this);
			
			var txtId:String = ref.substring(ref.indexOf("_")+1);
			
			var daCo:DataCollection = DataCollection.instance;
			var str:String = daCo.getText(txtId, _lang);
			var strIsHtml:Boolean = daCo.isHtml(txtId, _lang); 
			
			var ft:TextFormat=new TextFormat();
			ft.align=TextFormatAlign.CENTER;
			//fltTF.width=fond.width;
			fltTF.type=TextFieldType.DYNAMIC;
			fltTF.htmlText=str;
			fltTF.setTextFormat(ft);
			
			
			fltTF.visible=true
			trace(txtId+"->"+fltTF.text);
			
			//var tfor:TextFormat = new TextFormat(null, 18.4);
			//fltTF.setTextFormat(tfor);
			
			
			
		}

	}
}