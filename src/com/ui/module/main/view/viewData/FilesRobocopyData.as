package com.ui.module.main.view.viewData
{
	import com.ui.component.data.TwoPathItemData;

	/**
	 * @desc	:	FilesRobocopyData
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-26 下午2:30:36
	 * 
	 */
	public class FilesRobocopyData extends BaseViewData
	{
		public var pathList:Array = [];
		public function FilesRobocopyData(obj:Object,$itemNum:int = 0)
		{
			super(obj,$itemNum);
		}
		override public function setViewData(obj:*):void{
			var tArr:Array = obj as Array;
			for (var i:int = 0; i < tArr.length; i++) 
			{
				var twoPathData:TwoPathItemData = new TwoPathItemData();
				twoPathData.pathData = tArr[i];
				pathList.push(twoPathData); 
			}
			
		}
		public function save():void{
			var tArr:Array = [];
			for (var i:int = 0; i < pathList.length; i++) 
			{
				var obj:Object = {};
				var pObj:TwoPathItemData = pathList[i];
				pObj.save();
				obj.path1 = pObj.path1.path;
				obj.path2 = pObj.path2.path;
				tArr.push(obj);
			}
			jsonObject.pathList = tArr;
			jsonObject.itemNum = itemNum;
		}
		
		override public function hasChange():Boolean{
			var flag:Boolean = false;
			for (var i:int = 0; i < pathList.length; i++) 
			{
				var pObj:TwoPathItemData = pathList[i];
				if(pObj.checkChange())flag = true;
			}
			return flag;
		}
	}
}