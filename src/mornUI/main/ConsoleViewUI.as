/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	public class ConsoleViewUI extends View {
		public var panel:Panel = null;
		public var textArea:TextArea = null;
		protected static var uiXML:XML =
			<View width="1000" height="200">
			  <Panel var="panel" width="1020" height="200">
			    <Box>
			      <Image url="png.startLoading.loading" width="1000" sizeGrid="25,25,25,25" height="200" y="0" x="0"/>
			      <Image url="png.startLoading.loading" width="1000" sizeGrid="25,25,25,25" height="200" y="0" x="0"/>
			      <TextArea skin="png.comp.blank" x="13" y="3" width="975" height="194" sizeGrid="2,2,2,2" selectable="true" leading="2" font="Arial" letterSpacing="0" color="0xffffff" var="textArea" align="left" size="13" scrollBarSkin="png.comp.vscroll" editable="false" isHtml="true"/>
			    </Box>
			  </Panel>
			</View>;
		public function ConsoleViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}