/*
ShadowedTextField.as

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
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ShadowedTextField extends Sprite
	{
		
		private var tf:TextField;
		private var fmt:TextFormat;
		
		public function ShadowedTextField()
		{
			mouseChildren = false;
			mouseEnabled = false;

			
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			addChild(tf);

			fmt = new TextFormat();
			fmt.font = "sans";
			fmt.bold = true;
			fmt.color = 0xFFFFFF;

			filters = [new DropShadowFilter(1,45,0,1,3,3,4)];
		}
		
		public function setText(n:String):void
		{
			tf.text = n;
			tf.setTextFormat(fmt);

		}
		
	}
}
