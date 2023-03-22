import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant_app/common/utils/date_time_utils.dart';

import 'package:flutter_dicoding_restaurant_app/data/db/daily_reminder_preferences.dart';

import '../../common/utils/background_service_utils.dart';

part 'daily_reminder_state.dart';

class DailyReminderCubit extends Cubit<DailyReminderState> {
  final DailyReminderPreferences dailyReminderPreferences;
  final BackgroundServiceUtils backgroundServiceUtils;
  DailyReminderCubit(
    this.dailyReminderPreferences,
    this.backgroundServiceUtils,
  ) : super(DailyReminderInitial());

  void setReminder(bool status) async {
    emit(DailyReminderLoading());
    dailyReminderPreferences.setDailyReminder(status);
    final result = await dailyReminderPreferences.isRestaurantDaily;
    if (status) {
      debugPrint('scheduling reminder started');
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundServiceUtils.callback,
        startAt: DateTimeUtils.reminderTime(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling reminder cancelled');
      await AndroidAlarmManager.cancel(1);
    }
    emit(DailyReinderLoaded(status: result));
  }

  void getDailyReminder() async {
    emit(DailyReminderLoading());
    final result = await dailyReminderPreferences.isRestaurantDaily;
    emit(DailyReinderLoaded(status: result));
  }
}
