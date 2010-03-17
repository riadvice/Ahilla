/* Copyright Ghazi Triki (LionArt) 2010 */
/**
 * @author  LionArt
 */
package org.lionart
{
	import flash.utils.Timer;

	public class FlexObject extends Object
	{
		/**
		 * Indicates whether some other object is "equal to" this one.
		 */
		public function equals( obj : FlexObject ) : Boolean
		{
			return ( this == obj );

		}

		/**
		 * Creates and returns a copy of this object.
		 */
		public function clone() : FlexObject
		{
			var classRef : Class = this["constructor"];

			var newObj : FlexObject = new classRef();
			return newObj;
		}

	}
}
