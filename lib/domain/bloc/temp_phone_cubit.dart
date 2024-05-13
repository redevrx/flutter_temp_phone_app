import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/domain/bloc/events/base_event.dart';
import 'package:flutter_temp_phone_app/domain/usecase/all_country_use_case.dart';
import 'package:rxcache_network_image/rxcache_network_image.dart';

import '../model/country_response.dart';

class TempPhoneCubit extends Cubit<TempPhoneEvent> {
  TempPhoneCubit() : super(InitEvent());

  final _countryUseCase = AllCountryUseCase();
  final download = RxCacheManager();

  List<CountryResponse> countryList = [];

  void onFetchAllCountry() {
    if (countryList.isNotEmpty) {
      emit(AllCountryEvent());
      return;
    }

    _countryUseCase.getAllCountry.listen((event) {
      Future.forEach(event, (element) {
        final url =
            "https://flagcdn.com/48x36/${element.countryInfo.countryCodeIso.toLowerCase()}.png";
        download.download(url: url);
      });

      countryList.addAll(event);
      emit(AllCountryEvent());
    });
  }
}
