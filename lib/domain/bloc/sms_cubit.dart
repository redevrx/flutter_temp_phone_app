import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/domain/model/sms_response.dart';

import '../model/country_response.dart';
import '../usecase/fetch_sms_use_case.dart';

class SmsCubit extends Cubit<List<SmsResponse>> {
  SmsCubit() : super([]);

  final _smsUseCase = FetchSmsUseCase();

  String phone = "";
  CountryResponse? data;

  void pickPhoneNumber(String phone) {
    this.phone = phone;
    fetchSms();
  }

  void onPickCountry(CountryResponse data) {
    this.data = !data.isSelect ? null : data;
  }

  void fetchSms() async {
    emit([SmsResponse(sendPhone: '', recvTime: '', text: '')]);
    emit(await _smsUseCase.getSms(phone: phone).first);
  }
}
