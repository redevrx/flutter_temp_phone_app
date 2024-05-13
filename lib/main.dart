import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/domain/bloc/menu_cubit.dart';
import 'package:flutter_temp_phone_app/domain/bloc/sms_cubit.dart';
import 'package:flutter_temp_phone_app/domain/bloc/temp_phone_cubit.dart';
import 'package:flutter_temp_phone_app/views/splash_screen_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TempPhoneCubit(),
        ),
        BlocProvider(
          create: (context) => MenuCubit(),
        ),
        BlocProvider(
          create: (context) => SmsCubit(),
        )
      ],
      child: const MaterialApp(
        home: SplashScreenView(),
      ),
    );
  }
}
