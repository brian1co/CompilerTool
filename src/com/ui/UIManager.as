package com.ui
{
	import com.JUse;
	import com.Jarvis;
	import com.data.define.ModuleDefine;
	import com.data.model.ViewModel;
	import com.event.GlobalEvent;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.manager.FrameManager;
	import com.manager.SceneManager;
	import com.ui.module.main.MainModule;
	import com.ui.module.startLoading.StartLoadingModule;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.getDefinitionByName;
	
	import morn.core.components.Image;
	import morn.core.components.List;
	import morn.core.components.Panel;
	import morn.core.components.View;
	import morn.dispose.Disposeable;

	use namespace JUse;
	/**
	 * @desc	:	UIManager
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 上午11:12:40
	 * 
	 */
	public class UIManager
	{
		public static const LAYER_BUILD:int=0;
		public static const LAYER_SCENE:int=1;
		public static const LAYER_DOWN_CHAT:int=2;
		public static const LAYER_CHAT:int=3;
		public static const LAYER_UP_CHAT:int=4;
		public static const LAYER_DIALOG:int=5;
		public static const LAYER_TIP:int=6;
		public static const LAYER_EFFECT:int=7;
		public static const LAYER_TOP:int=8;
		public static const LAYER_GUIDE:int=9; //引导层
		public static const LAYER_SYS:int=10;
		public static const LAYER_TOOL:int = 11;
		public static const LAYER_MOUSE_ICON:int = 12;//鼠标跟随图标+
		
		public static var buildLayer:Sprite;
		public static var sceneLayer:Sprite;
		public static var downchatLayer:Sprite;
		public static var upchatLayer:Sprite;
		public static var chatLayer:Sprite;
		public static var dialogLayer:Sprite;
		public static var tipLayer:Sprite;
		public static var effectLayer:Sprite;
		public static var topLayer:Sprite;
		public static var sysLayer:Sprite;
		public static var guideLayer:Sprite; //引导层
		public static var toolLayer			:	Sprite;				//编辑按钮
		public static var mouseLayer		:	Sprite; 			//鼠标跟随
		
		/**默认舞台宽*/
		public static const STAGE_W:int=1000;
		/**默认舞台高*/
		public static const STAGE_H:int=610;
			
		public static var stage:Stage;
		public static var main:Main;
		private static var curViewId:int;
		private static var currentModuleId:int;
		private static var _loadView:StartLoadingModule;
		private static var _mainView:MainModule;
		public static function init(m:Main):void
		{
			main=m;
			stage=main.stage;
//			stage.quality=StageQuality.MEDIUM;
			buildLayer=new Sprite;
			sceneLayer=new Sprite;
			dialogLayer=new Sprite;
			tipLayer=new Sprite;
			downchatLayer=new Sprite
			upchatLayer=new Sprite
			chatLayer=new Sprite
			effectLayer=new Sprite;
			topLayer=new Sprite;
			sysLayer=new Sprite;
			guideLayer=new Sprite;
			toolLayer = new Sprite();
			mouseLayer = new Sprite();
			
			main.addChild(buildLayer);
			main.addChild(sceneLayer);
			main.addChild(downchatLayer);
			main.addChild(chatLayer);
			main.addChild(upchatLayer);
			main.addChild(dialogLayer);
			main.addChild(tipLayer);
			chatLayer.mouseEnabled=false;
			sysLayer.mouseEnabled=false;
			main.addChild(effectLayer);
			main.addChild(topLayer);
			main.addChild(guideLayer);
			main.addChild(sysLayer);
			main.addChild(toolLayer);
			main.addChild(mouseLayer);
			mouseLayer.mouseChildren = false;
			mouseLayer.mouseEnabled = false;
			
		}
		/**
		 * 添加到某层
		 * @param displayObject 显示对象
		 * @param layer 层级
		 */
		public static function addToLayer(displayObject:DisplayObject, layer:int=LAYER_SCENE):void {
			var container:Sprite;
			switch (layer) {
				case LAYER_BUILD:
					container=buildLayer;
					break;
				case LAYER_SCENE:
					container=sceneLayer;
					break;
				case LAYER_DOWN_CHAT:
					container=downchatLayer;
					break;
				case LAYER_CHAT:
					container=chatLayer;
					break;
				case LAYER_UP_CHAT:
					container=upchatLayer;
					break;
				case LAYER_DIALOG:
					container=dialogLayer;
					break;
				case LAYER_TIP:
					container=tipLayer;
					break;
				case LAYER_EFFECT:
					container=effectLayer;
					break;
				case LAYER_TOP:
					container=topLayer;
					break;
				case LAYER_SYS:
					container=sysLayer;
					break;
				case LAYER_GUIDE:
					container=guideLayer;
					break;
				case LAYER_TOOL:
					container = toolLayer;
					break;
				case LAYER_MOUSE_ICON:
					container = mouseLayer;
					break;
				
			}
			container.addChild(displayObject);
		}
		/**
		 * 显示指定视图
		 * @param viewId 使用 ViewModel 常量
		 * @param data 附加参数
		 * @param 依附视图ID
		 * @param 是否从右边出现
		 */
		public static function showView(viewId:int, isBlur:Object=true, needBackId:int=0, _nextViewId:int=0,layer:int = 0):void {
			var viewModel:ViewModel=Jarvis.model.getViewModel(viewId);
			App.tip.closeAll();
			curViewId=viewId;
			
			if (viewModel.type == ModuleDefine.SCENE) {
				
				currentModuleId=viewModel.id;
				
			}
			if (viewModel)
			{
//				trace(viewModel);
				Jarvis.loadView(viewId, function():void { 
					showModule(viewModel, isBlur,layer);
//					SoundManager.getInstance().playSceneMusic(viewId);
				})
//				ModuleLoading.getInstance().loadView(viewId, function():void {
//					showModule(viewModel, isBlur,layer);
//					SoundManager.getInstance().playSceneMusic(viewId);
//				});
			}
		}
		/**
		 * 场景管理 
		 * @param viewModel
		 * @param isBlur
		 * @param layer
		 * 
		 */		
		JUse static function showModule(viewModel:ViewModel, isBlur:Boolean=false,layer:int = 0):void {
			var $view:View=getView(viewModel.moduleName);
			$view.componentId=viewModel.id;
			if (viewModel.type == ModuleDefine.FRAME) {
				FrameManager.getInstance().showFrame($view, isBlur,false,layer);
			} 
			else if(viewModel.type == ModuleDefine.LOAD) {
				if(_loadView)return;
				_loadView = $view as StartLoadingModule;
//				_loadView.showLoadIcon(true);
				addToLayer(loadView,LAYER_TOOL);
				UIManager.showMainModule();
			}else{
				FrameManager.getInstance().closeAllFrame();
				SceneManager.getInstance().showScene($view);
			}
		}
		JUse static function showMainModule():void{
			var viewId:int = ModuleDefine.Main;
			var viewModel:ViewModel=Jarvis.model.getViewModel(viewId);
			Jarvis.loadView(viewId, function():void { 
				_mainView = getView(viewModel.moduleName) as MainModule;
				addToLayer(_mainView,LAYER_BUILD);
//				_loadView.showLoadIcon(false);
			})
		}
		public static function get loadView():StartLoadingModule{
			return _loadView;
		}
		private static function getView(moduleName:String):View 
		{
			var _name:String="com.ui.module." + moduleName + ".";
			//按照最新的命名规则，修改名字
			_name+=moduleName.charAt(0).toLocaleUpperCase();
			_name+=moduleName.substring(1);
			_name+="Module";
			var _view:View=getDefinitionByName(_name).instance() as View;
			return _view;
		}
		/**
		 * 清除对象的引用以便垃圾回收
		 * @param target : 目标对象
		 * 支持几种对象 ：
		 * Disposeable 只执行dispose方法。
		 * Bitmap 会把bitmapData dispose 然后removeChild
		 * BitmapData 会调用dispose
		 * DisplayObject 会removeChild
		 */
		public static function disposeObject(target:Object):void {
			if (target == null) {
				return;
			}
			
			if (target is Image) {
				remove(target as Image);
				//				if(stage.g)
				(target as Image).dispose();
			} else  if(target is List){
				(target as List).dispose();
				remove(target as List);
			}else  if(target is Panel){
				remove(target as Panel);
				UIManager.disposeAll((target as Panel));
			}else if (target is Disposeable) {
				if (target is DisplayObject) {
					remove(target as DisplayObject);
				}
				Disposeable(target).dispose();
			} else if (target is Bitmap) {
				var targetBitmap:Bitmap=Bitmap(target);
				remove(targetBitmap);
				if (targetBitmap.bitmapData)
					targetBitmap.bitmapData.dispose();
			} else if (target is BitmapData) {
				var targetBitmapData:BitmapData=BitmapData(target);
				targetBitmapData.dispose();
			} else if (target is MovieClip) {
				var mc:MovieClip=target as MovieClip;
				mc.stop();
				remove(mc);
			} else if (target is SimpleButton) {
				var btn:SimpleButton=target as SimpleButton;
				remove(btn);
			} else if (target is DisplayObject) {
				remove(target as DisplayObject);
			} else if (target is TweenMax) {
				(target as TweenMax).kill();
			} else if (target is TweenLite) {
				(target as TweenLite).kill();
			} 
			//			else if (target is SpriteSheet) {
			//				(target as SpriteSheet).kill();
			//			}
		}
		public static function disposeAll(container:DisplayObjectContainer):void {
			if (container) {
				while (container.numChildren > 0) {
					disposeObject(container.getChildAt(0));
				}
			}
		}
		/**从舞台删除*/
		public static function remove(dis:DisplayObject):void {
			if (dis && dis.parent) {
				dis.parent.removeChild(dis);
			}
		}
		public static function clear(container:DisplayObjectContainer):void {
			if (container) {
				while (container.numChildren > 0) {
					var obj:DisplayObject=container.removeChildAt(0);
					disposeObject(obj);
				}
			}
		}
		
		public static function doResize():void
		{
			var stageW:int = stage.width;
			var stageH:int = stage.height;
			FrameManager.getInstance().onResize();	
			SceneManager.getInstance().onResize();
			if(loadView)
				loadView.onResize(stageW,stageH);
		}
		
		public static function move(x:int, y:int):void
		{
			stage.nativeWindow.x += x;
			stage.nativeWindow.y += y;
		}
		
	}
}