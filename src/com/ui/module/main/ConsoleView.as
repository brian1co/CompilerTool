package com.ui.module.main
{
	import com.data.define.FileConst;
	
	import mornUI.main.ConsoleViewUI;
	
	/**
	 * @desc	:	ConsoleView
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-22 下午5:53:08
	 * 
	 */
	public class ConsoleView extends ConsoleViewUI
	{
		private var allText:String = "";
		public function ConsoleView()
		{
			super();
		}
		public function appendText(str:String,strType:String):void{
			var fStr:String = formatStr(str,strType);
			textArea.appendText(fStr+"<br>");
			textArea.scrollTo(textArea.textField.numLines);
		}
		
		private function formatStr(str:String, strType:String):String
		{
			var fStr:String = "";
			var frontStr:String = "<font color='#EEEEEE'>";
			var endStr:String = "</font>";
			if(strType == FileConst.SYS_DOING){
				frontStr = "<font color='#EEEEEE'>";
			}else if (strType == FileConst.SYS_WARNING){
				frontStr = "<font color='#FF0000'>";
			}
			fStr = frontStr + str + endStr;
			return fStr;
		}
	}
}