/* Copyright Ghazi Triki (LionArt) 2010 */
package org.lionart.utils.encoding
{
    import flash.utils.getDefinitionByName;
    
    import mx.core.ByteArrayAsset;
    
    import org.lionart.exceptions.CharsetException;
    import org.lionart.exceptions.Exception;
    import org.lionart.utils.common.StringUtils;

	public class CharsetConverter
	{
		/**
		 * This value keeps information if string contains multibyte chars.
		 */
		private var recognizedEncoding:Boolean;
        /**
         * This value keeps information if output should be with numeric entities.
         */
		private var entities : Boolean;
        /**
         * This value keeps information about source (from) encoding
         */
		private var fromCharset : String;
        /**
         * This value keeps information about destination (to) encoding
         */
		private var toCharset : String;
        /**
         * This property keeps convert Table inside
         */
		private var charsetTable : Object;

		public function CharsetConverter(fromCharset : String, toCharset : String, turnOnEntities : Boolean = false)
		{
            this.fromCharset = fromCharset.toUpperCase().replace("-","_");
            this.toCharset = toCharset.toUpperCase().replace("-","_");
            this.entities = turnOnEntities;
            
            
            if (this.fromCharset == this.toCharset)
            {
                throw new CharsetException("Notice, you are trying to convert string from " + this.fromCharset + " to " + this.toCharset + ", don't you feel it's strange? ;-)");
            }
            if ((this.fromCharset == this.toCharset) && (this.fromCharset == Charsets.UTF8))
            {
                throw new CharsetException("You can NOT convert string from " + this.fromCharset + " to " + this.fromCharset + "!");
            }
            
            
            if (this.fromCharset == Charsets.UTF8)
            {
                this.charsetTable = this.makeConvertTable (this.toCharset);
            }
            else if (this.toCharset == Charsets.UTF8)
            {
                this.charsetTable = this.makeConvertTable (this.fromCharset);
            }
            else
            {
                this.charsetTable = this.makeConvertTable (this.fromCharset, this.toCharset);
            }
		}
        
        private function makeConvertTable (fromCharset : String, toCharset : String = "") : Object
        {
            var convertTable : Object = new Object();
            var i :int = 0;
            var args : Array= [fromCharset, toCharset];
            var file : Class;
            for(i = 0; i < args.length; i++)
            {
                var fileName : String;
                try
                {
                    file = ConvertTables[args[i]];
                }
                catch ( e : Error )
                {
                    throw new CharsetException("Error, can NOT read file: " + fileName );
                }
                var fileByteArray:ByteArrayAsset = ByteArrayAsset(new file());
                var content:String = fileByteArray.readUTFBytes(fileByteArray.length);
                var codesArray : Array = content.split("\n");
                var line : String;
                var j : int = -1;
                if ( !convertTable[args[i]] )
                {
                    convertTable[args[i]] = new Object(); 
                }
                while(j <= codesArray.length)
                {
                    j++;
                    if(line = StringUtils.trim(codesArray[j]))
                    {
                        if (line.substr(0, 1) != "#")
                        {
                            var regExp : RegExp = /[\s,]+/;
                            var hexValues: Array =  line.split(regExp, 3); //We need only first 2 values
                            if (hexValues[1].substr(0, 1) != "#")
                            {
                                var arrayKey : String = hexValues[1].toUpperCase().replace(String("0x").toLowerCase(),"");
                                //var ArrayKey : String = strtoupper(str_replace(strtolower("0x"), "", HexValue[1]));
                                var arrayValue : String = String(hexValues[0]).toUpperCase().replace(String("0x").toLowerCase(),"");
                                //ArrayValue = strtoupper(str_replace(strtolower("0x"), "", HexValue[0]));
                                convertTable[args[i]]["Z"+arrayKey] = arrayValue;
                            }
                        } //if (substr(OneLine,...
                    } //if(OneLine=trim(f...
                } //while(!feof(FirstFileWi...
            } //for(i = 0; i < func_...
            
            /*if(!is_array(ConvertTable[FromCharset])) ConvertTable[FromCharset] = array();
            
            if ((args.length() > 1) && (count(ConvertTable[FromCharset]) == count(ConvertTable[ToCharset])) && (count(array_diff_assoc(ConvertTable[FromCharset], ConvertTable[ToCharset])) == 0))
            {
                //throw new CharsetException("Notice, both charsets " . $Value . " are identical! Check encoding tables files.");
                //print this -> DebugOutput(1, 1, "FromCharset, ToCharset");
            }*/
            return convertTable;
        }
	}
}
