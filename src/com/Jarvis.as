package com
{
	import com.data.define.FileConst;
	import com.data.define.ModuleDefine;
	import com.data.define.Path;
	import com.data.define.PathManager;
	import com.data.model.ConfigModel;
	import com.data.model.ViewModel;
	import com.event.Eventer;
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.EncodeHintType;
	import com.google.zxing.common.BitMatrix;
	import com.google.zxing.common.flexdatatypes.HashTable;
	import com.google.zxing.qrcode.QRCodeWriter;
	import com.jarvisUse.ModuleLoading;
	import com.manager.ModelManager;
	import com.manager.RegistManager;
	import com.ui.UIManager;
	import com.ui.module.main.ConsoleView;
	import com.ui.module.main.view.IBaseView;
	import com.util.AssetsCallBack;
	import com.util.FileUtil;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
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
		private static var console:ConsoleView;
		public static var hasChange:Boolean = false;
		
		public static var views:Vector.<IBaseView> = new Vector.<IBaseView>();
		public function Jarvis(s:JarvisSingleton){}
		public static var isCtrl:Boolean = false;
		public static function init(main:Main):void{
			RegistManager.registClass();
			App.init(main);
			UIManager.init(main);
			eventer = Eventer.getInstance();
			model=new ModelManager();
			path=new PathManager();
			moduleLoader = ModuleLoading.JUse::getInstance();
			initEvent();
			
//			var ss:Object = {"\r\talskdjalskdj":{
//										"pathList":[
//														{"path1":'E:\P\CompilerTool\bin-debug\A'}
//													]
//													
//												}
//											};
//			var zz:String = JSONUtil.encode(ss);
//			trace(JSONUtil.decode(zz));
			loadViewXml();
		}
		
		private static function initEvent():void
		{
			UIManager.stage.addEventListener(Event.RESIZE,onResize);
			UIManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			UIManager.stage.addEventListener(KeyboardEvent.KEY_UP,keyUP);
		}
		
		protected static function keyUP(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.CONTROL:
				{
					isCtrl = false;
					break;
				}
				default:
				{
					break;
				}
			}
		}
		protected static function keyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.S:
				{
					if(isCtrl){
						saveAllChange();
						isCtrl = false;
					}
					break;
				}
				case Keyboard.CONTROL:
				{
					if(!isCtrl){
						UIManager.stage.focus = UIManager.main;
						isCtrl = true;
					}
					break;
				}
					
					
				default:
				{
					break;
				}
			}
			
		}
		private static function saveAllChange():void{
			FileUtil.saveAllFile();
		}
		private static function viewChange():void
		{
			hasChange = true;
		}
		
		protected static function onResize(event:Event):void
		{
			UIManager.doResize();
		}
		private static function loadViewXml():void{
			var loadList:Array = [{url: PathManager.dUrls[Path.ViewXML],type:ResLoader.TXT}];
			loadList.push({url: PathManager.dUrls[Path.CompSWF],type:ResLoader.SWF})
			App.loader.loadAssets(loadList,new Handler(function():void{
				var config:ConfigModel =  ConfigModel.New(Path.ViewXML,["id"],ViewModel,model.initViewModel);
				AssetsCallBack.configModel(config);
				StartLoading();
			}));
		}
		
		private static function StartLoading():void
		{
			UIManager.showView(ModuleDefine.StartLoading);
		}
		
		public static function showMainModule():void{
			UIManager.JUse::showMainModule();
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
		public static function dispatcherEvent(eventName:String,param:* = null):Boolean{
			return eventer.notice(eventName,param);
		}
		/**
		 * 监听全局广播 
		 * @param eventName [GlobalEvent事件类型]
		 * @param param		附带的参数
		 * @return 
		 * 
		 */		
		public static function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeak:Boolean = false):void{
			eventer.addEventListener(type,listener,useCapture,priority,useWeak);
		}
		/**
		 * 监听全局广播 
		 * @param eventName [GlobalEvent事件类型]
		 * @param param		附带的参数
		 * @return 
		 * 
		 */		
		public static function removeEventListener(type:String,listener:Function,useCapture:Boolean = false):void{
			eventer.removeEventListener(type,listener,useCapture);
		}
		public static function move(x:int,y:int):void{
			UIManager.move(x,y);
		}
		public static function setConsole(view:ConsoleView):void{
			console = view;
		}
		public static function addText(str:String,strType:String = FileConst.SYS_DOING):void{
			console.appendText(str,strType);
		}
		public static function copy():void{
			FileUtil.copy();
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * 二维码  
		 * @param qrStr 任何字符
		 * @return 
		 * 
		 */		
		public static function QRtest(qrStr:String):BitmapData{
			var p:Object = new Object();
			p.charset = "UTF-8";
			var _param:HashTable = new HashTable(2);
			_param.Add(EncodeHintType.CHARACTER_SET, p.charset);
			var qr:QRCodeWriter = new QRCodeWriter();
			var bitM:BitMatrix = qr.encode(qrStr,BarcodeFormat.QR_CODE,0,0,_param) as BitMatrix;
			var w:int = bitM.width, h:int = bitM.height;
			var bmp:BitmapData = new BitmapData(w, h);
			for (var i:int = 0; i < w; i++) {
				for (var j:int = 0; j < h;j++) {
					bmp.setPixel(i, j, bitM._get(i,j)?0:0xffffff);
				}
			}
			return bmp;
		}
	}
}
class JarvisSingleton{}