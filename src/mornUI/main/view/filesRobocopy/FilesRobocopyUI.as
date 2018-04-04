/**Created by the Morn,do not modify.*/
package mornUI.main.view.filesRobocopy {
	import morn.core.components.*;
	import com.ui.component.TwoPathItem;
	public class FilesRobocopyUI extends View {
		public var list:List = null;
		public var btnCopy:Button = null;
		public var btnTest:Button = null;
		public var btnPlus:Button = null;
		public var btnMinus:Button = null;
		protected static var uiXML:XML =
			<View width="600" height="600" mouseChildren="true" mouseEnabled="false">
			  <List var="list" spaceY="-20" mouseChildren="true" mouseEnabled="false" y="50" height="450">
			    <TwoPathItem x="0" y="0" runtime="com.ui.component.TwoPathItem" name="render" mouseChildren="true" mouseEnabled="false"/>
			    <VScrollBar skin="png.comp.vscroll" x="582" y="1" width="17" height="599" name="scrollBar"/>
			  </List>
			  <Button label="开始同步" skin="png.comp.button" x="368" y="538" width="185" height="45" labelSize="24" labelBold="true" labelFont="微软雅黑" var="btnCopy"/>
			  <Button label="测试" skin="png.comp.button" x="128" y="538" width="185" height="45" labelSize="24" labelBold="true" labelFont="微软雅黑" var="btnTest"/>
			  <Button label="+" skin="png.comp.button" x="434" y="10" width="40" height="40" labelBold="true" labelSize="44" var="btnPlus" disabled="true"/>
			  <Button label="-" skin="png.comp.button" x="504" y="10" width="40" height="40" labelBold="true" labelSize="44" var="btnMinus" disabled="true"/>
			</View>;
		public function FilesRobocopyUI(){}
		override protected function createChildren():void {
			viewClassMap["com.ui.component.TwoPathItem"] = TwoPathItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}