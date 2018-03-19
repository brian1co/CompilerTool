package com.manager
{
	import com.Jarvis;
	import com.data.model.ViewModel;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Strong;
	import com.ui.UIManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import avmplus.getQualifiedClassName;
	
	import morn.core.components.Component;
	import morn.core.components.Image;
	import morn.core.components.List;
	import morn.core.components.Panel;
	import morn.dispose.Disposeable;

	public class FrameManager{
		
		private static var FM:FrameManager;
		private var frameMap:HashMap;
		
		public static function getInstance():FrameManager{
			return FM==null? FM = new FrameManager : FM;
		}
		
		public function FrameManager(){
			frameMap = new HashMap();
			
		}
		
		public function onResize(e:Event=null):void {
			var w:Number = UIManager.stage.stageWidth;
			var h:Number = UIManager.stage.stageHeight;
			var len:int = frameMap.length;
			for(var i:int=0;i<len;i++){
				var _view:Component = frameMap.getValueByIndex(i);
				_view.x = (w-_view.width)/2;
				_view.y = (h-_view.height)/2;
			}
		}
		
		public function showFrame($view:Component,isBlur:Boolean=true,allowSame:Boolean=false,layer:int=0,$special:Boolean=false):void{
			$view.transform.matrix = new Matrix();
			var viewModel:ViewModel =Jarvis.model.getViewModel($view.componentId);
			var w:Number = UIManager.stage.stageWidth;
			var h:Number = UIManager.stage.stageHeight;
			var p:Point = new Point(int((w-$view.width)/2),int((h-$view.height)/2));
			frameMap.put($view.componentId,$view);
			var hasModelBg:Boolean = false;
			if(viewModel){
				var list:Array = viewModel.openList;
				for(var i:int=0;i<list.length;i++){//检测关联视图
					var viewId:int = list[i];
					var old:Component = frameMap.getValue(viewId) as Component;
					if(old){//重新计算
						var ww:int = old.width + $view.width;
						var leftx:int = (w - ww)/2;
						var oldx:int;
						var oldModel:ViewModel = Jarvis.model.getViewModel(viewId);
						if(oldModel.hasBg){
							hasModelBg = true;
						}
						if(oldModel.autoDir == "right"){
							p.x = leftx;
							oldx = leftx+$view.width;
						}else{
							oldx = leftx;
							p.x = leftx+old.width;
						}
						old.alpha = 0;
						var tweenOpen:TweenLite = TweenLite.to(old,0.2,{x:oldx,y:(h-UIManager.STAGE_H)/2,alpha:1,scaleX:1,scaleY:1,
							overwrite:1,
						onComplete:function():void{
							tweenOpen.kill();
							old.afterShow();
							
						}});
						break;
					}
				}
			}
			
			if(isBlur && !hasModelBg){
				if(Jarvis.model.getViewModel($view.componentId)){
					Jarvis.model.getViewModel($view.componentId).hasBg = true;
				}
				showBackGround($view,layer);
			}
			if(!$special){
				if(layer == 0){
					UIManager.addToLayer($view,UIManager.LAYER_DIALOG);
				}else if(layer==UIManager.LAYER_TIP){
					UIManager.addToLayer($view,UIManager.LAYER_TIP);
				}else if(layer>=UIManager.LAYER_CHAT){
					UIManager.addToLayer($view,UIManager.LAYER_UP_CHAT);
				}else if(layer==UIManager.LAYER_DOWN_CHAT){
					UIManager.addToLayer($view,UIManager.LAYER_DOWN_CHAT);
				}
			}
			
			$view.x = p.x;
			$view.y = p.y+$view.height/3;
			$view.alpha = 0;
//			view.rotationX = 0;
			$view.scaleX = $view.scaleY = 1;
			var tween:TweenLite = TweenLite.to($view,0.4,{alpha:1,y:p.y,x:p.x,scaleX:1,scaleY:1,ease:Circ.easeOut,
					onComplete:function():void{
						tween.kill();
						tween = null;
						$view.scaleX = $view.scaleY = 1;
						if(viewModel && viewModel.forceView>0){
							UIManager.showView(viewModel.forceView);
						}
						$view.afterShow();
					}
				}
			);
		}
		
		public static function setCenter(view:Component):void{
			var p:Point = new Point((1000-view.width)/2,(600-view.height)/2);
			var tween:TweenLite = TweenLite.to(view,0.4,{y:p.y - view.height/2 + 200,x:p.x - view.width/2,ease:Strong.easeOut,
				onComplete:function():void{
					tween.kill();
				}
			}
			);
			
		}
		
		//
		public function closeFrame($view:Component, closeCb:Function = null, needTween:Boolean = true):void{
			if(!$view){
				return;
			}
			frameMap.remove($view.componentId);
			removeBackGround($view);
			//tip关闭
			
			//
			if(needTween){
				var w:Number = UIManager.stage.stageWidth;
				var h:Number = UIManager.stage.stageHeight;
				var p:Point = new Point(w/2,h/3);
				var tween:TweenLite = TweenLite.to($view,0.3,{alpha:0,ease:Strong.easeOut,
					onComplete:function():void{
						tween.kill();
						closeView();
					}
				}
				);
			}else{
				closeView();
			}
			function closeView():void{
				if(closeCb != null){
					closeCb.call();
				}
				closeComplete($view);
			}
			//
			var viewModel:ViewModel = Jarvis.model.getViewModel($view.componentId);
			if(viewModel){
				var list:Array = viewModel.closeList;
				for(var i:int=0;i<list.length;i++){//检测关联视图
					var viewId:int = list[i];
					var close:Component = frameMap.getValue(viewId) as Component;
					if(close){
						closeFrame(close);
					}
				}
				for (var j:int = 0; j < viewModel.openList.length; j++) {
					var middle:Component = frameMap.getValue(viewModel.openList[j]) as Component;
					if(middle){
						var w2:Number = UIManager.stage.stageWidth;
						var h2:Number = UIManager.stage.stageHeight;
						p = new Point((w2-middle.width)/2,(h2-middle.height)/2);
						TweenLite.to(middle, 0.3, {x:p.x, y:p.y});
					}
				}
				
			}
		}
		private var backGroundNumber:int;
		//
		private function showBackGround(view:DisplayObject,layer:int = 0):void{
//			var alpha:Number = .55;
//			if(backGroundNumber>0){
//				alpha = 0.55;
//			}
//			var sp:Sprite = UIManager.createRect(3000,1200,0x000000,alpha);
//			sp.name = view.name + "___background";
//			if(layer==UIManager.LAYER_SYS){
//				UIManager.addToLayer(sp,UIManager.LAYER_SYS);
//			}else if(layer>=UIManager.LAYER_CHAT){
//				UIManager.addToLayer(sp,UIManager.LAYER_CHAT);
//			}else{
//				UIManager.addToLayer(sp,UIManager.LAYER_DIALOG);
//			}
//			sp.x = 0;
//			sp.y = 0;
//			backGroundNumber ++;
		}
		//
		private function removeBackGround(view:DisplayObject):void{
			var bg:DisplayObject = UIManager.dialogLayer.getChildByName(view.name + "___background");
			var bg2:DisplayObject = UIManager.chatLayer.getChildByName(view.name + "___background");
			var bg3:DisplayObject = UIManager.sysLayer.getChildByName(view.name + "___background");
			if(bg){
				UIManager.disposeObject(bg);
				backGroundNumber --;
			}
			if(bg2){
				UIManager.disposeObject(bg2);
				backGroundNumber --;
			}
			if(bg3){
				UIManager.disposeObject(bg3);
				backGroundNumber --;
			}
		}
		
		//检测视图是否存在
		private function isExist($view:Component):Boolean{
			if(frameMap.containsKey($view.componentId)){
				var comp:Component = frameMap.getValue($view.componentId) as Component;
				var c1:String = getQualifiedClassName(comp);
				var c2:String = getQualifiedClassName($view);
				if(c1 == c2){
					UIManager.disposeObject($view);
					return true;
				}
			}
			return false;
		}
		public function hasFrame(viewId:int):Boolean{
			return frameMap.getValue(viewId) != null;
		}
		
		public function closeFrameById(viewId:int):void{
			var frame:Component = frameMap.getValue(viewId);
			if(frame){
				closeFrame(frame);
			}
		}
		
		//
		public function get hasFrames():Boolean{
			if(!frameMap){
				return false;
			}
			if(frameMap.isEmpty){
				return false;
			}
			return true;
		}
		public function getFrame(viewId:int):Component{
			return frameMap.getValue(viewId) as Component
		}
		
		public function closeAllFrame():void{
			UIManager.clear(UIManager.dialogLayer);
			frameMap.clear();
		}
		
		private function closeComplete(view:DisplayObject):void{
			UIManager.disposeObject(view);
			App.tip.visible = true;
		}
	
	}
}