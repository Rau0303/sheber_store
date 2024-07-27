import 'package:flutter/material.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/address_screen/address_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/payment_cards_screen/payment_cards_screen.dart';
import 'package:sheber_market/screens/main/profile_screen/app_settings_screen/profile_settings_screen/profile_settings_screen.dart';


class AppSettingsLogic {
  final BuildContext context;

  AppSettingsLogic(this.context);

  List<Map<String, dynamic>> get elements => [
    {'title': 'Настройки профиля', 'route': ProfileSettingsScreen.route()},
    {'title': 'Настройки адресов', 'route': AddressScreen.route()},
    {'title': 'Настройки карт', 'route': PaymentCardsScreen.route()},
  ];

  void onTileTap(int index) {
    final route = elements[index]['route'] as String;
    Navigator.pushNamed(context, route);
  }
}
