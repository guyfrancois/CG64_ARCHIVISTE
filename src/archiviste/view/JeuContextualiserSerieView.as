package archiviste.view
{
	import archiviste.cc.gen.CaseACocher;
	import archiviste.events.GameControllerEvent;
	import archiviste.model.OG_ContextualiserDoc;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [1 oct. 2012][GUYF] creation
	 *
	 * archiviste.view.JeuContextualiserSerieView
	 */
	public class JeuContextualiserSerieView extends Sprite
	{
		public static var GAMECOMPLETE:String="GAMECOMPLETE";
		public static var GAMEINCOMPLETE:String="GAMEINCOMPLETE";
		
		private var v_docsSeries:Vector.<CaseACocher>;
		public function JeuContextualiserSerieView()
		{
			super();
			if (stage) evt_added(null);
			else addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,evt_removed,false,0,true);
		}
		
		protected function evt_removed(event:Event):void
		{
			GameControllerEvent.channel.removeEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false);
		}
		
	
		
		protected function evt_added(event:Event):void
		{
			if ( testCompleteAll()) {
				dispatchEvent(new Event(GAMECOMPLETE));
			} else {
				dispatchEvent(new Event(GAMEINCOMPLETE));
				GameControllerEvent.channel.addEventListener(GameControllerEvent.ASK_GAME_CONCLUSION,evt_abandon,false,0,true);
			}
			
		}
		
		protected function evt_abandon(event:Event):void
		{
			dispatchEvent(new Event(GAMECOMPLETE));
		}
		
		public function setModel(model:OG_ContextualiserDoc):void {
			var i:int = 0;
			v_docsSeries=new Vector.<CaseACocher>(model.v_serie.length);
			for (i; i < model.v_serie.length; i++) 
			{
				var item:CaseACocher = getChildByName('serie_'+i)  as CaseACocher;
				v_docsSeries[i]=item;
				item.setModel(model.v_serie[i]);
				item.addEventListener(CaseACocher.COMPLETE,evt_caseCheck,false,0,true);
			}
			for (i; i < 4; i++) 
			{
				removeChild(getChildByName('serie_'+i));
			}
		}
		
		protected function evt_caseCheck(event:Event):void
		{
			// TODO Auto-generated method stub
			if ( testCompleteAll()) {
				// corriger ce qui manque
				for (var i:int = 0; i < v_docsSeries.length; i++) 
				{
					if(v_docsSeries[i].isEnable()) v_docsSeries[i].showReponse();
				}
				dispatchEvent(new Event(GAMECOMPLETE));
			}
			
		}
		
		protected function testCompleteAll():Boolean {
			var isComplete:Boolean=true;
			for (var i:int = 0; i < v_docsSeries.length; i++) 
			{
				if (v_docsSeries[i].isRep ) {
					if (v_docsSeries[i].isEnable()==true)  isComplete=false;
				} else {
					//if (v_docsSeries[i].isEnable()==false) return true;
				}
			}
			return isComplete;
			
		}
	}
}