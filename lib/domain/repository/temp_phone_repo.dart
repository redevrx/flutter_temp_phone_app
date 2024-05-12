import '../model/country_response.dart';
import '../model/sms_response.dart';

mixin TempPhoneRepo {
  Stream<List<CountryResponse>> getAllCountry();

  Stream<List<SmsResponse>> getSms({required String phone});
}
