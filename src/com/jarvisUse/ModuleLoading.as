package com.jarvisUse
{
	import com.JUse;
	import com.Jarvis;
	import com.data.define.PathManager;
	import com.data.model.ViewModel;
	
	import morn.core.handlers.Handler;
	import morn.core.managers.ResLoader;

	use namespace JUse;
	/**
	 * 模块加载器
	 * @author msdark.wang
	 */	
	public class ModuleLoading{ 
		
		private static var ML:ModuleLoading;
		private var viewModel:ViewModel;
//		private var loadingBar:ModuleLoadingBar;
		private var callBack:Function;
		public var isLoading:Boolean;
		JUse static function getInstance():ModuleLoading{
			return ML == null? ML = new ModuleLoading : ML;
		}
		
		public function ModuleLoading(){
		}
		
		public function loadView(viewId:int,callBack:Function=null):void{
			isLoading = true;
			this.viewModel = Jarvis.model.getViewModel(viewId);
			this.callBack = callBack;
//			UIManager.disposeObject(loadingBar);
//			loadingBar = new ModuleLoadingBar();
//			loadingBar.show();
//			var w:Number = UIManager.stage.stageWidth;
//			var h:Number = UIManager.stage.stageHeight;
//			var p:Point = new Point((w-1000)/2,(h-600)/2);
//			loadingBar.x = p.x;
//			loadingBar.y = p.y;
			var list:Array = [];
			list.push({url:PathManager.URL_MORN + viewModel.moduleName+".swf",type:ResLoader.SWF,size:100});
			if(viewModel.resources != null && viewModel.resources != ""){
				var arr:Array = viewModel.resources.split("|");
				for(var i:int=0;i<arr.length;i++){
					var url:String = PathManager.URL_SWF + arr[i];
					var type:int=0;
					var ar:Array = url.split(".");
					if(ar.length > 1){
						var fileType:String = ar[ar.length-1];
						if(fileType.indexOf("swf")>0){
							type == ResLoader.SWF;
						}else if(fileType.indexOf("png")>0 || fileType.indexOf("jpg")>0){
							type == ResLoader.BMD;
						}else if(fileType.indexOf("json")>0 || fileType.indexOf("xml")>0){
							type = ResLoader.TXT;
							url = PathManager.URL_CONFIG + arr[i];
						}
					}
					list.push({url:url,type:type,size:10});
				}
			}
			App.loader.loadAssets(list,new Handler(onComplete),new Handler(onProgress),new Handler(onError));
		}
		
//		//
		private function onComplete(args:* =null):void {
			isLoading = false;
//			loadingBar.hide();
			callBack.apply(null);
		}
//		
		private function onError(args:* ):void {
			trace("view loader error:",viewModel.moduleName);
		}
//		
		private function onProgress(args:Number=0):void {
//			loadingBar.setPrecent(int(100*args));
		}
//		
	}
}