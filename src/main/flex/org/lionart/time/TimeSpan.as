package org.lionart.time
{
	public class TimeSpan
	{
		public static const MILLISECONDS_PER_MILLISECOND : int = 1;
		public static const MILLISECONDS_PER_SECOND : int = 1000;
		public static const MILLISECONDS_PER_MINUTE : Number = MILLISECONDS_PER_SECOND * SECONDS_PER_MINUTE;
		public static const MILLISECONDS_PER_HOUR 	: Number = MILLISECONDS_PER_MINUTE * SECONDS_PER_HOUR;
		public static const MILLISECONDS_PER_DAY 	: Number = MILLISECONDS_PER_HOUR * HOURS_PER_DAY;
		
		public static const SECONDS_PER_MINUTE	: int	= 60;
		public static const SECONDS_PER_HOUR	: Number	= SECONDS_PER_MINUTE * MINUTES_PER_HOUR;
		public static const SECONDS_PER_DAY		: Number	= SECONDS_PER_HOUR * HOURS_PER_DAY;
			
		public static const MINUTES_PER_HOUR	: int	= 60;
		public static const MIUTES_PER_DAY		: Number	= MINUTES_PER_HOUR * HOURS_PER_DAY;
			
		public static const HOURS_PER_DAY		: int	= 24;
	}
}