import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/View/root/root_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootWidget();
  }
}
