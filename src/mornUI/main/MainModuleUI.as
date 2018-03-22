/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	import com.ui.module.main.ConsoleView;
	import com.ui.module.main.LeftTab;
	import mornUI.com.TwoPathItemUI;
	public class MainModuleUI extends View {
		public var bg:Image = null;
		public var viewBox:Box = null;
		public var tabPanel:LeftTab = null;
		public var console:ConsoleView = null;
		protected static var uiXML:XML =
			<View mouseEnabled="false" width="1000" height="610">
			  <Image url="png.main.bg" sizeGrid="33,28,33,38" left="0" right="-5" alpha="1" var="bg" top="0" bottom="0"/>
			  <Box x="401" y="0" var="viewBox" width="600" height="600">
			    <TwoPathItem x="0" y="0" runtime="mornUI.com.TwoPathItemUI"/>
			  </Box>
			  <LeftTab x="0" y="0" runtime="com.ui.module.main.LeftTab" var="tabPanel"/>
			  <ConsoleView y="610" var="console" runtime="com.ui.module.main.ConsoleView" x="0"/>
			</View>;
		public function MainModuleUI(){}
		override protected function createChildren():void {
			viewClassMap["com.ui.module.main.ConsoleView"] = ConsoleView;
			viewClassMap["com.ui.module.main.LeftTab"] = LeftTab;
			viewClassMap["mornUI.com.TwoPathItemUI"] = TwoPathItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}