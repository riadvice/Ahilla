package com.alkiteb.ahilla.calendar
{
    import flexunit.framework.Assert;

    public class TestHijriCalendar
    {

        var hijriStartGregorian : Date;
        var hijriStart : HijriCalendar;

        [Before]
        public function setUp() : void
        {
            hijriStartGregorian = new Date(1980, 9, 19); // This date must correspond to 10 Thu Alhijja 1400
            hijriStart = new HijriCalendar();
        }

        [After]
        public function tearDown() : void
        {
        }

        [BeforeClass]
        public static function setUpBeforeClass() : void
        {
        }

        [AfterClass]
        public static function tearDownAfterClass() : void
        {
        }

        [Test]
        public function testAddMonths() : void
        {
            var addedMonth : Date = hijriStart.addMonths(hijriStartGregorian, 1);
            Assert.assertEquals(hijriStart.getMonth(addedMonth), 1);
        }

        [Test]
        public function testAddYears() : void
        {
            var addedYear : Date = hijriStart.addYears(hijriStartGregorian, 1)
            Assert.assertEquals(hijriStart.getYear(addedYear), 1401);
        }

        [Test]
        public function testGet_daysBeforeMonth() : void
        {
            Assert.assertEquals(hijriStart.daysBeforeMonth.length, 12)
        }

        [Test]
        public function testGet_daysInMonth() : void
        {
            Assert.assertEquals(hijriStart.daysInMonth.length, 12);
        }

        [Test]
        public function testGet_eras() : void
        {
            Assert.assertEquals(hijriStart.eras.length, 1);
        }

        [Test]
        public function testGetDayOfMonth() : void
        {
            Assert.assertEquals(hijriStart.getDayOfMonth(hijriStartGregorian), 10);
        }

        [Test]
        public function testGetDayOfWeek() : void
        {
            Assert.assertEquals(hijriStart.getDayOfWeek(hijriStartGregorian), 0);
        }

        [Test]
        public function testGetDayOfYear() : void
        {
            Assert.assertEquals(hijriStart.getDayOfYear(hijriStartGregorian), 335);
        }

        [Test]
        public function testGetDaysInMonthInEra() : void
        {
            Assert.assertEquals(hijriStart.getDaysInMonthInEra(1400, 12, HijriCalendar.hijriEra), 29);
        }

        [Test]
        public function testGetDaysInYearInEra() : void
        {
            Assert.assertEquals(hijriStart.getDaysInYearInEra(1400, HijriCalendar.hijriEra), 354);
        }

        [Test]
        public function testGetEra() : void
        {
            Assert.assertEquals(hijriStart.getEra(hijriStartGregorian), 1)
        }

        [Test]
        public function testGetMonth() : void
        {
            Assert.assertEquals(hijriStart.getMonth(hijriStartGregorian), 12);
        }

        [Test]
        public function testGetMonthsInYearInEra() : void
        {
            Assert.assertEquals(hijriStart.getMonthsInYearInEra(1400, HijriCalendar.hijriEra), 12)
        }

        [Test]
        public function testGetYear() : void
        {
            Assert.assertEquals(hijriStart.getYear(hijriStartGregorian), 1400);
        }

        [Test]
        public function testGet_hijriAdjustment() : void
        {
            Assert.assertEquals(hijriStart.hijriAdjustment, 0)
        }

        [Test]
        public function testSet_hijriAdjustment() : void
        {
            hijriStart.hijriAdjustment = 2;
            Assert.assertEquals(hijriStart.hijriAdjustment, 0);
            hijriStart.hijriAdjustment = 1;
            Assert.assertEquals(hijriStart.hijriAdjustment, 0);
            hijriStart.hijriAdjustment = 0;
        }

        [Test]
        public function testHijriCalendar() : void
        {
            Assert.assertNotNull(hijriStart)
        }

        [Test]
        public function testGet_hijriEra() : void
        {
            Assert.assertEquals(HijriCalendar.hijriEra, 1);
        }

        [Test]
        public function testIsLeapDayInEra() : void
        {
            Assert.assertEquals(hijriStart.isLeapDayInEra(1400, 12, 10, HijriCalendar.hijriEra), false);
        }

        [Test]
        public function testIsLeapMonthInEra() : void
        {
            Assert.assertEquals(hijriStart.isLeapMonthInEra(1400, 12, HijriCalendar.hijriEra), false);
        }

        [Test]
        public function testIsLeapYearInEra() : void
        {
            Assert.assertEquals(hijriStart.isLeapYearInEra(1400, HijriCalendar.hijriEra), false);
        }

        [Test]
        public function testToDateTimeInEra() : void
        {
            var convertedDate : Date = hijriStart.toDateTimeInEra(1400, 12, 10, 5, 20, 35, 60, HijriCalendar.hijriEra);
            Assert.assertEquals(convertedDate.fullYear, 1980);
            Assert.assertEquals(convertedDate.month, 9);
            Assert.assertEquals(convertedDate.date, 19);
            Assert.assertEquals(convertedDate.hours, 5);
            Assert.assertEquals(convertedDate.minutes, 20);
            Assert.assertEquals(convertedDate.seconds, 35);
            Assert.assertEquals(convertedDate.milliseconds, 60)
        }

        [Test]
        public function testToFourDigitYear() : void
        {
            // TODO : improve test
            Assert.assertEquals(hijriStart.toFourDigitYear(1400), 1400);
        }

        [Test]
        public function testGet_twoDigitYearMax() : void
        {
            Assert.assertEquals(hijriStart.twoDigitYearMax, 1451);
        }

        [Test]
        public function testSet_twoDigitYearMax() : void
        {
            hijriStart.twoDigitYearMax = 1500;
            Assert.assertEquals(hijriStart.twoDigitYearMax, 1500);
        }

        [Test]
        public function testYearToDay() : void
        {
            Assert.assertEquals(hijriStart.yearToDay(1400), 722771);
        }
    }
}
