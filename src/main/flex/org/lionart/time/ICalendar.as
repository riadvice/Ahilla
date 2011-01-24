/* Copyright Ghazi Triki (LionArt) 2010 */
package org.lionart.time
{

    /**
     * @author : LionArt
     */
    public interface ICalendar
    {
        function addDays( days : int, time : Date = null ) : Date;
        function addMonths( months : int, time : Date = null ) : Date;
        function addYears( ears : int, time : Date = null ) : Date;
        function getDayOfMonth( time : Date = null ) : int;
        function getDayOfWeek( time : Date = null ) : int;
        function getDayOfYear( time : Date = null ) : int;
        function getMonth( time : Date = null ) : int;
        function getYear( time : Date = null ) : int;
        function getDaysInMonthInEra( year : int, month : int, currentEra : int ) : int;
        function getDaysInYearInEra( year : int, currentEra : int ) : int;
        function getEra( time : Date = null ) : int
        function getMonthsInYearInEra( year : int, era : int ) : int;
        function getWeekOfYear( rule : int, firstDayOfWeek : int, time : Date = null ) : int;
        function isLeapDay( year : int, month : int, day : int ) : Boolean;
        function isLeapDayInEra( year : int, month : int, day : int, currentEra : int ) : Boolean;
        function isLeapMonthInEra( year : int, month : int, currentEra : int ) : Boolean;
        function isLeapYearInEra( year : int, currentEra : int ) : Boolean;
        function toDateTime( year : int, month : int, day : int, hour : int, minute : int, second : int, millisecond : int ) : Date;
        function toDateTimeInEra( year : int, month : int, day : int, hour : int, minute : int, second : int, millisecond : int, currentEra : int ) : Date;
        function getNativeDate() : Date;
    }
}
