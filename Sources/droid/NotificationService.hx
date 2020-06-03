package droid;

#if kha_android
import java.lang.Exception;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;

import tech.kode.kha.KhaActivity;
#end


class NotificationService {
	var CHANNEL_1_ID : String = "channel1";

    public function new() : Void {
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

        try{
		untyped __java__("android.app.Notification notification = new android.app.Notification.Builder(((android.content.Context) (tech.kode.kha.KhaActivity.the().getApplicationContext()) ), haxe.lang.Runtime.toString(this.CHANNEL_1_ID)).setSmallIcon(android.R.drawable.ic_dialog_dialer).setContentTitle(title).setContentText(text).setPriority(priority).setCategory(category).build();");
        untyped __java__("manager.notify(((int) (1) ), ((android.app.Notification) (notification) ));");
        }
        catch(e: Exception){
            trace("Error in sending notification: " + e.toString());
        }
		#end
	}
}