package com
{
	import com.data.define.ModuleDefine;
	import com.data.define.Path;
	import com.data.define.PathManager;
	import com.data.model.ConfigModel;
	import com.data.model.ViewModel;
	import com.event.Eventer;
	import com.event.GlobalEvent;
	import com.jarvisUse.ModuleLoading;
	import com.manager.ModelManager;
	import com.manager.RegistManager;
	import com.ui.UIManager;
	import com.util.AssetsCallBack;
	
	import flash.events.Event;
	
	import morn.core.handlers.Handler;
	import morn.core.managers.ResLoader;

	/**
	 * 中央管理器 
	 * @author brian.li
	 * 
	 */	
	public class Jarvis
	{
		public static var model:ModelManager
		private static var eventer:Eventer;
		private static var path:PathManager;
		private static var moduleLoader:ModuleLoading;
		
		
		public function Jarvis(s:JarvisSingleton){}
		
		public static function init(main:Main):void{
			RegistManager.registClass();
			App.init(main);
			UIManager.init(main);
			eventer = Eventer.getInstance();
			model=new ModelManager();
			path=new PathManager();
			moduleLoader = ModuleLoading.JUse::getInstance();
			
			initEvent();
			
			loadViewXml();
		}
		
		private static function initEvent():void
		{
			UIManager.stage.addEventListener(Event.RESIZE,onResize);
		}
		
		protected static function onResize(event:Event):void
		{
			UIManager.doResize();
		}
		private static function loadViewXml():void{
			App.loader.loadAssets([{url: PathManager.dUrls[Path.ViewXML],type:ResLoader.TXT}],new Handler(function():void{
				var config:ConfigModel =  ConfigModel.New(Path.ViewXML,["id"],ViewModel,model.initViewModel);
				AssetsCallBack.configModel(config);
				StartLoading();
			}));
		}
		
		private static function StartLoading():void
		{
			eventer.addEventListener(GlobalEvent.STARTLOAD_SUCCESS,startLoadingComplete);
			UIManager.showView(ModuleDefine.StartLoading);
		}
		/**
		 * 加载界面 
		 * @param viewId
		 * @param callBack
		 * 
		 */		
		public static function loadView(viewId:int,callBack):void{
			moduleLoader.loadView(viewId, callBack);
		}
		/**
		 * 发送全局广播 
		 * @param eventName [GlobalEvent事件类型]
		 * @param param		附带的参数
		 * @return 
		 * 
		 */		
		public static function noticeEvent(eventName:String,param:* = null):Boolean{
			return broadCast.notice(eventName,param);
		}
		
	}
}
class JarvisSingleton{}