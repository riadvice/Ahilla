/* Copyright Ghazi Triki (LionArt) 2010 */
package org.lionart.exceptions
{
	/**
	 * The exception that is thrown when the value of an argument
	 * is outside the allowable range of values as defined by the invoked method.
	 * @author : LionArt
	 */
	public class ArgumentOutOfRangeException extends Exception
	{
		public function ArgumentOutOfRangeException(message:*="",id:*=0)
		{
			super(message,id);
		}
	}
}


