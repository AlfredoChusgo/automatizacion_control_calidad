import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:poo_spa/src/app.dart';
import 'package:poo_spa/src/helpers/key_constant_helper.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      // Replace later with your app's main widget
      // await $.native.enableCellular();
      // await $.native.disableWifi();

      await $.pumpWidgetAndSettle(MyApp(),
          duration: const Duration(seconds: 5));
      // await createApp($);

      //await $.pumpAndSettle();
      // $("Clientes");
      //await Future.delayed(Duration(seconds: 5));
      expect($("Clientes"), findsOneWidget);
      await $(K.homePageBottomNavigationBar).$("Clientes").tap();
      
      await Future.delayed(Duration(seconds: 5));
      // expect($('app'), findsOneWidget);
      // if (!Platform.isMacOS) {
      //   await $.native.pressHome();
      // }
    },
  );
}
