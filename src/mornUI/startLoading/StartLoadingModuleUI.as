/**Created by the Morn,do not modify.*/
package mornUI.startLoading {
	import morn.core.components.*;
	public class StartLoadingModuleUI extends View {
		public var bg:Image = null;
		public var icon:Image = null;
		protected static var uiXML:XML =
			<View width="1000" height="600">
			  <Image url="png.startLoading.loading" x="114" y="395" left="0" right="0" top="0" bottom="0" sizeGrid="28,28,28,28" var="bg"/>
			  <Image url="png.startLoading.loading1" x="423" y="246" var="icon"/>
			</View>;
		public function StartLoadingModuleUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}