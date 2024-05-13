import '../../model/sms_response.dart';

sealed class SmsEvent {}

class InitSmsEvent extends SmsEvent {}

class SmsSuccess extends SmsEvent {
  final List<SmsResponse> response;

  SmsSuccess({required this.response});
}

class SmsLoading extends SmsEvent{}
