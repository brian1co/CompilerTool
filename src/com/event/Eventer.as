package com.event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	

	
	/**
	 * @desc	:	Eventer 全局事件处理
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 上午11:14:32
	 * 
	 */
	public class Eventer extends EventDispatcher
	{
		private static var _bs:Eventer;
		public function Eventer(bs:BroadCastSingleton,target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function getInstance():Eventer{
			return _bs?_bs:new Eventer(new BroadCastSingleton);
		}
		/**
		 * 全体广播 
		 * @param evtName
		 * @param param
		 * 
		 */		
		public function notice(evtName:String , param:* = null):Boolean
		{
			var evt:GlobalEvent = new GlobalEvent(evtName,param);
			return this.dispatchEvent(evt);
		}
	}
}
class BroadCastSingleton{}