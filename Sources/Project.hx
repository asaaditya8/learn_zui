package;

import kha.Sound;
import haxe.Constraints.FlatEnum;
import kha.ScreenCanvas;
import kha.ScreenRotation;
import kha.System;
import kha.Color;
import kha.Display;
import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;
#if kha_html5
import kha.Macros;
import js.html.CanvasElement;
import js.Browser.document;
import js.Browser.window;
#end

#if kha_android
import droid.CalendarContract;

import java.NativeArray;
import java.lang.Integer;
import java.lang.Exception;
import java.util.Calendar;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.database.Cursor;
import android.provider.AlarmClock;
import android.net.Uri;

import tech.kode.kha.KhaActivity;
#end

import zui.*;
import Length.Length;

class Project {
	public var ui:Zui;

	#if kha_android
	var CHANNEL_1_ID : String = "channel1";
	var cursor : Cursor;
	#end

	var itemList = ["Item 1", "Item 2", "Item 3"];

	public function new():Void {
		setFullWindowCanvas();
		var lengths = new Length();
		var device = lengths.device_type();
		var scaleFactor:Float;
		switch device {
			case Laptop:
				scaleFactor = 1.5;
			case Tablet:
				scaleFactor = 3;
			case Mobile:
				scaleFactor = 4;
		}
		ui = new Zui({font: Assets.fonts.Abel_Regular, scaleFactor: scaleFactor});

		setup_channel();
	}

	public function update():Void {}

	public function render(frames:Array<Framebuffer>):Void {
		var graphics = frames[0].g2;
		graphics.begin();
		graphics.end();
		gui(graphics);
	}

	public function gui(graphics:Graphics):Void {
		ui.begin(graphics);

		// if (ui.window(Id.handle(), 10, 10, System.windowWidth() - 20, System.windowHeight() - 20)) {
        if( ui.window(Id.handle(), 10, 10, 500, 600) ){
			// if(ui.check(Id.handle(), "Hi, Click me to say Hello!")) {
			//     ui.text("World!");
			// }
			// ui.slider(Id.handle(), 'Volume', 0, 300, false, 1);

			if(ui.button('See Notifications!')){
				seeEvents();
			}
		}

		ui.end();
	}

	public function seeEvents() : Void {
		#if kha_android
        try{
			var selectionClause: String = CalendarContract._ID + " > ?";
			var selectionArgs: NativeArray<String> = new NativeArray<String>(1);

			selectionArgs[0] = Std.string(1043);

			cursor = KhaActivity.the().getApplicationContext().getContentResolver().query(CalendarContract.CONTENT_URI,
					null, selectionClause, selectionArgs, null);
			while(cursor.moveToNext()){
				if(cursor != null){
					var id_1: Int = cursor.getColumnIndex(CalendarContract._ID);
					var id_2: Int = cursor.getColumnIndex(CalendarContract.TITLE);
					var id_3: Int = cursor.getColumnIndex(CalendarContract.DESCRIPTION);
					// var id_4: Int = cursor.getColumnIndex(CalendarContract.DTSTART);

					var idValue: String = cursor.getString(id_1);
					var titleValue: String = cursor.getString(id_2);
					var dscptValue: String = cursor.getString(id_3);

					trace(idValue + ", " + titleValue + ", " + dscptValue);
	            	// Toast.makeText(this, idValue + ", " + titleValue + ", " + dscptValue, Toast.LENGTH_SHORT).show();

				}
			}	
		}
		catch(e: Exception){
			trace("Error Reading: " + e.toString());
		}
		#end
    }

	public function addEventToCal() : Void {
		#if kha_android
        var cr: ContentResolver =  KhaActivity.the().getApplicationContext().getContentResolver();
		var cv: ContentValues = new ContentValues();
		
		var c_id: Integer = 1;

        cv.put("title", "Just Do It");
        cv.put("description", "First task from app.");
        cv.put(CalendarContract.DTSTART, Calendar.getInstance().getTimeInMillis());
        cv.put(CalendarContract.DTEND, Calendar.getInstance().getTimeInMillis() + 60 * 60 * 1000);
        cv.put(CalendarContract.CALENDAR_ID, c_id);
        cv.put(CalendarContract.EVENT_TIMEZONE, Calendar.getInstance().getTimeZone().getID());

		try{
			var uri : Uri = cr.insert(CalendarContract.CONTENT_URI, cv);
			trace(uri.toString());
		}
		catch(e: Exception){
			trace("Could not add Event to Calender." + e.toString());
		    return;
		}
		#end
    }

	public function setup_channel() : Void {
		#if kha_android
		var channel1: NotificationChannel = new NotificationChannel(
			CHANNEL_1_ID, "Channel 1", NotificationManager.IMPORTANCE_HIGH);
		channel1.setDescription("This is Channel 1 for x notification.");

		var manager = cast(KhaActivity.the().getSystemService("notification"), NotificationManager);
		try {
			manager.createNotificationChannel(channel1);
		} catch (e: Exception) {
			trace("Some error occured in creating notification" + e.toString());
		}
		#end
	}

	public function ab_notify() : Void {
		#if kha_android
		var manager = cast(KhaActivity.the().getSystemService("notification"), NotificationManager);
		
		var title : String = "Hey Man!";
		var text : String = "Have you finished your task?";
		var priority = NotificationManager.IMPORTANCE_HIGH;
		var category = Notification.CATEGORY_MESSAGE; 

		untyped __java__("android.app.Notification notification = new android.app.Notification.Builder(((android.content.Context) (tech.kode.kha.KhaActivity.the().getApplicationContext()) ), haxe.lang.Runtime.toString(this.CHANNEL_1_ID)).setSmallIcon(android.R.drawable.ic_dialog_dialer).setContentTitle(title).setContentText(text).setPriority(priority).setCategory(category).build();");
		untyped __java__("manager.notify(((int) (1) ), ((android.app.Notification) (notification) ));");
		#end
	}

	static function soundAlarm() : Void {
		#if kha_android
		var hour: String = "20";
		var minute: String = "26";
		var intent = new Intent(AlarmClock.ACTION_SET_ALARM);
		intent.putExtra(AlarmClock.EXTRA_HOUR, hour);
		intent.putExtra( AlarmClock.EXTRA_MINUTES, minute);
		// if(hour < 24 && minute < 60){
		KhaActivity.the().startActivity(intent);
        // }
		#end
	}

	static function setFullWindowCanvas():Void {
		#if kha_html5
		// make html5 canvas resizable
		document.documentElement.style.padding = "0";
		document.documentElement.style.margin = "0";
		document.body.style.padding = "0";
		document.body.style.margin = "0";
		var canvas:CanvasElement = cast document.getElementById(Macros.canvasId());
		canvas.style.display = "block";

		var resize = function() {
			canvas.width = Std.int(window.innerWidth * window.devicePixelRatio);
			canvas.height = Std.int(window.innerHeight * window.devicePixelRatio);
			canvas.style.width = document.documentElement.clientWidth + "px";
			canvas.style.height = document.documentElement.clientHeight + "px";
		}
		window.onresize = resize;
		resize();
		#end
    }
}
