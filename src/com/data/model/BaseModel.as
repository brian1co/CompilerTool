package  com.data.model{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import util.XmlUtil;

	/**
	 * 模版类 基类
	 * @author msdark.wang
	 */
	public class BaseModel {

		public function BaseModel() {
		}

		public function clone():BaseModel {
			var className:String=getQualifiedClassName(this);
			var ObjectType:Class=getDefinitionByName(className) as Class;
			var copyModel:BaseModel=new ObjectType() as BaseModel;
			var xmlList:XMLList=XmlUtil.getProperties(this);
			for (var i:int=0, len:int=xmlList.length(); i < len; i++) {
				var child:XML=xmlList[i];
				copyModel[child.@name]=this[child.@name];
			}
			return copyModel;
		}

		/**BaseModel 重写toString 方便输出LOG*/
		public function toString():String {
			var msg:String="";
			msg+=getQualifiedClassName(this) + "\n{\n";
			var info:XML=describeType(this);
			var properties:XMLList=info..accessor.(@access != "writeonly") + info..variable;
			for each (var propertyInfo:XML in properties) {
				var propertyName:String=propertyInfo.@name;
				msg+="  " + propertyName + ":" + this[propertyName] + "\n";
			}
			msg+="}"
			return msg;
		}

		//将模型对象转换为object对象，方便扩展
		public function toObject():Object {
			var obj:Object={};
			var xmlList:XMLList=XmlUtil.getProperties(this);
			for (var i:int=0, len:int=xmlList.length(); i < len; i++) {
				var child:XML=xmlList[i];
				obj[child.@name]=this[child.@name];
			}
			return obj;
		}

		public function toModel(obj:Object):void {
			var xmlList:XMLList=XmlUtil.getProperties(this);
			for (var i:int=0, len:int=xmlList.length(); i < len; i++) {
				var child:XML=xmlList[i];
				if (obj[child.@name]) {
					this[child.@name]=obj[child.@name];
				}
			}
		}
	}
}
