import 'package:flutter_temp_phone_app/data/service/temp_phone_service.dart';
import 'package:flutter_temp_phone_app/domain/model/country_response.dart';
import 'package:flutter_temp_phone_app/domain/model/sms_response.dart';
import 'package:flutter_temp_phone_app/domain/repository/temp_phone_repo.dart';

class TempPhoneRepoImpl with TempPhoneRepo {
  final _service = TempPhoneService();

  @override
  Stream<List<CountryResponse>> getAllCountry() => _service.getAllCountry();

  @override
  Stream<List<SmsResponse>> getSms({required String phone}) =>
      _service.getSms(phone: phone);
}
