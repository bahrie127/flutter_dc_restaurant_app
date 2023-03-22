import 'package:shared_preferences/shared_preferences.dart';

class DailyReminderPreferences {
  final Future<SharedPreferences> sharedPreference;

  DailyReminderPreferences(this.sharedPreference);

  static const dailyReminderKey = 'Daily-Reminder';

  Future<bool> get isRestaurantDaily async {
    final prefs = await sharedPreference;

    return prefs.getBool(dailyReminderKey) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(dailyReminderKey, value);
  }
}
