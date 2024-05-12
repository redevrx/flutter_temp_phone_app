import 'country_info.dart';

class CountryResponse {
  final String countryCode;
  final CountryInfo countryInfo;
  bool isSelect;

  CountryResponse({
    required this.countryCode,
    required this.countryInfo,
    this.isSelect = false,
  });

  static List<CountryResponse> fromJson(dynamic mJson) {
    return (mJson as List)
        .map((json) => CountryResponse(
              countryCode: json['country_code'],
              countryInfo: CountryInfo.fromJson(json['country_info']),
            ))
        .toList();
  }

  Map<String, dynamic> get toJson => Map.of({
        "country_code": countryCode,
        "country_info": countryInfo.toJson,
      });
}
