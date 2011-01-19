package org.lionart.utils.common
{
    public class StringUtils
    {
        public static function trim(value:String) : String
        {
            var r:RegExp = /^\s*(.*?)\s*$/g
            return value.replace(r, "$1");
        }
    }
}