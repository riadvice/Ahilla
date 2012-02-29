/* Copyright Ghazi Triki (LionArt) 2010 */
package com.alkiteb.ahilla.calendar
{
    import com.alkiteb.ahilla.time.Calendar;

    /**
     * @author : LionArt
     */
    public class UmAlQuraCalendar extends Calendar
    {
        /*---------------------------------------------*/
        /* Members                                     */
        /*---------------------------------------------*/
        /**
         * The UmAlQura era.
         */
        public static function get umAlQuraEra() : int
        {
            return 1;
        }

        /**
         * Internal state.
         */
        private var _hijri : HijriCalendar;

        public function get hirji() : HijriCalendar
        {
            return _hijri;
        }

        public function set hijri( value : HijriCalendar ) : void
        {
            _hijri = value;
        }

        /*---------------------------------------------*/
        /* Constuctor                                  */
        /*---------------------------------------------*/
        public function UmAlQuraCalendar()
        {
            super(this);
            hijri = new HijriCalendar();
            hirji.hijriAdjustment = 0;
        }

        /*---------------------------------------------*/
        /* Methods                                     */
        /*---------------------------------------------*/

        /*---------------------------------------------*/
        /* Abstract Methods Implementation             */
        /*---------------------------------------------*/
        /**
         * Get a list of eras for the calendar.
         */
        override public function get eras() : Array
        {
            var eras : Array = new Array(umAlQuraEra);
            return eras;
        }

        /**
         * Set the last year of a 100-year range for 2-digit processing.
         */
        override public function get twoDigitYearMax() : int
        {
            return hirji.twoDigitYearMax;
        }

        override public function set twoDigitYearMax( value : int ) : void
        {
            hirji.twoDigitYearMax = value;
        }

        /**
         * Add a time period to a DateTime value.
         */
        override public function addMonths( time : Date, months : int ) : Date
        {
            return hirji.addMonths(time, months);
        }

        override public function addYears( time : Date, years : int ) : Date
        {
            return hirji.addYears(time, years);
        }

        /**
         * Extract the components from a DateTime value.
         */
        override public function getDayOfMonth( time : Date ) : int
        {
            return hirji.getDayOfMonth(time);
        }

        override public function getDayOfWeek( time : Date ) : int
        {
            return hirji.getDayOfWeek(time);
        }

        override public function getDayOfYear( time : Date ) : int
        {
            return hirji.getDayOfYear(time);
        }

        override public function getMonth( time : Date ) : int
        {
            return hirji.getMonth(time);
        }

        override public function getYear( time : Date ) : int
        {
            return hirji.getYear(time);
        }

        /**
         * Get the number of days in a particular month.
         */
        override public function getDaysInMonthInEra( year : int, month : int, era : int ) : int
        {
            return hirji.getDaysInMonthInEra(year, month, era);
        }

        /**
         * Get the number of days in a particular year.
         */
        override public function getDaysInYearInEra( year : int, era : int ) : int
        {
            return hirji.getDaysInYearInEra(year, era);
        }

        /**
         * Get the era for a specific DateTime value.
         */
        override public function getEra( time : Date ) : int
        {
            return umAlQuraEra;
        }

        /**
         * Get the number of months in a specific year.
         */
        override public function getMonthsInYearInEra( year : int, era : int ) : int
        {
            return hirji.getMonthsInYearInEra(year, era);
        }

        /**
         * Determine if a particular day is a leap day.
         */
        override public function isLeapDayInEra( year : int, month : int, day : int, era : int ) : Boolean
        {
            return hirji.isLeapDayInEra(year, month, day, era);
        }

        /**
         * Determine if a particular month is a leap month.
         */
        override public function isLeapMonthInEra( year : int, month : int, era : int ) : Boolean
        {
            return hirji.isLeapMonthInEra(year, month, era);
        }

        /**
         * Determine if a particular year is a leap year.
         */
        override public function isLeapYearInEra( year : int, era : int ) : Boolean
        {
            return hirji.isLeapYearInEra(year, era);
        }

        /**
         * Convert a particular time into a DateTime value.
         */
        override public function toDateTimeInEra( year : int, month : int, day : int, hour : int, minute : int, second : int, millisecond : int, era : int ) : Date
        {
            return hirji.toDateTimeInEra(year, month, day, hour, minute, second, millisecond, era);
        }

        /**
         * Convert a two-digit year value into a four-digit year value.
         */
        override public function toFourDigitYear( year : int ) : int
        {
            return hirji.toFourDigitYear(year);
        }
    }
}


