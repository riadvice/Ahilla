package org.lionart.arabic.Calendar
{
	import org.lionart.time.Calendar;
	
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
		public function set hijri(value : HijriCalendar) : void
		{
			_hijri = value;
		}
		/*---------------------------------------------*/
		/* Constuctor                                  */
		/*---------------------------------------------*/
		public function UmAlQuraCalendar()
		{
			super(this);
		}
		
		/*---------------------------------------------*/
		/* Methods                                     */
		/*---------------------------------------------*/
	}
}