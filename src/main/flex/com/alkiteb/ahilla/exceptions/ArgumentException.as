/* Copyright Ghazi Triki (LionArt) 2010 */
package com.alkiteb.ahilla.exceptions
{

    /**
     * The exception that is thrown when one of the arguments provided to a method is not valid.
     * @author : LionArt
     */
    public class ArgumentException extends Exception
    {
        public function ArgumentException( message : * = "", id : * = 0 )
        {
            super( message, id );
        }
    }
}


