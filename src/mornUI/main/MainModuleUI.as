/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	public class MainModuleUI extends View {
		protected static var uiXML:XML =
			<View>
			  <Image url="png.main.bg" x="0" y="0" sizeGrid="10,100,10,10" left="0" right="0" top="0" bottom="0"/>
			</View>;
		public function MainModuleUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}