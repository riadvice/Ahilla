package org.lionart.exceptions
{
	/**
	 * The exception that is thrown when an arithmetic, casting,
	 * or conversion operation in a checked context results in an overflow.
	 * @author : LionArt
	 */
	public class OverflowException extends Exception
	{
		public function OverflowException(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}
