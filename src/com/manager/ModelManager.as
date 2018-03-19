package com.manager
{
	import com.data.model.ViewModel;

	/**
	 * @desc	:	ModelManager
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午12:50:05
	 * 
	 */
	public class ModelManager
	{
		private static var viewMap:HashMap;
		public function ModelManager()
		{
		}
		public function parseJSON($data:Array,modelClass:*,ids:Array=null):HashMap{
			var map:HashMap = new HashMap();
			for(var i:int=0;i<$data.length;i++){
				var _model:Object=new modelClass();
				var obj:Object = $data[i];
				for( var str:String in obj){
					_model[str] = obj[str];
				}
				var key:String=getCombKey(ids,_model);
				map.put(key,_model);
			}
			return map;
		}
		/**
		 *获得组合后的key,多个id以"_"分割
		 * 格式： playerId_equipId_ 
		 * 
		 */		
		private function getCombKey(ids:Array,model:Object):String{
			var key:String="";
			if(ids.length==1) return model[ids[0]].toString();
			for(var i:int=0,len:int=ids.length;i<len;i++){
				key=key.concat(model[ids[i]]+"_");
			}
			return key;
		}
		/**
		 * 解析XML数据
		 * @param data
		 * @param modelClass
		 * @return
		 */
		public function parseXML(data:*,modelClass:Class,id:String="id"):HashMap {
			var map:HashMap = new HashMap();
			var xml:XML=new XML(data);
			var items:XMLList=xml..item;
			if(items.length()>0) {
				for(var i:int=0;i<items.length();i++) {
					var _model:Object=new modelClass();
					copyPorpertiesByXML(_model,items[i]);
					map.put(_model[id],_model);
				}
			}
			return map;
		}
		
		private function copyPorpertiesByXML(object:Object,$data:XML):void {
			var attr:XMLList=$data.attributes();
			for each(var item:XML in attr) {
				var propname:String=item.name().toString();
				if(object.hasOwnProperty(propname)) {
					try {
						var value:String=item.toString();
						if(object[propname] is Boolean){
							object[propname]=Boolean(parseInt(value));
						}else if(object[propname] is int || object[propname] is Number){
							object[propname]= parseFloat(value);
						}else{
							object[propname]=value;
						}
					} catch(e:Error) {
						trace("copyPorpertiesByXML ERROR:",e.message);
					}
				}
			}
		}
		//----------------------------------------------------
		public function initViewModel(map:HashMap):void{
			viewMap = map;
		}
		public function getViewModel(viewId:int):ViewModel{
			return viewMap.getValue(viewId);
		}
	}
}