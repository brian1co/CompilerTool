/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	public class MainModuleUI extends View {
		protected static var uiXML:XML =
			<View mouseEnabled="false">
			  <Image url="png.main.bg" x="22" y="136" sizeGrid="20,20,20,38" left="-5" right="-5" top="-1" bottom="-10"/>
			</View>;
		public function MainModuleUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}