import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/domain/bloc/events/base_event.dart';
import 'package:flutter_temp_phone_app/domain/usecase/all_country_use_case.dart';

import '../model/country_response.dart';

class TempPhoneCubit extends Cubit<TempPhoneEvent> {
  TempPhoneCubit() : super(InitEvent());

  final _countryUseCase = AllCountryUseCase();

  List<CountryResponse> countryList = [];

  void onFetchAllCountry() {
    if (countryList.isNotEmpty) {
      emit(AllCountryEvent());
      return;
    }

    _countryUseCase.getAllCountry.listen((event) {
      countryList.addAll(event);
      emit(AllCountryEvent());
    });
  }
}
