package com.data.model
{
	import com.Jarvis;
	import com.data.model.BaseModel;
	
	
	/**
	 *
	 * @author msdark.wang
	 * 创建时间：2014-8-6 下午2:58:27
	 */
	public class ViewModel extends BaseModel{
		
		/**ID*/
		public var id:int;
		/**类型  1场景 2弹框*/
		public var type:int;
		/**开放等级*/
		public var openLevel:int;
		/**模块名（程序用）*/
		public var moduleName:String;
		/**中文名*/
		public var chinaName:String;
		/**同时存在的视图ID*/
		public var openCheckViews:String;
		/**是否强制弹出同时存在的视图*/
		public var forceView:int;
		/**关闭时需被关闭的界面*/
		public var closeCheckViews:String;
		/**默认方向*/
		public var autoDir:String="";
		/**X偏移*/
		public var offsetX:int;
		/**附加资源*/
		public var resources:String="";
		/**功能引导ID*/
		public var openGuideId:int;
		/**功能引导TIP*/
		public var openTxt:String;
		/**同时打开的顺序TIP*/
		public var openOrder:String;
		/**开发者-方便BUG指派*/
		public var developer:String;
		
		//是否有背景黑
		public var hasBg:Boolean = false;
		
		//功能描述
		public var des:String;
		
		public function ViewModel(){
			super();
		}
		
		public function get openList():Array{
			if(!openCheckViews || openCheckViews==""){
				return [];
			}
			var list:Array = openCheckViews.split(",");
			return list;
		}
		
		public function get openOrderList():Array{
			if(!openOrder || openOrder==""){
				return [];
			}
			var list:Array = openOrder.split(",");
			return list;
		}
		
		public function get closeList():Array{
			if(!closeCheckViews || closeCheckViews==""){
				return [];
			}
			var list:Array = closeCheckViews.split(",");
			return list;
		}
		
//		public static function isOpen(viewId:int):Boolean{
//			var _model:ViewModel = Jarvis.model.getViewModel(viewId);
//		}
		
	}
	
}