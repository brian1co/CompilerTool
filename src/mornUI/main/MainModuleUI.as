/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	import com.ui.module.main.LeftTab;
	public class MainModuleUI extends View {
		public var bg:Image = null;
		public var tabPanel:LeftTab = null;
		protected static var uiXML:XML =
			<View mouseEnabled="false" width="1000" height="610">
			  <Image url="png.main.bg" sizeGrid="33,28,33,38" left="0" right="0" alpha="1" var="bg" bottom="-1" top="0"/>
			  <LeftTab x="0" y="0" runtime="com.ui.module.main.LeftTab" var="tabPanel"/>
			</View>;
		public function MainModuleUI(){}
		override protected function createChildren():void {
			viewClassMap["com.ui.module.main.LeftTab"] = LeftTab;
			super.createChildren();
			createView(uiXML);
		}
	}
}