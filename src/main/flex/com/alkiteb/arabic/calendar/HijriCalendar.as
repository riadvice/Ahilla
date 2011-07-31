/* Copyright Ghazi Triki (LionArt) 2010 */
package com.alkiteb.arabic.calendar
{
    import com.alkiteb.exceptions.ArgumentException;
    import com.alkiteb.exceptions.ArgumentOutOfRangeException;
    import com.alkiteb.time.Calendar;
    import com.alkiteb.time.TimeSpan;
    import com.alkiteb.utils.dateutils.DateTimeUtils;
    
    /**
     * @author : LionArt
     */
    public class HijriCalendar extends Calendar
    {
        /*---------------------------------------------*/
        /* Members                                     */
        /*---------------------------------------------*/
        /**
         * The Hijri era.
         */
        public static function get hijriEra() : int
        {
            return 1;
        }
        
        /**
         * Useful constants.
         */
        private const DEFAULT_TWO_DIGIT_MAX : int = 1451;
        private const MAX_YEAR : int = 9666;
        /*
        622,6,15 = -42521940000000
        622,6,8  = -42522544800000 Maybe 622,7,8 (7 = July) is correct
        */
        private const MIN_TIME : Number = -42522544800000;
        
        /**
         * Internal state.
         */
        private var adjustemnt : int;
        
        /**
         * Number of days in each month of the year.  The last month will
         * have 30 days in a leap year.
         */
        private static var _daysInMonth  : Array;
        public function get daysInMonth () : Array
        {
            return [30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29];
        }
        
        /**
         * Number of days before each month.
         */
        private static var _daysBeforeMonth  : Array;
        public function get daysBeforeMonth () : Array
        {
            return [0,
                30,
                30 + 29,
                30 + 29 + 30,
                30 + 29 + 30 + 29,
                30 + 29 + 30 + 29 + 30,
                30 + 29 + 30 + 29 + 30 + 29,
                30 + 29 + 30 + 29 + 30 + 29 + 30,
                30 + 29 + 30 + 29 + 30 + 29 + 30 + 29,
                30 + 29 + 30 + 29 + 30 + 29 + 30 + 29 + 30,
                30 + 29 + 30 + 29 + 30 + 29 + 30 + 29 + 30 + 29,
                30 + 29 + 30 + 29 + 30 + 29 + 30 + 29 + 30 + 29 + 30];
        }
        /**
         * Variables used in pullDateApart because flex do not work
         * with reference with native types.
         */
        private var _yearRef  : int;
        private var _monthRef : int;
        private var _dayRef   : int;
        private var _ticksBeforeUTC : Number= 62135596800000;
        
        /*---------------------------------------------*/
        /* Constuctor                                  */
        /*---------------------------------------------*/
        public function HijriCalendar() : void
        {
            super(this);
            adjustemnt = 0x0100;
        }
        
        /*---------------------------------------------*/
        /* Methods                                     */
        /*---------------------------------------------*/
        /**
         * Get or set the Hijri adjustment value, which shifts the
         * date forward or back by up to two days.
         */
        public function get hijriAdjustment() : int
        {
            if(adjustemnt == 0x0100)
            {
                // Must find a way to do it. Beacuase we can not acces windows regisrty.
                // Load form config for example
                adjustemnt = 0;
            }
            else
            {
                adjustemnt = 0;
            }
            return adjustemnt;
        }
        public function set hijriAdjustment(value:int) :void
        {
            if(value < -2 || value > 2)
            {
                throw new ArgumentOutOfRangeException("value","ArgRange_HijriAdjustment");
            }
            adjustemnt = value;
        }
        
        /**
         * Convert a year value into an absolute number of days.
         */
        public function yearToDay (year : int) : int
        {
            var cycle : int = ((year - 1) / 30) * 30;
            var left : int = year - cycle - 1;
            var days : int = ((cycle * 10631) / 30) + 227013;
            while(left > 0)
            {
                days += getDaysInYearInEra(left, hijriEra);
                --left;
            }
            return days;
        }
        
        /**
         * Pull apart a DateTime value into year, month, and day.
         */
        private function pullDateApart(time : Date) : void
        {
            var days : int;
            var estimate1 : int;
            var estimate2 : int;
            
            //init variables
            _yearRef = 0;
            _monthRef = 0;
            _dayRef = 0;
            
            // Validate the time range.
            if(time.time < MIN_TIME)
            {
                throw new ArgumentOutOfRangeException("time","ArgRange_HijriDate");
            }
            
            // Calculate the absolute date, adjusted as necessary.
            days = ((time.time + _ticksBeforeUTC) / TimeSpan.MILLISECONDS_PER_DAY) + 1;
            days += hijriAdjustment;
            
            // Calculate the Hijri year value.
            _yearRef = (((days - 227013) * 30) / 10631) + 1;
            estimate1 = yearToDay(_yearRef);
            estimate2 = getDaysInYearInEra(_yearRef, hijriEra);
            if(days < estimate1)
            {
                estimate1 -= estimate2;
                --_yearRef;
            }
            else if(days == estimate1)
            {
                --_yearRef;
                estimate2 = getDaysInYearInEra(_yearRef, hijriEra);
                estimate1 -= estimate2;
            }
            else if(days > (estimate1 + estimate2))
            {
                estimate1 += estimate2;
                ++_yearRef;
            }
            
            // Calculate the Hijri month value.
            _monthRef = 1;
            days -= estimate1;
            while(_monthRef <= 12 && days > daysBeforeMonth[_monthRef - 1])
            {
                ++_monthRef;
            }
            --_monthRef;
            
            // Calculate the Hijri date value.
            _dayRef = (days - daysBeforeMonth[_monthRef - 1]);
        }
        
        private function recombineDate(year : int, month : int, day : int, ticks : int) : Date
        {
            var limit : int = getDaysInMonthInEra(year, month, hijriEra);
            if(day < 1 || day > limit)
            {
                throw new ArgumentOutOfRangeException("day", "ArgRange_Year");
            }
            var days : int;
            days = yearToDay(year) + daysBeforeMonth[month - 1] + day;
            days -= (hijriAdjustment + 1);
            if(days < 0)
            {
                throw new ArgumentOutOfRangeException("time", "ArgRange_HijriDate");
            }
            return new Date(days * TimeSpan.MILLISECONDS_PER_DAY + ticks);
        }
        
        /*---------------------------------------------*/
        /* Abstract Methods Implementation             */
        /*---------------------------------------------*/
        /**
         * Get a list of eras for the calendar.
         */
        override public function get eras() : Array
        {
            var erasArray : Array = new Array(hijriEra);
            return erasArray;
        }
        
        /**
         * Set the last year of a 100-year range for 2-digit processing.
         */
        override public function get twoDigitYearMax() : int
        {
            var value : int = super.twoDigitYearMax;
            if(value != -1)
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
            if(value < 100 || value > MAX_YEAR)
            {
                throw new ArgumentOutOfRangeException("year","ArgRange_Year");
            }
            super.twoDigitYearMax = value;
        }
        
        /**
         * Add a time period to a DateTime value.
         */
        override public function addMonths(time:Date, months:int) : Date
        {
            pullDateApart(time);
            if(months > 0)
            {
                _yearRef += months / 12;
                _monthRef += months % 12;
                if(_monthRef > 12)
                {
                    ++_yearRef;
                    _monthRef -= 12;
                }
            }
            else if(months < 0)
            {
                months = -months;
                _yearRef -= months / 12;
                _monthRef -= months % 12;
                if(_monthRef < 1)
                {
                    --_yearRef;
                    _monthRef += 12;
                }
            }
            var limit : int = getDaysInMonthInEra(_yearRef, _monthRef, hijriEra);
            if(_dayRef > limit)
            {
                _dayRef = limit;
            }
            return recombineDate(_yearRef, _monthRef, _dayRef,time.time % TimeSpan.MILLISECONDS_PER_DAY);
        }
        override public function addYears(time:Date, years:int) : Date
        {
            return addMonths(time, years * 12);
        }
        
        /**
         * Extract the components from a DateTime value.
         */
        override public function getDayOfMonth(time:Date) : int
        {
            pullDateApart(time);
            return _dayRef;
        }
        override public function getDayOfWeek(time : Date) : int
        {
            return DateTimeUtils.dayOfWeek( time );
        }
        override public function getDayOfYear(time : Date) : int
        {
            pullDateApart(time);
            return daysBeforeMonth[_monthRef - 1] + _dayRef;
        }
        override public function getMonth(time : Date) : int
        {
            pullDateApart(time);
            return _monthRef;
        }
        override public function getYear(time : Date) : int
        {
            pullDateApart(time);
            return _yearRef;
        }
        
        /**
         * Get the number of days in a particular month.
         */
        override public function getDaysInMonthInEra(year : int, month : int, era : int) : int
        {
            if(era != CURRENT_ERA && era != hijriEra)
            {
                throw new ArgumentException("","Arg_InvalidEra");
            }
            if(year < 1 || year > MAX_YEAR)
            {
                throw new ArgumentOutOfRangeException("year","ArgRange_Year");
            }
            if(month < 1 || month > 12)
            {
                throw new ArgumentOutOfRangeException("month","ArgRange_Month");
            }
            if(month < 12)
            {
                return daysInMonth[month - 1];
            }
            else if(isLeapYearInEra(year, era))
            {
                return 30;
            }
            else
            {
                return 29;
            }
        }
        
        /**
         * Get the number of days in a particular year.
         */
        override public function getDaysInYearInEra(year : int, era : int) : int
        {
            if(isLeapYearInEra(year, era))
            {
                return 355;
            }
            else
            {
                return 354;
            }
        }
        
        /**
         * Get the era for a specific DateTime value.
         */
        override public function getEra(time:Date) : int
        {
            return hijriEra;
        }
        
        // Get the number of months in a specific year.
        override public function getMonthsInYearInEra(year : int, era : int) : int
        {
            if(year < 1 || year > MAX_YEAR)
            {
                throw new ArgumentOutOfRangeException("year","ArgRange_Year");
            }
            if(era != CURRENT_ERA && era != hijriEra)
            {
                throw new ArgumentException("Arg_InvalidEra");
            }
            return 12;
        }
        
        /**
         * Determine if a particular day is a leap day.
         */
        override public function isLeapDayInEra(year : int, month : int, day : int, era : int) : Boolean
        {
            if(day < 1 || day > getDaysInMonthInEra(year, month, era))
            {
                throw new ArgumentOutOfRangeException("day","ArgRange_Day");
            }
            if(isLeapMonthInEra(year, month, era))
            {
                return (day == 30);
            }
            else
            {
                return false;
            }
        }
        
        /**
         * Determine if a particular month is a leap month.
         */
        override public function isLeapMonthInEra(year : int, month : int, era : int) : Boolean
        {
            if(month < 1 || month > 12)
            {
                throw new ArgumentOutOfRangeException("month","ArgRange_Month");
            }
            if(isLeapYearInEra(year, era))
            {
                return (month == 12);
            }
            else
            {
                return false;
            }
        }
        
        /**
         * Determine if a particular year is a leap year.
         */
        override public function isLeapYearInEra(year : int, era : int) : Boolean
        {
            if(year < 1 || year > MAX_YEAR)
            {
                throw new ArgumentOutOfRangeException("year", "ArgRange_Year");
            }
            if(era != CURRENT_ERA && era != hijriEra)
            {
                throw new ArgumentException("","Arg_InvalidEra");
            }
            if((((year * 11) + 14) % 30) < 11)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
        /**
         * Convert a particular time into a Date value.
         */
        override public function toDateTimeInEra(year : int, month : int, day : int,
                                                 hour : int, minute : int, second : int,
                                                 millisecond : int, era : int) : Date
        {
            if(era != CURRENT_ERA && era != hijriEra)
            {
                throw new ArgumentException("","Arg_InvalidEra");
            }
            return recombineDate(year, month, day,(new Date(1970,0,1,hour, minute, second, millisecond)).time);
        }
        
        /**
         * Convert a two-digit year value into a four-digit year value.
         */
        override public function toFourDigitYear(year : int) : int
        {
            if(year > MAX_YEAR)
            {
                throw new ArgumentOutOfRangeException("year","ArgRange_Year");
            }
            return super.toFourDigitYear(year);
        }
    }
}


