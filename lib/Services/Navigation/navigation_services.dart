import 'package:flutter/material.dart';

class Navigation {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState!.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplaceRoute(Widget routePath, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => routePath));
  }
}
