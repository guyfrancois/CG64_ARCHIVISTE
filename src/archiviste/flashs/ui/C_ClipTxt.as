package archiviste.flashs.ui
{
	
	
	import archiviste.controllers.DataCollection;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
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
	public class C_ClipTxt extends Sprite
	{
		
		/* -------- Éléments définis dans le Flash ------------------------- */
		
		/* ----------------------------------------------------------------- */
		
		private var _lang:String=null;
		public function C_ClipTxt()
		{
			super();
			
			
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
			var tf:TextField = getChildAt(0) as TextField;
			if (tf == null) return;
			tf.autoSize=TextFieldAutoSize.LEFT;
			var ref:String = getQualifiedClassName(this);
			
			var txtId:String = ref.substring(ref.indexOf("_")+1);
			
			var daCo:DataCollection = DataCollection.instance;
			var str:String = daCo.getText(txtId, _lang);
			var strIsHtml:Boolean = daCo.isHtml(txtId, _lang); 
			if (strIsHtml) 
			{
				tf.htmlText = str;
			} else {
				tf.text = str;
			}
			trace(txtId+"->"+tf.htmlText);
		}

	}
}