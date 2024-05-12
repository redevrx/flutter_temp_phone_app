import 'package:flutter/material.dart';
import 'package:flutter_temp_phone_app/core/constant.dart';
import 'package:flutter_temp_phone_app/views/home_view.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildSpacer(),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Image.asset(
              'assets/sms.png',
              fit: BoxFit.cover,
              width: mDeviceSize.width * .6,
            ),
          ),
          buildTextTitle(context),
          buildSpacer(),
          buildButtonNext(context),
          buildGap(),
        ],
      ),
    );
  }

  Align buildButtonNext(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: mDeviceSize.width * .9,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
              (route) => false),
          style: ElevatedButton.styleFrom(
              backgroundColor: kSecondColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultPadding),
              )),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 1.2),
            child: Text(
              'Next',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildTextTitle(BuildContext context) {
    return Text(
      "Temp Phone Number",
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Spacer buildGap() => const Spacer();

  Spacer buildSpacer() {
    return const Spacer(
      flex: 2,
    );
  }
}
