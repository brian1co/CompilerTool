/**Created by the Morn,do not modify.*/
package mornUI.main.view.filesRobocopy {
	import morn.core.components.*;
	import com.ui.component.TwoPathItem;
	public class FilesRobocopyUI extends View {
		public var item:TwoPathItem = null;
		protected static var uiXML:XML =
			<View width="600" height="600">
			  <TwoPathItem x="0" y="0" var="item" runtime="com.ui.component.TwoPathItem"/>
			</View>;
		public function FilesRobocopyUI(){}
		override protected function createChildren():void {
			viewClassMap["com.ui.component.TwoPathItem"] = TwoPathItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}