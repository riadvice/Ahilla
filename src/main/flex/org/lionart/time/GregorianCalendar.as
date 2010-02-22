package org.lionart.time
{
	import org.lionart.exceptions.ArgumentException;
	import org.lionart.exceptions.ArgumentOutOfRangeException;
	import org.lionart.utils.dateutils.DateTimeUtils;

	/**
	 * @author : LionArt
	 */

	public class GregorianCalendar extends Calendar
	{
		/*---------------------------------------------*/
		/* Members                                     */
		/*---------------------------------------------*/
		/**
		 * The A.D. era.
		 */
		public const ADEra : int = 1;

		/**
		 * Internal state is a GregorianCalendarTypes.
		 */
		private var _calendarType : int;

		/**
		 * Useful constants.
		 */
		private const DEFAULT_TWO_DIGIT_MAX : int = 2029;

		/*---------------------------------------------*/
		/* Constructor                                 */
		/*---------------------------------------------*/
		/**
		 * Default gregorianCalendarType is set to GregorianCalendarTypes.LOCALIZED
		 */
		public function GregorianCalendar(gregorianCalendarType : int = GregorianCalendarTypes.LOCALIZED)
		{
			super(this);
			calendarType = gregorianCalendarType;
		}

		/*---------------------------------------------*/
		/* Methods                                     */
		/*---------------------------------------------*/
		public function get calendarType() : int
		{
			return _calendarType;
		}

		public function set calendarType(value:int) : void
		{
			_calendarType = value;
		}

		/*---------------------------------------------*/
		/* Abstract Methods Implementation             */
		/*---------------------------------------------*/
		/**
		 * Get a list of eras for the calendar.
		 */
		override public function get eras() : Array
		{
			var erasArray : Array = new Array(ADEra);
			return erasArray;
		}

		/**
		 * Set the last year of a 100-year range for 2-digit processing.
		 */
		override public function get twoDigitYearMax() : int
		{
			var value : int = super.twoDigitYearMax;
			if ( value != -1 )
			{
				return value;
			}
			else
			{
				// Set the default value.
				super.twoDigitYearMax = DEFAULT_TWO_DIGIT_MAX;
				return DEFAULT_TWO_DIGIT_MAX;
			}
		}
		override public function set twoDigitYearMax(value:int) : void
		{
			if ( value < 100 || value || 999 )
			{
				throw new ArgumentOutOfRangeException("year","ArgRange_Year");
			}
			super.twoDigitYearMax = value;
		}

		/**
		 * Add a time period to a DateTime value.
		 */
		override public function addMonths(time : Date, months : int) : Date
		{
			time.month += months;
			return time;
		}
		override public function addWeeks(time:Date, weeks:int) : Date
		{
			return super.addWeeks(time, weeks);
		}
		override public function addYears(time:Date, years:int) : Date
		{
			time.fullYear += years;
			return time;
		}

		/**
		 * Extract the components from a DateTime value.
		 */
		override public function getDayOfMonth(time:Date) : int
		{
			return time.date;
		}
		override public function getDayOfWeek(time:Date) : int
		{
			return time.day;
		}
		override public function getDayOfYear(time:Date) : int
		{
			return DateTimeUtils.dayOfYear(time);
		}
		override public function getMonth(time:Date) : int
		{
			return time.month;
		}
		override public function getYear(time:Date) : int
		{
			return time.fullYear;
		}

		/**
		 * Get the number of days in a particular month.
		 */
		override public function getDaysInMonthInEra(year:int, month:int, era:int) : int
		{
			if( era != CURRENT_ERA && era != ADEra )
			{
				throw new ArgumentException("","Arg_InvalidEra");
			}
			return DateTimeUtils.daysInMonth(new Date(year,month));
		}

		/**
		 * Get the number of days in a particular year.
		 */
		override public function getDaysInYearInEra(year:int, era:int) : int
		{
			if(year < 1 || year > 9999)
			{
				throw new ArgumentOutOfRangeException("year","ArgRange_Year");
			}
			if(era != CURRENT_ERA && era != ADEra)
			{
				throw new ArgumentException("","Arg_InvalidEra");
			}
			if( DateTimeUtils.isLeapYear(new Date(year)) )
			{
				return 366;
			}
			else
			{
				return 365;
			}
		}

		/**
		 * Get the era for a specific DateTime value.
		 */
		override public function getEra(time:Date) : int
		{
			return ADEra;
		}

		/**
		 * Get the number of months in a specific year.
		 */
		override public function getMonthsInYearInEra(year:int, era:int) : int
		{
			if(year < 1 || year > 9999)
			{
				throw new ArgumentOutOfRangeException("year", "ArgRange_Year");
			}
			if(era != CURRENT_ERA && era != ADEra)
			{
				throw new ArgumentException("","Arg_InvalidEra");
			}
			return 12;
		}
		/**
		 * Determine if a particular day is a leap day.
		 *
		 * Note: according to the Calendar FAQ, the leap day is actually
		 * the 24th of February, not the 29th!  This comes from the
		 * ancient Roman calendar.  However, since most people in the
		 * modern world think it is the 29th, Microsoft and others have
		 * actually implemented this function "wrong".  We've matched
		 * this "wrong" implementation here, for compatibility reasons.
		 *
		 * See: http://www.tondering.dk/claus/calendar.html
		 */
		override public function isLeapDayInEra(year:int, month:int, day:int, era:int) : Boolean
		{
			if(day < 1 || day > getDaysInMonthInEra(year, month, era))
			{
				throw new ArgumentOutOfRangeException("day","ArgRange_Day");
			}
			if(DateTimeUtils.isLeapYear(new Date(year)) && month == 2 && day == 29)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		/**
		 * Determine if a particular month is a leap month.
		 */
		override public function isLeapMonthInEra(year:int, month:int, era:int) : Boolean
		{
			if(month < 1 || month > 12)
			{
				throw new ArgumentOutOfRangeException("month", "ArgRange_Month");
			}
			return (isLeapYearInEra(year, era) && month == 2);
		}

		/**
		 * Determine if a particular year is a leap year.
		 */
		override public function isLeapYearInEra(year:int, era:int) : Boolean
		{
			if(year < 1 || year > 9999)
			{
				throw new ArgumentOutOfRangeException("year", "ArgRange_Year");
			}
			if(era != CURRENT_ERA && era != ADEra)
			{
				throw new ArgumentException("Arg_InvalidEra");
			}
			return DateTimeUtils.isLeapYear(new Date(year));
		}

		/**
		 * Convert a particular time into a DateTime value.
		 */
		override public function toDateTimeInEra(year:int, month:int, day:int, hour:int, minute:int, second:int, millisecond:int, era:int) : Date
		{
			if(era != CURRENT_ERA && era != ADEra)
			{
				throw new ArgumentException("Arg_InvalidEra");
			}
			return new Date(year, month, day, hour,	minute, second, millisecond);
		}

		/**
		 * Convert a two-digit year value into a four-digit year value.
		 */
		override public function toFourDigitYear(year:int) : int
		{
			return super.toFourDigitYear(year);
		}
	}
}
