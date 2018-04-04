/**Created by the Morn,do not modify.*/
package mornUI.com {
	import morn.core.components.*;
	public class ItemBgUI extends View {
		public var bg:Image = null;
		protected static var uiXML:XML =
			<View width="100" height="100" mouseEnabled="false">
			  <Image url="png.main.itemBg" x="0" y="0" var="bg" sizeGrid="48,48,48,48" width="100" height="100" left="0" right="0" top="0" bottom="0" mouseEnabled="false" disabled="true" buttonMode="true"/>
			</View>;
		public function ItemBgUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}