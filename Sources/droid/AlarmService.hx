package droid;

#if kha_android
import java.lang.Exception;

import android.content.Intent;
import android.provider.AlarmClock;

import tech.kode.kha.KhaActivity;
#end


class AlarmService {
    public static function soundAlarm() : Void {
		#if kha_android
		try{
			var hour: String = "20";
			var minute: String = "26";
			var intent = new Intent(AlarmClock.ACTION_SET_ALARM);
			intent.putExtra(AlarmClock.EXTRA_HOUR, hour);
			intent.putExtra( AlarmClock.EXTRA_MINUTES, minute);
			// if(hour < 24 && minute < 60){
			KhaActivity.the().startActivity(intent);
			// }
		}
		catch(e: Exception){
			trace("Error in alarm: " + e.toString);
		}
		#end
	}
}