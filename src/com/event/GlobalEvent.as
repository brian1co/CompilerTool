package com.event
{
	import flash.events.Event;
	
	/**
	 * @desc	:	GlobalEvent
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午6:39:43
	 * 
	 */
	public class GlobalEvent extends Event
	{
		/** 初始化加载成功 */
		public static const STARTLOAD_SUCCESS:String = "STARTLOAD_SUCCESS";
		/** 切换界面 */
		public static const SWITCH_VIEW:String = "SWITCH_VIEW";
		/** 加载配置文件成功 */
		public static const SAVEJSON_LOADCOMPLETE:String = "SAVEJSON_LOADCOMPLETE";
		/** 有修改 */
		public static const VIEW_CHANGED:String = "VIEW_CHANGED";
		
		private var _data:*;
		public function GlobalEvent(type:String , data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data; 
		}
		public function get data():* {
			return _data;
		}
		public function set data(value:*):void {
			_data=value;
		}
		override public function clone():Event{
			return new GlobalEvent(type, data, bubbles, cancelable);
		}
	}
}