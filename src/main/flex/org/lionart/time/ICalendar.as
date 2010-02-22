package org.lionart.time
{
	/**
	 * @author : LionArt
	 */
	public interface ICalendar
	{
		function addMonths (time : Date, months : int) : Date;
		function addYears(time : Date, years : int) : Date;
		function getDayOfMonth(time : Date) : int;
		function getDayOfWeek(time : Date) : int;
		function getDayOfYear(time : Date) : int;
		function getMonth(time : Date) : int;
		function getYear(time : Date) : int;
		function getDaysInMonthInEra(year : int, month : int,currentEra : int) : int;
		function getDaysInYearInEra(year : int, currentEra : int) : int;
		function getEra(time : Date) : int
		function getMonthsInYearInEra(year : int, era : int) : int;
		function getWeekOfYear(time : Date, rule : int, firstDayOfWeek : int) : int;
		function isLeapDay(year : int, month : int, day : int) : Boolean;
		function isLeapDayInEra(year : int, month : int, day : int, currentEra : int) : Boolean;
		function isLeapMonthInEra(year : int, month : int, currentEra : int) : Boolean;
		function isLeapYearInEra(year : int, currentEra : int) : Boolean;
		function toDateTime(year : int, month : int, day : int,
							hour : int, minute : int, second : int,
							millisecond : int) : Date;
		function toDateTimeInEra(year : int, month : int, day : int,
							hour : int, minute : int, second : int,
							millisecond : int, currentEra : int) : Date;
	}
}
