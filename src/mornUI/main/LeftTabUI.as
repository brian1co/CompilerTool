/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	public class LeftTabUI extends View {
		public var panel:Panel = null;
		public var tabs:Tab = null;
		protected static var uiXML:XML =
			<View width="400" height="600">
			  <Image url="png.main.tabBg" x="0" y="0" sizeGrid="25,25,25,25" width="400" height="600" mouseEnabled="false"/>
			  <Panel width="418" height="600" vScrollBarSkin="png.comp.vscroll" visible="true" right="-18" x="0" y="0" var="panel" mouseEnabled="false">
			    <Tab skin="png.main.tab" x="0" y="0" direction="vertical" var="tabs" mouseEnabled="false" labelBold="false" labelSize="40" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF,0xFFFFFF"/>
			  </Panel>
			</View>;
		public function LeftTabUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}