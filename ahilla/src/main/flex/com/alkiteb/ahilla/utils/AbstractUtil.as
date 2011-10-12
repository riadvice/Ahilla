/* Copyright Ghazi Triki (LionArt) 2010 */
package com.alkiteb.ahilla.utils
{
	import flash.errors.IllegalOperationError;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	public class AbstractUtil
	{
		public static function mustBeAbstract(object:*, instance:*) : void
		{
			if(object != instance)
			{
				throw new IllegalOperationError("Abstract class did not receive reference to self. Calendar cannot be instantiated directly.");
			}
		}


		public static function checkMustImplementMethods( object : *, clazz : Class, methods : Array ) : void
		{
			//get the fully-qualified name the abstract class
			var abstractTypeName:String = getQualifiedClassName(clazz);

			//get a list of all the methods declared by the abstract class
			//if a subclass overrides a function, declaredBy will contain the subclass name
			var selfDescription:XML = describeType(object);
			var methodsXML:XMLList = selfDescription.method.(@declaredBy == abstractTypeName && methods.indexOf(object[@name]) >= 0);

			if(methodsXML.length() > 0)
			{
				//we'll only get here if the function is still unimplemented
				var concreteTypeName:String = getQualifiedClassName(object);
				throw new IllegalOperationError("Function " + methodsXML[0].@name + " from abstract class " + abstractTypeName + " has not been implemented by subclass " + concreteTypeName);
			}
		}
	}
}
