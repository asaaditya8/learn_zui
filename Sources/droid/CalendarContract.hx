package droid;

#if kha_android
import android.net.Uri;
#end

class CalendarContract {
	private static var TAG: String = "Calendar";
    public static var ACTION_EVENT_REMINDER: String = "android.intent.action.EVENT_REMINDER";
    public static var ACTION_HANDLE_CUSTOM_EVENT: String = "android.provider.calendar.action.HANDLE_CUSTOM_EVENT";
    public static var EXTRA_CUSTOM_APP_URI: String = "customAppUri";
    public static var EXTRA_EVENT_BEGIN_TIME: String = "beginTime";
    public static var EXTRA_EVENT_END_TIME: String = "endTime";
    public static var EXTRA_EVENT_ALL_DAY: String = "allDay";
    public static var AUTHORITY: String = "com.android.calendar";
    public static var CALLER_IS_SYNCADAPTER: String = "caller_is_syncadapter";
	public static var ACCOUNT_TYPE_LOCAL: String = "LOCAL";
	
	public static var CALENDAR_ID: String = "calendar_id";
    public static var CONTENT_URI: Uri = Uri.parse("content://" + AUTHORITY  + "/events");  
	public static var TITLE: String = "title";
	public static var DESCRIPTION: String = "description";
	public static var EVENT_LOCATION: String = "eventLocation";
	public static var EVENT_COLOR: String = "eventColor";
	public static var EVENT_COLOR_KEY: String = "eventColor_index";
	public static var DISPLAY_COLOR: String = "displayColor";
	public static var STATUS: String = "eventStatus";
	public static var STATUS_TENTATIVE: Int = 0;
	public static var STATUS_CONFIRMED: Int = 1;
	public static var STATUS_CANCELED: Int = 2;
	public static var SELF_ATTENDEE_STATUS: String = "selfAttendeeStatus";
	public static var SYNC_DATA1: String = "sync_data1";
	public static var SYNC_DATA2: String = "sync_data2";
	public static var SYNC_DATA3: String = "sync_data3";
	public static var SYNC_DATA4: String = "sync_data4";
	public static var SYNC_DATA5: String = "sync_data5";
	public static var SYNC_DATA6: String = "sync_data6";
	public static var SYNC_DATA7: String = "sync_data7";
	public static var SYNC_DATA8: String = "sync_data8";
	public static var SYNC_DATA9: String = "sync_data9";
	public static var SYNC_DATA10: String = "sync_data10";
	public static var LAST_SYNCED: String = "lastSynced";
	public static var DTSTART: String = "dtstart";
	public static var DTEND: String = "dtend";
	public static var DURATION: String = "duration";
	public static var EVENT_TIMEZONE: String = "eventTimezone";
	public static var EVENT_END_TIMEZONE: String = "eventEndTimezone";
	public static var ALL_DAY: String = "allDay";
	public static var ACCESS_LEVEL: String = "accessLevel";
	public static var ACCESS_DEFAULT: Int = 0;
	public static var ACCESS_CONFIDENTIAL: Int = 1;
	public static var ACCESS_PRIVATE: Int = 2;
	public static var ACCESS_PUBLIC: Int = 3;
	public static var AVAILABILITY: String = "availability";
	public static var AVAILABILITY_BUSY: Int = 0;
	public static var AVAILABILITY_FREE: Int = 1;
	public static var AVAILABILITY_TENTATIVE: Int = 2;
	public static var HAS_ALARM: String = "hasAlarm";
	public static var HAS_EXTENDED_PROPERTIES: String = "hasExtendedProperties";
	public static var RRULE: String = "rrule";
	public static var RDATE: String = "rdate";
	public static var EXRULE: String = "exrule";
	public static var EXDATE: String = "exdate";
	public static var ORIGINAL_ID: String = "original_id";
	public static var ORIGINAL_SYNC_ID: String = "original_sync_id";
	public static var ORIGINAL_INSTANCE_TIME: String = "originalInstanceTime";
	public static var ORIGINAL_ALL_DAY: String = "originalAllDay";
	public static var LAST_DATE: String = "lastDate";
	public static var HAS_ATTENDEE_DATA: String = "hasAttendeeData";
	public static var GUESTS_CAN_MODIFY: String = "guestsCanModify";
	public static var GUESTS_CAN_INVITE_OTHERS: String = "guestsCanInviteOthers";
	public static var GUESTS_CAN_SEE_GUESTS: String = "guestsCanSeeGuests";
	public static var ORGANIZER: String = "organizer";
	public static var IS_ORGANIZER: String = "isOrganizer";
	public static var CAN_INVITE_OTHERS: String = "canInviteOthers";
	public static var CUSTOM_APP_PACKAGE: String = "customAppPackage";
	public static var CUSTOM_APP_URI: String = "customAppUri";
	public static var UID_2445: String = "uid2445";

	public static var _ID : String = "_id";
}