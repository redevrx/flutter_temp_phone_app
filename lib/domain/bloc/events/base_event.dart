import 'package:flutter_temp_phone_app/domain/model/sms_response.dart';

sealed class TempPhoneEvent {}

class InitEvent extends TempPhoneEvent {}

class AllCountryEvent extends TempPhoneEvent {}

class AllSmsEvent extends TempPhoneEvent {
  final Stream<List<SmsResponse>> stream;

  AllSmsEvent({required this.stream});
}

class MenuItem extends TempPhoneEvent {
  final int type;

  MenuItem({required this.type});
}
