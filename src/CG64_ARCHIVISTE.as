package
{
	import archiviste.TestTlf;
	import archiviste.controllers.GameController;
	import archiviste.controllers.PuzzleDeliver;
	import archiviste.dd.classer.DragClicControler;
	import archiviste.dd.classer.DragClicInitiateur;
	import archiviste.dd.classer.DragClicMover;
	import archiviste.dd.classer.DragClicTarget;
	import archiviste.dd.nommer.DragClicInitiateur;
	import archiviste.flashs.F_Archiviste;
	import archiviste.flashs.ui.C_ClipTlf;
	import archiviste.flashs.ui.C_ClipTxt;
	import archiviste.flashs.ui.C_ui_BlocPuzzle;
	import archiviste.flashs.ui.C_ui_JeuTextes;
	import archiviste.flashs.ui.C_ui_LvlTextes;
	import archiviste.flashs.ui.C_ui_PuzzleTextes;
	import archiviste.flashs.ui.C_ui_SalleImage;
	import archiviste.flashs.ui.C_ui_SalleTextes;
	import archiviste.flashs.ui.C_ui_TlfTextScrollId;
	import archiviste.flashs.ui.C_ui_gameContainer;
	import archiviste.flashs.ui.C_ui_gameProgress;
	import archiviste.flashs.ui.C_ui_pieceShow;
	import archiviste.flashs.ui.boutons.C_ui_BtnGame;
	import archiviste.flashs.ui.boutons.C_ui_BtnGame_Salle;
	import archiviste.flashs.zoom.C_ui_zoom;
	import archiviste.view.BlocSaisieView;
	import archiviste.view.JeuClasserView;
	import archiviste.view.JeuContextualiserView;
	import archiviste.view.JeuDechiffrerView;
	import archiviste.view.JeuIdentifierView;
	import archiviste.view.JeuNommerView;
	import archiviste.view.JeuPuzzleView;
	import archiviste.view.TextDechiffrerView;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.text.Font;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [31 août 2012][GUYF] creation
	 *
	 * .CG64_ARCHIVISTE
	 */
	[SWF(width="900",height="600")]
	public class CG64_ARCHIVISTE extends Sprite
	{
		
		[Embed(source='../assets/UNVR57W.TTF', 
        fontName='Univers Condensed medium', 
		
        embedAsCFF='true'
     )]
		private var UNVR57W:Class;
		
		[Embed(source='../assets/UNVR58W.TTF', 
        fontName='UNVR58W', 
		
        mimeType='application/x-font',
        embedAsCFF='true'
     )]
		private var UNVR58W:Class;
		
		[Embed(source='../assets/UNVR67W.TTF', 
        fontName='Univers Condensed Gras', 
        mimeType='application/x-font',
		fontFamily="Univers Condensed",
		fontWeight="bold",
        embedAsCFF='true'
     )]
		private var UNVR67W:Class;
		
		[Embed(source='../assets/UNVR68W.TTF', 
        fontName='UNVR68W', 
        mimeType='application/x-font',
        embedAsCFF='true'
     )]
		private var UNVR68W:Class;
		
		public function CG64_ARCHIVISTE()
		{
			GameController.DEBUG=true;
			Font.registerFont(UNVR57W);
			Font.registerFont(UNVR58W);
			Font.registerFont(UNVR67W);
			Font.registerFont(UNVR68W);
			
			var loaderBeforeInit:Loader = new Loader();
			var image:URLRequest = new URLRequest("../swf/NomDeCodeArchiviste.swf");
			addChild(loaderBeforeInit);
			loaderBeforeInit.contentLoaderInfo.addEventListener(Event.COMPLETE,evt_complet,false,0,true);
			loaderBeforeInit.load(image)
		}

		protected function evt_complet(event:Event):void
		{
			trace(listFonts());
		}
		
		private function keep():void{
			TestTlf;
			BlocSaisieView;
			F_Archiviste;
			C_ui_SalleTextes;
			C_ClipTlf;
			C_ui_LvlTextes;
			C_ui_JeuTextes;
			C_ui_SalleImage;
			TextDechiffrerView;
			C_ui_gameContainer;
			JeuDechiffrerView
			JeuClasserView;
			C_ui_zoom;
			
			JeuNommerView;
			JeuIdentifierView;
			JeuContextualiserView;
			PuzzleDeliver
			C_ui_pieceShow
			C_ui_gameProgress
			JeuPuzzleView
			C_ui_BlocPuzzle
			C_ClipTxt
			C_ui_TlfTextScrollId
			C_ui_BtnGame
			C_ui_BtnGame_Salle
			archiviste.dd.nommer.DragClicInitiateur
			C_ui_PuzzleTextes
			
		}
		private function listFonts():String {
			var out:String="";
			var fontArray:Array = Font.enumerateFonts(false);
			out += "Fonts: \n";
			for(var i:int = 0; i < fontArray.length; i++) {
				var thisFont:Font = fontArray[i];
				out += "FONT " + i + ":: name: " + thisFont.fontName + "; typeface: " + 
					thisFont.fontStyle + "; type: " + thisFont.fontType;
				
				if (thisFont.fontType == "embeddedCFF"||thisFont.fontType == "embedded") {
					out += "*";              
				}            
				out +=  "\n";
				
			}
			return out;
			
		}
	}
}