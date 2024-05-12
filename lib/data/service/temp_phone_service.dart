import 'package:flutter_temp_phone_app/core/network/client.dart';
import 'package:flutter_temp_phone_app/domain/model/country_response.dart';
import 'package:flutter_temp_phone_app/domain/model/sms_response.dart';

class TempPhoneService {
  final mClient = Client();

  Stream<List<CountryResponse>> getAllCountry() {
    return mClient
        .get<List<CountryResponse>>(
            endpoint: "countries-list", success: CountryResponse.fromJson)
        .asStream();
  }

  Stream<List<SmsResponse>> getSms({required String phone}) {
    return mClient
        .get<List<SmsResponse>>(
          endpoint: "fetch-sms/$phone",
          success: SmsResponse.fromJson,
        )
        .asStream();
  }
}
