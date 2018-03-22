/**Created by the Morn,do not modify.*/
package mornUI.com {
	import morn.core.components.*;
	import com.ui.component.ItemBg;
	import com.ui.component.PathItem;
	public class TwoPathItemUI extends View {
		public var itemBg:ItemBg = null;
		public var path1:PathItem = null;
		public var path2:PathItem = null;
		protected static var uiXML:XML =
			<View width="600" height="120">
			  <ItemBg x="-20" width="620" height="120" var="itemBg" runtime="com.ui.component.ItemBg"/>
			  <PathItem x="10" y="26" runtime="com.ui.component.PathItem" var="path1"/>
			  <PathItem x="10" y="66" runtime="com.ui.component.PathItem" var="path2"/>
			</View>;
		public function TwoPathItemUI(){}
		override protected function createChildren():void {
			viewClassMap["com.ui.component.ItemBg"] = ItemBg;
			viewClassMap["com.ui.component.PathItem"] = PathItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}