import 'package:flutter_temp_phone_app/data/repository/temp_phone_repo_impl.dart';

import '../model/sms_response.dart';

class FetchSmsUseCase {
  final _repo = TempPhoneRepoImpl();

  Stream<List<SmsResponse>> getSms({required String phone}) =>
      _repo.getSms(phone: phone);
}
