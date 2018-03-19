/**Created by the Morn,do not modify.*/
package mornUI.main {
	import morn.core.components.*;
	public class LeftTabUI extends View {
		protected static var uiXML:XML =
			<View width="600" height="400"/>;
		public function LeftTabUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}