package archiviste.flashs.ui
{
	import archiviste.controllers.DataCollection;
	import archiviste.controllers.GameController;
	
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.ImageLoader;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	
	/**
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [12 sept. 2012][GUYF] creation
	 *
	 * archiviste.flashs.ui.C_ui_SalleTextes
	 */
	public class C_ui_SalleImage extends Sprite
	{
	
		public function C_ui_SalleImage()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,evt_added,false,0,true);
		}
		
		protected function evt_added(event:Event):void
		{
			var file:String = ParamsHub.instance.getString("img_salle_"+GameController.instance.currentSalle,"img_salle");
			addChild(getImage(file).content);
		}
		
		
		private function getImage(file:String):ImageLoader {
			var url:String;
			url =  ParamsHub.instance.getString('url_images'); 
			var tokens:Object = {};
			tokens.file = file ;
			
			url = TokenUtil.replaceTokens(url, tokens);
			var il:ImageLoader=new ImageLoader(url,{container:this,scaleMode:ScaleMode.PROPORTIONAL_OUTSIDE,width:width,height:height,crop:true});
			il.load();
			return il;
		}
		
	}
}