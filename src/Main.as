package
{
	import com.Jarvis;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF( width="1000" , height="600",  frameRate="50", backgroundColor="#000000")] 
	public class Main extends Sprite
	{
		public function Main()
		{
//			Security.allowDomain("*");
//			Security.allowInsecureDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,initStyle);
		}
		
		private function initStyle(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,initStyle);
			Jarvis.init(this);
		}
		
	}
}