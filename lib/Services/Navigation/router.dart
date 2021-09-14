import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Model/OdersModel.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/Model/storeModel.dart';
import 'package:admin_panal/View/AdminConsole/adminConsoleView.dart';
import 'package:admin_panal/View/Login/loginView.dart';
import 'package:admin_panal/View/Order/OrderView.dart';
import 'package:admin_panal/View/Order/orderInvoice.dart';
import 'package:admin_panal/View/Products/addproductsView.dart';
import 'package:admin_panal/View/Products/allProducts.dart';
import 'package:admin_panal/View/Products/manageProducts.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arg = settings.arguments;
  switch (settings.name) {
    case Dashboard:
      return _GeneratePageRoute(
          widget: AdminConsoleView(), routeName: settings.name);
    case AddProducts:
      ProductModel1? m = arg as ProductModel1?;
      return _GeneratePageRoute(
          widget: AddProduct(productModel: m), routeName: settings.name);
    case Manage:
      bool isAll = arg as bool;
      return _GeneratePageRoute(
          widget: ManageProducts(
            isAll: isAll,
          ),
          routeName: settings.name);
    case Orders:
      return _GeneratePageRoute(widget: OrderView(), routeName: settings.name);
    case Login:
      return _GeneratePageRoute(widget: LoginView(), routeName: settings.name);
    case AllProducts:
      ProductModel1? m = arg as ProductModel1?;
      return _GeneratePageRoute(
          widget: AllProductView(
            productModel: m,
          ),
          routeName: settings.name);
    case PrintPage:
      Map file = arg as Map;
      return _GeneratePageRoute(
          widget: PrintPageView(
            m: file['m'],
            model: file['model'],
          ),
          routeName: settings.name);
    case Invoice:
      OrderModel m = arg as OrderModel;
      return _GeneratePageRoute(
          widget: OrderInvoice(
            m: m,
          ),
          routeName: settings.name);

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String? routeName;
  _GeneratePageRoute({required this.widget, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: child,
              );
            });
}
