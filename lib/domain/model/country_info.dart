class CountryInfo {
  final String countryCodeIso;
  final String countryName;
  final List<String> phones;

  CountryInfo({
    required this.countryCodeIso,
    required this.countryName,
    required this.phones,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
      countryCodeIso: json['country_code_iso'],
      countryName: json['country_name'],
      phones: List<String>.from(json['phones'] ?? []));

  Map<String, dynamic> get toJson => Map.of({
        'country_code_iso': countryCodeIso,
        'country_name': countryName,
        'phones': phones.map((e) => e).toList(),
      });
}
