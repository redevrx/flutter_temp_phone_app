import 'package:flutter_temp_phone_app/data/repository/temp_phone_repo_impl.dart';

import '../model/country_response.dart';

class AllCountryUseCase {
  final _repo = TempPhoneRepoImpl();

  Stream<List<CountryResponse>> get getAllCountry => _repo.getAllCountry();
}
