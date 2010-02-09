/*
StringTools.as

	Copyright (c) 2008 Bas Korsmit

    This file is part of baseone_flashLib

    baseone_flashLib is free software: you can
    redistribute it and/or modify it under the terms of the
    GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License,
    or any later version.

    baseone_flashLib Library is distributed
    in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with baseone_flashLib  If not, see <http://www.gnu.org/licenses/>.
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
		
		public static function isEmailAddress(n:String):Boolean {
			return (n.match(/^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/m) != null);
		} 
	}
}
