/* Copyright Ghazi Triki (LionArt) 2010 */
package org.lionart.utils.dateutils
{
	import mx.utils.ObjectUtil;
	
	public class DaylightSavingTimeUS
	{
		/**
		 * @private
		 * 
		 * Calculates the start of DST for a year prior to new DST rules
		 * 
		 * @param date  The year of the date to check
		 * 
		 * @return date The actual start of DST
		 */
		private static function DSTStartBefore2007( date:Date ):Date
		{
			// 1st Sunday in April
			if ( date.fullYear > 1986 ) {
				return DateTimeUtils.dayOfWeekIterationOfMonth( 1, DateTimeUtils.SUNDAY, new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.APRIL ) ) );
			} else if ( date.fullYear == 1975 ) {
				return new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.FEBRUARY ), 23 );
			} else if ( date.fullYear == 1974 ) {
				return new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.JANUARY ), 6 );
				// last week of April
			} else {
				return DateTimeUtils.dayOfWeekIterationOfMonth( DateTimeUtils.LAST, DateTimeUtils.SUNDAY, new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.APRIL ) ) );
			}
		}
		
		/**
		 * @private
		 * 
		 * Calculates the end of DST for a year prior to new DST rules
		 * 
		 * @param date  The year of the date to check
		 * 
		 * @return date The actual end of DST
		 */
		private static function DSTEndBefore2007( date:Date ):Date
		{
			// last Sunday in October
			return DateTimeUtils.dayOfWeekIterationOfMonth( DateTimeUtils.LAST, DateTimeUtils.SUNDAY, new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.OCTOBER ) ) );
		}
		
		/**
		 * Calculates the start of DST for a year
		 * 
		 * @param date  The year of the date to check
		 * 
		 * @return date The actual start of DST
		 */
		public static function DSTStart( date:Date ):Date
		{
			var _localDate:Date;
			if ( date.fullYear < 2007 ) {
				_localDate = DaylightSavingTimeUS.DSTStartBefore2007( date );
				// 2nd Sunday in March
			} else {
				_localDate = DateTimeUtils.dayOfWeekIterationOfMonth( 2, DateTimeUtils.SUNDAY, new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.MARCH ) ) );
			}
			_localDate = new Date( _localDate.fullYear, _localDate.month, _localDate.date, 2 );
			return _localDate;
		}
		
		/**
		 * Calculates the end of DST for a year
		 * 
		 * @param date  The year of the date to check
		 * 
		 * @return date The actual end of DST
		 */
		public static function DSTEnd( date:Date ):Date
		{
			var _localDate:Date;
			if ( date.fullYear < 2007 ) {
				_localDate = DaylightSavingTimeUS.DSTEndBefore2007( date );
				// 1st Sunday in November
			} else {
				_localDate = DateTimeUtils.dayOfWeekIterationOfMonth( 1, DateTimeUtils.SUNDAY, new Date( date.fullYear, DateTimeUtils.monthAsNumber( DateTimeUtils.NOVEMBER ) ) );
			}
			_localDate = new Date( _localDate.fullYear, _localDate.month, _localDate.date, 2 );
			return _localDate;
		}
		
		/**
		 * Checks whether a date is undergoing DST
		 * 
		 * @param date  The date to check
		 * 
		 * @return              <code>true</code> means that a date *is* underdoing DST, <code>false</code> means a date is *not* undergoing DST
		 */
		public static function isDST( date:Date ):Boolean
		{
			return ( ( ObjectUtil.dateCompare( DaylightSavingTimeUS.DSTStart( date ), date ) > 0 ) &&
				( ObjectUtil.dateCompare( date, DaylightSavingTimeUS.DSTEnd( date ) ) > 0 ) )
		}
		
	}
}
