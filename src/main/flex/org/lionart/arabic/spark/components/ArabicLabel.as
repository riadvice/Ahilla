package org.lionart.arabic.spark.components
{
	import flashx.textLayout.formats.Direction;
	
	import spark.components.Label;
	
	public class ArabicLabel extends Label
	{
		public function ArabicLabel()
		{
			super();
			this.setStyle("direction", Direction.RTL)
		}
	}
}