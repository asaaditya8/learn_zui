package droid;

import haxe.Int64;

#if kha_android
import java.NativeArray;
import java.lang.Exception;
import java.util.Calendar;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.database.Cursor;
import android.net.Uri;

import tech.kode.kha.KhaActivity;
#end

class CalendarService {
    #if kha_android
	var cursor : Cursor;
	#end

    public function new() : Void {}

    public function seeEvents() : Void {
		#if kha_android
        try{
			var selectionClause: String = CalendarContract._ID + " > ?";
			var selectionArgs: NativeArray<String> = new NativeArray<String>(1);

			selectionArgs[0] = Std.string(1044);

			cursor = KhaActivity.the().getApplicationContext().getContentResolver().query(CalendarContract.CONTENT_URI,
					null, selectionClause, selectionArgs, null);
			while(cursor.moveToNext()){
				if(cursor != null){
					var id_1: Int = cursor.getColumnIndex(CalendarContract._ID);
					var id_2: Int = cursor.getColumnIndex(CalendarContract.TITLE);
					var id_3: Int = cursor.getColumnIndex(CalendarContract.DESCRIPTION);
					// var id_4: Int64 = cursor.getColumnIndex(CalendarContract.DTSTART);

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
		
		var c_id: Int = 1;

        cv.put(CalendarContract.TITLE, "Just Do It");
		cv.put(CalendarContract.DESCRIPTION, "First task from app.");
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
	
	public function updateEventInCal() : Void {
		#if kha_android
        var cr: ContentResolver =  KhaActivity.the().getApplicationContext().getContentResolver();
		var uv: ContentValues = new ContentValues();

		var selectionClause: String = CalendarContract._ID + " > ?";
		var selectionArgs: NativeArray<String> = new NativeArray<String>(1);

		selectionArgs[0] = Std.string(1048);

        uv.put(CalendarContract.TITLE, "Go! Just Do It");
		// uv.put(CalendarContract.DESCRIPTION, "First task from app.");
        // uv.put(CalendarContract.DTSTART, Calendar.getInstance().getTimeInMillis());
        // uv.put(CalendarContract.DTEND, Calendar.getInstance().getTimeInMillis() + 60 * 60 * 1000);
        // uv.put(CalendarContract.EVENT_TIMEZONE, Calendar.getInstance().getTimeZone().getID());

		try{
			var rowsUpdated : Int = cr.update(
				CalendarContract.CONTENT_URI,
				uv,
				selectionClause,
				selectionArgs);
			trace(rowsUpdated, " rows were updated");
		}
		catch(e: Exception){
			trace("Could not update Events in Calender." + e.toString());
		    return;
		}
		#end
	}
	
	public function deleteEventfromCal() : Void {
		#if kha_android
        var cr: ContentResolver =  KhaActivity.the().getApplicationContext().getContentResolver();
		
		var selectionClause: String = CalendarContract._ID + " = ?";
		var selectionArgs: NativeArray<String> = new NativeArray<String>(1);

		selectionArgs[0] = Std.string(1050);

        
		try{
			var rowsDeleted : Int = cr.delete(
				CalendarContract.CONTENT_URI,
				selectionClause,
				selectionArgs);
			trace(rowsDeleted, " rows were deleted");
		}
		catch(e: Exception){
			trace("Could not delete Event from Calender." + e.toString());
		    return;
		}
		#end
    }
}