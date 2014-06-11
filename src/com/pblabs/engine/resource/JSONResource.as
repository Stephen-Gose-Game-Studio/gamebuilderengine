/*******************************************************************************
 * PushButton Engine
 * Copyright (C) 2009 PushButton Labs, LLC
 * For more information see http://www.pushbuttonengine.com
 * 
 * This file is licensed under the terms of the MIT license, which is included
 * in the License.html file at the root directory of this SDK.
 ******************************************************************************/
package com.pblabs.engine.resource
{
   import com.pblabs.engine.debug.Logger;
   
   import flash.utils.ByteArray;
   
   [EditorData(extensions="json")]
   
   /**
    * This is a Resource subclass for JSON data.
    */
   public class JSONResource extends Resource
   {
      /**
       * The loaded JSON object. This will be null until loading of the resource has completed.
       */
      public function get jsonData():Object
      {
         return _jsonObject;
      }
      
	  /**
	   * The loaded JSON string. This will be null until loading of the resource has completed.
	   */
	  public function get jsonString():String
	  {
		  return _jsonString;
	  }

	  /**
       * The data loaded from a JSON file is just a string containing the object structure itself,
       * so we don't need any special loading. This just converts the byte array to
       * a string and marks the resource as loaded.
       */
      override public function initialize(data:*):void
      {
		  try
		  {
	         if (data is ByteArray)
	         {
	         	// convert ByteArray data to a string
				(data as ByteArray).position = 0;
				_jsonString = (data as ByteArray).readUTFBytes((data as ByteArray).length);
	         }else{
				 _jsonString = data;
			 }
			 
			 _jsonObject = JSON.parse(_jsonString);
			 
			 processLoadedContent(_jsonObject);
         }
         catch (e:TypeError)
         {
            Logger.print(this, "Got type error parsing JSON Object: " + e.toString());
            _valid = false;
         }
      }
      
      /**
       * @inheritDoc
       */
      override protected function onContentReady(content:*):Boolean 
      {
         return _valid;
      }
      
      private var _valid:Boolean = true;
      private var _jsonObject:Object = null;
	  private var _jsonString : String;
   }
}