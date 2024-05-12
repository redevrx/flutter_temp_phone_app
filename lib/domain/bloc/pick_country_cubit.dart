import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/domain/model/country_response.dart';

class PickCountryCubit extends Cubit<CountryResponse?> {
  PickCountryCubit() : super(null);

  String phone = "";

  void onPickCountry(CountryResponse data) =>
      emit(!data.isSelect ? null : data);

  void pickPhoneNumber(String phone) {
    this.phone = phone;
  }
}
