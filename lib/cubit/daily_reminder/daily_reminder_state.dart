part of 'daily_reminder_cubit.dart';

abstract class DailyReminderState extends Equatable {
  const DailyReminderState();

  @override
  List<Object> get props => [];
}

class DailyReminderInitial extends DailyReminderState {}

class DailyReminderLoading extends DailyReminderState {}

class DailyReinderLoaded extends DailyReminderState {
  final bool status;
  const DailyReinderLoaded({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}
