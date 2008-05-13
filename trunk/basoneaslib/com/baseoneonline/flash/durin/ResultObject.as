/*

	ResultObject

	Copyright (c) 2008 B Korsmit

    This file is part of BaseOne Actionscript 3 Library.

    BaseOne Actionscript 3 Library is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    BaseOne Actionscript 3 Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with BaseOne Actionscript 3 Library.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.durin
{
	/**
	 * 
	 * Defines a generic object returned by Durin
	 * 
	 * @author B Korsmit
	 * 
	 */
	public class ResultObject
	{
		
		/**
		 * Was the server-side operation successful?
		 */
		public var success:Boolean;
		
		/**
		 * Details about this operation.
		 */
		public var message:String;
		
		/**
		 * The actual data that was returned.
		 */
		public var data:Object;
		
		/**
		 * 
		 * @param success	Was the server-side operation successful?
		 * @param message	Details about this operation.
		 * @param data		The actual data that was returned.
		 * 
		 */
		function ResultObject(success:Boolean, message:String=null, data:Object=null) {
			this.success = success;
			this.message = message;
			this.data = data;
		}

	}
}