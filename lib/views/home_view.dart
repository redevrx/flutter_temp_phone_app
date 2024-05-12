import 'dart:async';

import 'package:animated_nav_sheet/animated_nav_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp_phone_app/core/constant.dart';
import 'package:flutter_temp_phone_app/domain/bloc/events/base_event.dart';
import 'package:flutter_temp_phone_app/domain/bloc/menu_cubit.dart';
import 'package:flutter_temp_phone_app/domain/bloc/sms_cubit.dart';
import 'package:flutter_temp_phone_app/domain/bloc/temp_phone_cubit.dart';
import 'package:rxcache_network_image/rxcache_network_image.dart';

import '../domain/model/sms_response.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _navController = NavController();
  late final TempPhoneCubit tempPhone;

  @override
  void initState() {
    tempPhone = context.read<TempPhoneCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: AnimationNavSheet(
        color: kSecondColor,
        maxHeight: mDeviceSize.height * .5,
        navWidget: buildNavItems(),
        expendedWidget: buildSheetBody(),
        navController: _navController,
        child: buildMainBody(),
      ),
    );
  }

  Column buildMainBody() {
    return Column(
      children: [
        const SizedBox(
          height: kToolbarHeight + kDefaultPadding,
        ),
        BlocBuilder<SmsCubit, List<SmsResponse>>(
          bloc: context.read(),
          builder: (context, state) {
            if (state.isNotEmpty) {
              return Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<SmsCubit>().fetchSms();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kSecondColor),
                    child: Text(
                      "Refresh",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )),
              );
            }

            return const SizedBox();
          },
        ),
        BlocBuilder<SmsCubit, List<SmsResponse>>(
          builder: (context, state) {
            if (state.isEmpty && context.read<SmsCubit>().phone.isEmpty) {
              return Align(
                child: Text(
                  "Please select country and phone number",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.isNotEmpty &&
                state.length == 1 &&
                state.first.text.isEmpty) {
              return buildLoading(mColor: kSecondColor);
            }

            return Expanded(
              child: ListView.builder(
                itemCount: context.read<SmsCubit>().state.length,
                itemBuilder: (context, index) {
                  final data = context.read<SmsCubit>().state[index];
                  return Container(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    margin: const EdgeInsets.all(kDefaultPadding / 2),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kSecondColor,
                        ),
                        borderRadius: BorderRadius.circular(kDefaultPadding)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "From: :${data.sendPhone}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            Text(
                              "Time: ${data.recvTime}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Text(
                          data.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Stack buildSheetBody() {
    return Stack(
      children: [
        Column(
          children: [
            BlocBuilder<MenuCubit, int>(
              bloc: context.read(),
              builder: (context, state) {
                Future.microtask(() => tempPhone.onFetchAllCountry());
                if (state == 1) {
                  return Expanded(
                    child: BlocBuilder<TempPhoneCubit, TempPhoneEvent>(
                      builder: (context, state) {
                        if (state is AllCountryEvent) {
                          final response = tempPhone.countryList;
                          return response.isNotEmpty
                              ? ListView.builder(
                                  itemCount: context
                                      .watch<TempPhoneCubit>()
                                      .countryList
                                      .length,
                                  itemBuilder: (context, index) {
                                    final data = context
                                        .watch<TempPhoneCubit>()
                                        .countryList[index];
                                    return InkWell(
                                      onTap: () async {
                                        final select = !data.isSelect;
                                        for (var element in response) {
                                          element.isSelect = false;
                                        }

                                        data.isSelect = select;
                                        tempPhone.onFetchAllCountry();
                                        context
                                            .read<SmsCubit>()
                                            .onPickCountry(data);

                                        context
                                            .read<MenuCubit>()
                                            .openMenuNumbers();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding / 2),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: kDefaultPadding / 4),
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.circular(
                                              kDefaultPadding),
                                        ),
                                        child: Row(
                                          children: [
                                            RxImage.cacheNetwork(
                                              key: Key(data
                                                  .countryInfo.countryCodeIso),
                                              url:
                                                  "https://flagcdn.com/48x36/${data.countryInfo.countryCodeIso.toLowerCase()}.png",
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              width: kDefaultPadding,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.countryInfo
                                                        .countryName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${data.countryInfo.phones.length}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            CupertinoCheckbox(
                                              value: data.isSelect,
                                              onChanged: (value) {},
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Text("Data Not Found");
                        }

                        return buildLoading();
                      },
                    ),
                  );
                }

                if (state == 2) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: context
                              .read<SmsCubit>()
                              .data
                              ?.countryInfo
                              .phones
                              .length ??
                          0,
                      itemBuilder: (context, index) {
                        final data = context
                            .read<SmsCubit>()
                            .data
                            ?.countryInfo
                            .phones[index];
                        return InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: data ?? ''));

                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Copy Success'),
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kDefaultPadding)),
                            ));

                            context
                                .read<SmsCubit>()
                                .pickPhoneNumber(data ?? '');
                            _navController.reverse();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            margin: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              border: Border.all(color: kPrimaryColor),
                            ),
                            child: Text(
                              data ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                Future.microtask(context.read<MenuCubit>().openMenuCountry);
                return const SizedBox();
              },
            )
          ],
        ),
        Positioned(
          bottom: 0,
          left: mDeviceSize.width * .2,
          right: mDeviceSize.width * .2,
          child: buildNavItems(),
        )
      ],
    );
  }

  Row buildLoading({Color mColor = kPrimaryColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: mColor,
        ),
      ],
    );
  }

  Row buildNavItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: InkWell(
            onTap: () async {
              _navController.forward();
              context.read<MenuCubit>().openMenuCountry();
            },
            child: Image.asset(
              "assets/country_list_icon.png",
              color: Colors.white,
              fit: BoxFit.cover,
              width: kDefaultPadding * 1.4,
            ),
          ),
        ),
        Flexible(
          child: InkWell(
            onTap: () async {
              _navController.forward();
              context.read<MenuCubit>().openMenuNumbers();
            },
            child: Image.asset(
              "assets/list.png",
              color: Colors.white,
              fit: BoxFit.cover,
              width: kDefaultPadding * 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
