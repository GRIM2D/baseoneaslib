/*

	ShadowedTextField

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
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
package com.baseoneonline.flash.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ShadowedTextField extends Sprite
	{
		
		private var fgColor:uint = 0xFFFFFF;
		private var bgColor:uint = 0x000000;
		private var xoff:Number = 1;
		private var yoff:Number = 1;
		
		private var tfFore:TextField;
		private var tfBack:TextField;
		private var fmtFore:TextFormat;
		private var fmtBack:TextFormat;
		
		public function ShadowedTextField()
		{
			mouseChildren = false;
			mouseEnabled = false;

			tfBack = new TextField();
			tfBack.autoSize = TextFieldAutoSize.LEFT;
			tfBack.selectable = false;
			tfBack.x = xoff;
			tfBack.y = yoff;
			addChild(tfBack);
			
			tfFore = new TextField();
			tfFore.autoSize = TextFieldAutoSize.LEFT;
			tfFore.selectable = false;
			addChild(tfFore);

			fmtFore = new TextFormat();
			fmtFore.color = fgColor;

			fmtBack = new TextFormat();
			fmtBack.color = bgColor;
		}
		
		public function setText(n:String):void
		{
			tfFore.text = n;
			tfFore.setTextFormat(fmtFore);

			tfBack.text = n;
			tfBack.setTextFormat(fmtBack);
		}
		
	}
}