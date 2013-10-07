package archiviste.controllers
{
	import com.greensock.layout.ScaleMode;
	import com.greensock.loading.ImageLoader;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import org.apache.xinclude4flex.events.MultiProgressEvent;
	import org.apache.xinclude4flex.loaders.XIncludeXMLLoader;
	import org.casalib.util.ArrayUtil;
	
	import utils.params.ParamsHub;
	import utils.strings.TokenUtil;
	
	/** COMPLETE est dispatché lorsque les textes ont été chargés et prêts à 
	 * être exploités */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * archiviste.controllers.DataCollection
	 * Cette classe sert de collecteur des textes et de leur formats poru le jeu de l'adaptation 2011.
	 * 
	 * Cette classe charge automatiquement les données XML à son initialisation. Pour vérifier la disponibilité des données, utilisez un écouteur et le getter xmLoaded comme suit :
	 * <pre>
	var textsColl:DataCollection = DataCollection.instance;
	if (textsColl.xmlLoaded) onTextsReady(null);
	else textsColl.addEventListener(Event.COMPLETE, onTextsReady, false, 0, true);
		</pre> 
	 * @copyright www.pense-tete.com
	 * @author GUYF
	 * @version 1.0.0 [11 sept. 2012][GUYF] creation
	 *
	 * 
	 */
	
	
	
	
	public class DataCollection extends EventDispatcher
	{
		/** Chemin du fichier XML contenant les textes à gérer */
		static public var XML_CONTENTS_PATH:String = '../contents/xml/contents.xml';
		static public var XML_PARAMS_PATH:String = '../contents/xml/params.xml';
		
		/** test de chargement des données */
		public var xmlLoaded:Boolean = false;
		
		/** stockage des données brut */
		private var _loadedXML:XML;
		/** Cette méthode d'accès aux données brutes est essentiellement dsponible à fins de tests et déboguage */
		public function get loadedXML():XML  { return _loadedXML; }
		
		/** stockage des langues */
		private var _languages:Array /*of String*/= [];
		public function get languages():Array { return _languages.concat(); }
		public function set languages(value:Array):void { _languages = value; }
		
		/** stockage des textes */
		protected var textsXmlList:XMLList;
		
		/** stockage des templates */
		protected var templates:Object = {};
		
		/** stockage des données brut de volume */
		public var soundVolumesXmlList:XMLList;
		/**
		 * recuperation des parametres issus xml 
		 * @return 
		 * 
		 */
		static public function get params():ParamsHub
		{
			return ParamsHub.instance;
		}
		
		public function DataCollection()
		{
			if (_instance != null) return;
			
			_instance = this;
			// On charge les données XML poru parser les textes
			_loadXml();
		}
		
		/* ----- Gestion du singleton ----- */
		static private var _instance:DataCollection;
		static public function get instance():DataCollection
		{
			if (_instance == null) new DataCollection();
			return _instance;
		}
		
		
		
		
		
		/* ********************************************************************************************** */
		/*									CHARGEMENT DES XML											  */
		/* ********************************************************************************************** */
		
		protected var _xmlLoadQueue:Array = [];
		protected function _loadXml():void
		{
			// Chargement du XML de paramètrage
			loadXmlFile('params', XML_PARAMS_PATH, onParamsLoad_complete, onParamsLoad_error);
			
			// Chargement du XML de contenus
			loadXmlFile('contents', XML_CONTENTS_PATH, onDataLoad_complete, onDataLoad_complete);
		}
		
		protected function loadXmlFile(loadQueueId:String, strUrl:String, completeCb:Function, errorCB:Function):void
		{
			_xmlLoadQueue.push(loadQueueId);
			var xiLoader:XIncludeXMLLoader = new XIncludeXMLLoader();
			xiLoader.addEventListener(Event.COMPLETE, completeCb);
			xiLoader.addEventListener(ErrorEvent.ERROR, errorCB);
			xiLoader.addEventListener(MultiProgressEvent.PROGRESS, onXmlProgress);
			xiLoader.load(strUrl);
		}
		
		protected function onXmlProgress(event:MultiProgressEvent):void
		{
			trace('multiprogress :' + event.loadIndex +'/'+event.totalLoads); 
		}
		
		protected function checkXmlLoadQueue(loadQueueId:String):void
		{
			// On supprime l'id chargé de la liste d'attente
			ArrayUtil.removeItem(_xmlLoadQueue, loadQueueId);
			
			if (_xmlLoadQueue.length > 0) return;
			
			// On prévient qu'on a fini le chargement
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function onParamsLoad_error(event:IOErrorEvent):void
		{
			throw "Erreur de chargement des paramètres : " + event.text;
		}
		protected function onDataLoad_error(event:IOErrorEvent):void
		{
			throw "Erreur de chargement des données : " + event.text;
		}
		
		public var _rawParamsXml:XML;
		
		protected function onParamsLoad_complete(event:Event):void
		{
			var paramsXML:XML = (event.currentTarget as XIncludeXMLLoader).xml; //new XML((event.currentTarget as URLLoader).data);
			_rawParamsXml = paramsXML;
			
			// Test de chargement du ParamsHub
			params.feed(paramsXML.params.param);
			/*
			var t:* = params.getNumber('showDebugInfo', 2);
			t = params.getString('version');
			*/
			checkXmlLoadQueue('params');
		}
		
		
		protected function onDataLoad_complete(event:Event):void
		{
			var i:int; var iMax:int;
			var xmlNode:XML;
			var xmlItems:XMLList;
			_loadedXML = (event.target as XIncludeXMLLoader).xml;// new XML(event.currentTarget.data);
			xmlLoaded = true;
			
			// On crée la table des références thématiques pour un traitement plus simple
			var xmlParams:XMLList = _loadedXML.contents;
			
			// Récupération des codes de langue
			var t_languages:Array = [];
			xmlItems = _loadedXML.LANGUAGES.Language;
			for (i=0, iMax = xmlItems.length(); i<iMax; i++)
			{
				xmlNode = xmlItems[i];
				if (xmlNode.hasOwnProperty("@code")) t_languages.push(xmlNode.@code.toString());
			}
			_languages = t_languages;
			
			// Récupération des templates
			xmlItems = _loadedXML.textTemplates.template;
			for (i=0, iMax = xmlItems.length(); i<iMax; i++)
			{
				xmlNode = xmlItems[i];
				if (xmlNode.hasOwnProperty("@id")) 
				{
					templates[xmlNode.@id] = xmlNode.toString();
				}
			}
			
			// Stockage des textes
			textsXmlList = _loadedXML.texts.text;
			
			//  Stockage brut des controles sonores
			soundVolumesXmlList = _loadedXML.soundVolume;
			
			// Tests
			/*
			xmlNode = getTextXmlNode('sampleText02', 'FR');
			var strHtml:String = getText('sampleText01', 'FR');
			strHtml = getText('sampleText02', 'FR', {mot:'kamoulox'});
			strHtml = getText('sampleText02dynamic', 'FR', {mot:'kamoulox', fontSize:33});
			*/
			
			checkXmlLoadQueue('contents');
		}
		
		public function getImage(file:String,width:Number,height:Number):ImageLoader {
			var url:String;
			var tokens:Object = {};
			tokens.file = file ;
			url = TokenUtil.replaceTokens(url, tokens);
			var il:ImageLoader=new ImageLoader(url,{scaleMode:ScaleMode.PROPORTIONAL_INSIDE,width:width,height:height});
			return il;
		}
		
		protected function getTextXmlNodes(textId:String, language:String=null):XMLList
		{
			var xmlList:XMLList
			if (language != null) {
				xmlList = textsXmlList.(@id==textId && @language==language);
				if (xmlList.length() == 0) xmlList = null; // résultat non trouvé
			} 
			if (xmlList == null) {
				// le cas language == null est possibel pour les textes d'invitation, affichés avant de connaitre la langue
				// Si la langue n'est pas dans le fichier XML on tombe également ici ce qui permet d'avoir un fallback
				xmlList = textsXmlList.(@id==textId);	
			}
			
			
			
			if (xmlList.length()) return xmlList;
			else return null;
		}
		
		
		
		protected function getTextXmlNode(textId:String, language:String=null):XML
		{
			var xmlList:XMLList = getTextXmlNodes(textId, language);
			if (xmlList == null) return null;
			if (xmlList.length()) return xmlList[0] as XML;
			else return null;
		}
		
		/**
		 * 
		 * @param textId
		 * @param language
		 * @param tokens  Permet de passer des éléments de textes dynamique à 
		 * 				injecter dans le template. Ces éléments seront aussi 
		 * 				bien injectés dans le texte que dans le template 
		 * 				(pour permettre de dynamiquer texte et mise en forme). 
		 * 				Attention la propriété 'text' de tokens sera 
		 * 				systématiquement écrasée, réservée pour injectée le texte.
		 * @return 
		 * 
		 */
		public function getText(textId:String, language:String=null, tokens:Object=null):String
		{
			var out:String = '';
			var xml:XML = getTextXmlNode(textId, language);
			if (xml == null) return out;
			
			var isHtml:Boolean    = false;
			var templateId:String = null;
			var template:String   = null;
			if (xml.hasOwnProperty("@html"))
			{
				var htmlProp:String = xml.@html;
				htmlProp = htmlProp.toLowerCase();
				isHtml = (["true", "1",1].indexOf(htmlProp) > -1); 
			}
			
			if (xml.hasOwnProperty("@template"))
			{
				templateId = xml.@template;
				template = templates[templateId];
			}
			
			var text:String = xml.toString();
			
			if (tokens != null)
			{
				text = TokenUtil.replaceTokens(text, tokens);
			} else {
				tokens = {};
			}
			tokens.text = text;
			
			if (template != null)
			{
				out = TokenUtil.replaceTokens(template, tokens);
			} else {
				out = text;
			}
			
			return out;
		}
		public function applyTemplateOn(xml:XML) :String {
			var out:String= '';
			if (xml == null) return out;
			var templateId:String = null;
			var template:String   = null;
			var tokens:Object= {};
			
			if (xml.hasOwnProperty("@template"))
			{
				templateId = xml.@template;
				template = templates[templateId];
			}
			
			var text:String = xml.toString();
			
			tokens.text = text;
			
			if (template != null)
			{
				out = TokenUtil.replaceTokens(template, tokens);
			} else {
				out = text;
			}
			
			return out;
		}
		
		public function isHtml(textId:String, language:String=null):Boolean
		{
			var out:Boolean = false;
			var xml:XML = getTextXmlNode(textId, language);
			if (xml == null) return out;
			
			if (xml.hasOwnProperty("@html"))
			{
				var htmlProp:String = xml.@html;
				htmlProp = htmlProp.toLowerCase();
				out = (["true", "1",1].indexOf(htmlProp) > -1); 
			}
			return out;
		}
		
		
		public function getTemplate(templateID:String):String
		{
			var out:String = templates[templateID] as String;
			return out;
		}
		
		public function applyTemplate(str:String, templateId:String, tokens:Object=null):String
		{
			var out:String;
			if (tokens == null) tokens = {};
			tokens.text = str;
			out = TokenUtil.replaceTokens(str, tokens);
			
			var template:String = templates[templateId];
			if (template != null) {
				out = TokenUtil.replaceTokens(template, tokens);
			}
			return out;
		}
	}
}