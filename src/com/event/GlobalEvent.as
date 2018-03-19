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