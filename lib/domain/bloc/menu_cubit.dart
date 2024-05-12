import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<int> {
  MenuCubit() : super(1);

  int get currentMenu => state;

  void openMenuCountry() {
    emit(1);
  }

  void openMenuNumbers() {
    emit(2);
  }
}
