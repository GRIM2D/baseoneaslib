/*

	RemoteOperation

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
package com.baseoneonline.flash.durin {
	import com.baseoneonline.flash.utils.logger.Logger;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	[Event(type="flash.events.Event", name="complete")]
	[Event(type="flash.events.ErrorEvent", name="error")]
	public class RemoteOperation extends EventDispatcher
	{
		
		private var con:NetConnection;
		public var command:String;
		public var result:Object;
		public var callBack:Function;
		public var argumentObject:Object;
		
		/**
		 * 
		 * @param command
		 * @param callBack
		 * @param argumentObject
		 * 
		 */
		function RemoteOperation(command:String, callBack:Function = null, argumentObject:Object=null) {
			this.command = command;
			if (callBack != null) this.callBack = callBack;
			if (argumentObject != null) this.argumentObject = argumentObject;
		}
		
		/**
		 * 
		 * @param gateway
		 * 
		 */
		public function send(gateway:String):void {
			con = new NetConnection();
			addListeners();
			con.connect(gateway);
			con.call(command, new Responder(fireResult, onStatus), argumentObject);
		}
		
		/**
		 * 
		 * 
		 */
		private function addListeners():void {
			con.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			con.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			con.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			//con.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		/**
		 * 
		 * 
		 */
		private function removeListeners():void {
			con.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			con.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			con.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			//con.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onAsyncError(e:AsyncErrorEvent):void {
			//Logger.getInstance().warn("Async Error");
			fireStatus("Async Error: "+e.text);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onIOError(e:IOErrorEvent):void {
			//Logger.getInstance().warn("IO Error");
			fireStatus("IO Error: "+e.text);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onSecurityError(e:SecurityErrorEvent):void {
			//Logger.getInstance().warn("Security Error");
			fireStatus("Security Error: "+e.text);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onNetStatus(e:NetStatusEvent):void {
			//Logger.getInstance().warn("Net Status");
			var s:String = "";
			for (var k:String in e.info) {
				s += k+": \t"+e.info[k]+"\n";
			}
			fireStatus("NetStatus: "+s);
		}

		/**
		 * 
		 * @param re
		 * 
		 */
		private function fireResult(re:Object):void {
			con.close();
			removeListeners();
			result = re;
			var e:Event = new Event(Event.COMPLETE);
			dispatchEvent(e);
		}
		
		/**
		 * 
		 * @param msg
		 * 
		 */
		private function fireStatus(msg:String):void {
			con.close();
			removeListeners();
			var e:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
			e.text = msg;
			dispatchEvent(e);
		}
		
		/**
		 * 
		 * @param re
		 * 
		 */
		private function onStatus(re:Object):void {
			//Logger.getInstance().warn("Remote Fault");
			var s:String = '';
			for (var n:String in re) {
				s += n+": "+re[n];
			}
			fireStatus(s);
		}

	}
}