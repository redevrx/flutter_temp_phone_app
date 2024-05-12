import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/core/constant.dart';
import 'package:flutter_temp_phone_app/data/service/storage_service.dart';
import 'package:flutter_temp_phone_app/domain/bloc/temp_phone_cubit.dart';
import 'package:flutter_temp_phone_app/views/home_view.dart';
import 'package:flutter_temp_phone_app/views/on_boarding_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  late final StorageService mStorage;

  @override
  void initState() {
    mStorage = StorageService();
    super.initState();
    checkFirstOpen();
  }

  void checkFirstOpen() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final isFirstUse = mStorage.isFirstUse();

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    context.read<TempPhoneCubit>().onFetchAllCountry();
    if (!isFirstUse) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const OnBoardingView(),
          ),
          (route) => false);
      return;
    }

    ///to home screen
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const HomeView(),
        ),
        (route) => false);
  }

  @override
  void dispose() {
    mStorage.setFirstUse().then((_) => null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Image.asset(
            'assets/sms.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
