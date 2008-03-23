/*

	StopWatch

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
package com.baseoneonline.flash.utils
{
	public class StringTools
	{
		public static function getExtension(s:String):String {
			var dot:int = s.lastIndexOf('.');
			if (dot == -1) return '';
			return s.substring(dot+1,s.length);
		}
		
		public static function stripExtension(s:String):String {
			var dot:int = s.lastIndexOf('.');
			if (dot == -1) return s;
			return s.substring(0, dot);
		}
	}
}