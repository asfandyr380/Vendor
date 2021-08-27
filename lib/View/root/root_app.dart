import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:admin_panal/Services/Navigation/router.dart';
import 'package:admin_panal/View/AdminConsole/adminConsoleView.dart';
import 'package:admin_panal/View/Login/loginView.dart';
import 'package:admin_panal/View/Order/OrderView.dart';
import 'package:admin_panal/View/Products/addproductsView.dart';
import 'package:admin_panal/View/Products/manageProducts.dart';
import 'package:admin_panal/View/root/rootViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

// This Widget is the Root of The Application
class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RootViewModel>.reactive(
      viewModelBuilder: () => RootViewModel(),
      onModelReady: (model) {
        model.checkAuthState();
      },
      builder: (ctx, model, child) => MaterialApp(
        home: model.authState ? AdminConsoleView() : LoginView(),
        // initialRoute: model.isLoading
        //     ? Loading
        //     : model.authState
        //         ? Dashboard
        //         : Login,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        navigatorKey: locator<Navigation>().navigationKey,
      ),
    );
  }
}
