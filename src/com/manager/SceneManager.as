package com.manager
{
	import com.data.define.ModuleDefine;
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.ui.UIManager;
	
	import flash.events.Event;
	
	import morn.core.components.Component;
	
	/**
	 * 场景管理器 :: UIManager使用，不对外使用
	 * @author msdark.wang
	 */
	public class SceneManager {
		private static var SM:SceneManager;
		private var curScene:Component;
		private var preScene:Component;
		private var curSceneId:int;
		//
		public static function getInstance():SceneManager{
			return SM==null? SM = new SceneManager : SM;
			
		}
		
		public function onResize(e:Event=null):void {
			var ww:Number = UIManager.stage.stageWidth;
			var hh:Number = UIManager.stage.stageHeight;
			if(curScene){
				curScene.x = (ww-curScene.width)/2;
				curScene.y = (hh-curScene.height)/2;
			}
		}
		
		//
		public function showScene(scene:Component):void{
			FrameManager.getInstance().closeAllFrame();
			preScene = curScene;
			curScene = scene;
			curSceneId = scene.componentId;
			UIManager.addToLayer(curScene,UIManager.LAYER_SCENE);
			onResize();
			curScene.mouseEnabled = curScene.mouseChildren = false;
			if(preScene){
				preScene.mouseEnabled = preScene.mouseChildren = false;
				preScene.visible = false;
				curScene.alpha = 0;
				var tween:TweenLite = TweenLite.to(curScene,0.1,{alpha:1,ease:Circ.easeInOut,onComplete:
				function():void{fadComplete();tween.kill()}});
					UIManager.disposeObject(preScene);
			}else{
				curScene.alpha = 0;
				var tween2:TweenLite = TweenLite.to(curScene,0.1,{alpha:1,ease:Circ.easeInOut,onComplete:
					function():void{tween2.kill()}});
				fadComplete();
			}
			curScene.mouseEnabled = curScene.mouseChildren = true;
		}
		//
		private function fadComplete():void{
			if(curScene){
				curScene.afterShow();
				curScene.alpha = 1;
			}
			if(preScene){
				preScene = null;
			}
		}
		public function getCurScene():Component{
			return curScene;
		}
		
		public function clearPre():void{
			UIManager.disposeObject(curScene);curScene=null;
			preScene = null;
		}
		
		//
		public function clear():void{
			UIManager.disposeAll(UIManager.sceneLayer);
		}
		//
		public function hasScene(sceneId:int):Boolean{
			if(curScene){
				return curScene.componentId == sceneId;
			}
			return false;
		}
	}
}
