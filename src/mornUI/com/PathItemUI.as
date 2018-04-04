/**Created by the Morn,do not modify.*/
package mornUI.com {
	import morn.core.components.*;
	public class PathItemUI extends View {
		public var input:TextInput = null;
		public var liulanBtn:Button = null;
		public var dakaiBtn:Button = null;
		protected static var uiXML:XML =
			<View width="500" height="30">
			  <TextInput skin="png.comp.textinput" font="Arial" y="4" left="0" right="100" x="2" align="right" var="input" isHtml="false" editable="false"/>
			  <Button label="···" skin="png.comp.button" x="407" y="3" labelFont="Arial" width="30" var="liulanBtn"/>
			  <Button label="打开" skin="png.comp.button" x="442" y="3" labelFont="Arial" width="50" var="dakaiBtn"/>
			</View>;
		public function PathItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}