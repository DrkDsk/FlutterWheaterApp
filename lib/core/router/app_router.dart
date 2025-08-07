
import 'package:clima_app/core/enum/transitions_type_enum.dart';
import 'package:clima_app/core/transitions/custom_transitions.dart';
import 'package:flutter/material.dart';

class AppRouter {

  static late NavigatorState _navigator;

  AppRouter(BuildContext context) {
    _navigator = Navigator.of(context);
  }

  static AppRouter of(BuildContext context) {
   return AppRouter(context);
  }

  void pop() => _navigator.pop();

  void popUntil(int count) {
    var temp = 0;
    _navigator.popUntil((route) {
      return temp++ == count;
    });
  }

  Future<void> goToScreen(Widget screen, {TransitionType type = TransitionType.slideFromRight}) async {
    await _navigator.push(_createRoute(screen: screen, type: type));
  }

  Future<void> goToScreenAndClear(Widget screen, {TransitionType type = TransitionType.slideFromRight}) async {
    await _navigator.pushAndRemoveUntil(
      _createRoute(screen: screen, type: type),
      (route) => false,
    );
  }

  PageRouteBuilder _createRoute({required Widget screen, required TransitionType type}) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => screen,
    transitionsBuilder: (_, animation, __, child) => CustomTransitionBuilder.build(animation: animation, child: child, type: type),
  );
}