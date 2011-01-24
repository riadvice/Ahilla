/**
 * Implementation of "System.Globalization.Calendar" from Southern Storm Software C#
 * source code given in GNU 2 licence.
 *
 * It is an bastarct class that will be used to repalce Flex default Date in
 * custom components.
 *
 * @author : LionArt
 */
package org.lionart.time
{
    import org.lionart.exceptions.ArgumentException;
    import org.lionart.exceptions.ArgumentOutOfRangeException;
    import org.lionart.exceptions.OverflowException;
    import org.lionart.utils.AbstractUtil;

    public class Calendar implements ICalendar
    {

        /*---------------------------------------------*/
        /* Members                                     */
        /*---------------------------------------------*/
        /**
         * Current era value.
         */
        public const CURRENT_ERA : int = 0;

        /**
         * Internal state.
         */
        private var _twoDigitYearMax : int;

        /**
         * Internal date.
         */
        [Bindable]
        protected var _internalDate : Date;

        /*---------------------------------------------*/
        /* Constructor                                 */
        /*---------------------------------------------*/
        public function Calendar( self : Calendar )
        {
            _twoDigitYearMax = -1;

            // Abstract class implementation
            AbstractUtil.mustBeAbstract( self, this );
        /*
           var mustImplementMethods : Array =
           [eras,twoDigitYearMax,addMonths,addWeeks,addYears,getDayOfMonth,
           getDayOfWeek,getDayOfYear,getMonth,getYear,getDaysInMonthInEra,
           getMonthsInYearInEra,getEra,getMonthsInYearInEra,isLeapDayInEra,
           isLeapMonthInEra,isLeapYearInEra,toDateTimeInEra,toFourDigitYear];
         AbstractUtil.checkMustImplementMethods(this, Calendar, mustImplementMethods);*/
        }

        /*---------------------------------------------*/
        /* Abstract Methods                            */
        /*---------------------------------------------*/
        /**
         * Get a list of eras for the calendar.
         * @return : an Array on int
         */
        public function get eras() : Array
        {
            return []
        }
        ;

        /**
         * Get the last year of a 100-year range for 2-digit processing.
         */
        public function get twoDigitYearMax() : int
        {
            return _twoDigitYearMax;
        }

        /**
         * Set the last year of a 100-year range for 2-digit processing.
         */
        public function set twoDigitYearMax( value : int ) : void
        {
            _twoDigitYearMax = value;
        }

        /**
         * Add a time period to a Date value.
         */
        public function addDays( days : int, time : Date = null ) : Date
        {
            time = verifyTime( time );
            return defaultAdd( days, TimeSpan.MILLISECONDS_PER_DAY, time );
        }

        public function addHours( hours : int, time : Date = null ) : Date
        {
            time = verifyTime( time );
            return defaultAdd( hours, TimeSpan.MILLISECONDS_PER_HOUR, time );
        }

        public function addMilliseconds( milliseconds : Number, time : Date = null ) : Date
        {
            time = verifyTime( time );
            var ticks : Number;

            // Get the final date tick value.  We use the
            // "checked" block to detect overflow when
            // computing the tick value.
            try
            {
                ticks = ( milliseconds * TimeSpan.MILLISECONDS_PER_MILLISECOND ) + time.time;
            }
            catch ( e : OverflowException )
            {
                throw new ArgumentException( "", "Arg_DateRange" );
            }

            // Construct and return a new Date object,
            // which will also check for out of range values.
            return new Date( ticks );
        }

        public function addMinutes( minutes : int, time : Date = null ) : Date
        {
            time = verifyTime( time );
            return defaultAdd( minutes, TimeSpan.MILLISECONDS_PER_MINUTE, time );
        }

        public function addSeconds( seconds : int, time : Date = null ) : Date
        {
            time = verifyTime( time );
            return defaultAdd( seconds, TimeSpan.MILLISECONDS_PER_SECOND, time );
        }

        public function addWeeks( weeks : int, time : Date = null ) : Date
        {
            time = verifyTime( time );
            return defaultAdd( weeks, TimeSpan.MILLISECONDS_PER_DAY * 7, time );
        }

        /*---------------------------------------------*/
        /* Methods                                     */
        /*---------------------------------------------*/
        /**
         * Internal version of the default "Add*" methods.
         */
        private static function defaultAdd( value : int, multiplier : Number, time : Date = null ) : Date
        {
            var ticks : Number;
            try
            {
                ticks = Number( value ) * multiplier + time.time;
            }
            catch ( e : OverflowException )
            {
                throw new ArgumentException( "", "Arg_DateRange" );
            }

            // Construct and return a new Date object,
            // which will also check for out of range values.
            return new Date( ticks );
        }

        /**
         * Extract the components from a Date value.
         */
        public function getHour( time : Date = null ) : int
        {
            time = verifyTime( time );
            return time.hours;
        }

        public function getMilliseconds( time : Date = null ) : Number
        {
            time = verifyTime( time );
            return time.time;
        }

        public function getMinute( time : Date = null ) : int
        {
            time = verifyTime( time );
            return time.minutes;
        }

        public function getSecond( time : Date = null ) : int
        {
            time = verifyTime( time );
            return time.seconds;
        }

        /**
         * Get the number of days in a particular month.
         */
        public function getDaysInMonth( year : int, month : int ) : int
        {
            return getDaysInMonthInEra( year, month, CURRENT_ERA );
        }

        /**
         * Get the number of days in a particular year.
         */
        public function getDaysInYear( year : int ) : int
        {
            return getDaysInYearInEra( year, CURRENT_ERA );
        }

        /**
         * Get the number of months in a specific year.
         */
        public function getMonthsInYear( year : int ) : int
        {
            return getMonthsInYearInEra( year, CURRENT_ERA );
        }

        /**
         * Get the week of the year that a particular date falls within.
         */
        public function getWeekOfYear( rule : int, firstDayOfWeek : int, time : Date = null ) : int
        {
            time = verifyTime( time );
            if (( firstDayOfWeek < DayOfWeek.SUNDAY ) || ( firstDayOfWeek > DayOfWeek.SATURDAY ))
            {
                throw new ArgumentOutOfRangeException( "firstDayOfWeek", "Arg_DayOfWeek" );
            }
            // Find out when Jan 1 occurs in this year.
            var jan1 : int;
            jan1 = getDayOfWeek( toDateTimeInEra( getYear( time ), 1, 1, 0, 0, 0, 0, CURRENT_ERA ));

            // Compute the week value.
            var inc : int;
            var temp : int;
            switch ( rule )
            {
                case CalendarWeekRule.FIRST_DAY:
                {
                    // Determine how many days to increase by.
                    inc = jan1 - firstDayOfWeek;
                    if ( inc < 0 )
                    {
                        inc += 7;
                    }

                    // Compute the week value.
                    return (( getDayOfYear( time ) + inc ) / 7 ) + 1;
                }
                // Not reached.

                case CalendarWeekRule.FIRST_FULL_WEEK:
                case CalendarWeekRule.FIRST_FOUR_DAY_WEEK:
                {
                    // Calculate the number of days until the
                    // start of the first week in the year.
                    inc = firstDayOfWeek - jan1;
                    if ( inc != 0 )
                    {
                        if ( inc < 0 )
                        {
                            inc += 7;
                        }
                        if ( rule == CalendarWeekRule.FIRST_FOUR_DAY_WEEK )
                        {
                            if ( inc >= 4 )
                            {
                                inc -= 7;
                            }
                        }
                        else
                        {
                            if ( inc >= 7 )
                            {
                                inc -= 7;
                            }
                        }
                    }

                    // Compute the week value.
                    temp = getDayOfYear( time ) - inc;
                    if ( temp > 0 )
                    {
                        return (( temp - 1 ) / 7 ) + 1;
                    }

                    // The week is actually the last week of the
                    // previous year, so restart the process.
                    temp = getYear( time ) - 1;
                    inc = getMonthsInYear( temp );
                    return getWeekOfYear( rule, firstDayOfWeek, toDateTimeInEra( temp, inc, getDaysInMonth( temp, inc ),
                        0, 0, 0, 0, CURRENT_ERA ));
                }
                // Not reached.

                default:
                {
                    throw new ArgumentOutOfRangeException( "rule", "Arg_CalendarWeekRule" );
                }
                    // Not reached.
            }
        }

        /**
         * Determine if a particular day is a leap day.
         */
        public function isLeapDay( year : int, month : int, day : int ) : Boolean
        {
            return isLeapDayInEra( year, month, day, CURRENT_ERA );
        }

        /**
         * Determine if a particular month is a leap month.
         */
        public function isLeapMonth( year : int, month : int ) : Boolean
        {
            return isLeapMonthInEra( year, month, CURRENT_ERA );
        }

        /**
         * Determine if a particular year is a leap year.
         */
        public function isLeapYear( year : int ) : Boolean
        {
            return isLeapYearInEra( year, CURRENT_ERA );
        }

        /**
         * Convert a particular time into a DateTime value.
         */
        public function toDateTime( year : int, month : int, day : int, hour : int, minute : int, second : int, millisecond : int ) : Date
        {
            return toDateTimeInEra( year, month, day, hour, minute, second, millisecond, CURRENT_ERA );
        }

        /**
         * Convert a two-digit year value into a four-digit year value.
         */
        public function toFourDigitYear( year : int ) : int
        {
            if ( year < 0 )
            {
                // Invalid year value.
                throw new ArgumentException( "", "ArgRange_NonNegative" );
            }
            else if ( year >= 100 )
            {
                // Assume that the year is already 4 digits long.
                return year;
            }
            else
            {
                // Adjust the year using the "TwoDigitYearMax" value.
                var yearMax : int = twoDigitYearMax;
                var yearMaxInCentury : int = ( yearMax % 100 );
                if ( year <= yearMaxInCentury )
                {
                    return ( yearMax - yearMaxInCentury ) + year;
                }
                else
                {
                    return ( yearMax - 100 ) + ( year - yearMaxInCentury );
                }
            }
        }

        /*---------------------------------------------*/
        /* Inetrfacre implementation                   */
        /*---------------------------------------------*/
        // Add a time period to a Date value.

        public function addMonths( months : int, time : Date = null ) : Date
        {
            return null;
        }

        public function addYears( years : int, time : Date = null ) : Date
        {
            return null;
        }

        // Extract the components from a Date value.
        public function getDayOfMonth( time : Date = null ) : int
        {
            return NaN;
        }

        public function getDayOfWeek( time : Date = null ) : int
        {
            return NaN;
        }

        public function getDayOfYear( time : Date = null ) : int
        {
            return NaN;
        }

        public function getMonth( time : Date = null ) : int
        {
            return NaN;
        }

        public function getYear( time : Date = null ) : int
        {
            return NaN;
        }

        // Get the number of days in a particular month.
        public function getDaysInMonthInEra( year : int, month : int, era : int ) : int
        {
            return NaN;
        }

        // Get the number of days in a particular year.
        public function getDaysInYearInEra( year : int, era : int ) : int
        {
            return NaN;
        }

        // Get the era for a specific DateTime value.
        public function getEra( time : Date = null ) : int
        {
            return NaN;
        }

        // Get the number of months in a specific year.
        public function getMonthsInYearInEra( year : int, era : int ) : int
        {
            return NaN;
        }

        // Determine if a particular day is a leap day.
        public function isLeapDayInEra( year : int, month : int, day : int, era : int ) : Boolean
        {
            return false;
        }

        // Determine if a particular month is a leap month.
        public function isLeapMonthInEra( year : int, month : int, era : int ) : Boolean
        {
            return false;
        }

        // Determine if a particular year is a leap year.
        public function isLeapYearInEra( year : int, era : int ) : Boolean
        {
            return false;
        }

        //
        public function toDateTimeInEra( year : int, month : int, day : int, hour : int, minute : int, second : int, millisecond : int,
            era : int ) : Date
        {
            return null;
        }

        /**
         * Retrun _internalDate if no time were specified
         */
        protected function verifyTime( time : Date ) : Date
        {
            if ( !time )
            {
                time = _internalDate;
            }
            return time;
        }

        public function getNativeDate() : Date
        {
            return _internalDate;
        }
    }
}
