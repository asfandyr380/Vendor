import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Services/Api/Messages/messageServices.dart';
import 'package:admin_panal/Services/Api/Orders/ordersServices.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Api/Store/storeServices.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class AdminConsoleViewModel extends ChangeNotifier {
  OrderServices _services = locator<OrderServices>();
  ProductServices _productServices = locator<ProductServices>();
  Navigation _navigaiton = locator<Navigation>();
  String orderCount = '';
  String productCount = '';

  countOrder() async {
    // TODO: Get Store Id From Storage
    var result = await _services.getOrderCount(27);
    orderCount = result.toString();
    notifyListeners();
  }

  countProducts() async {
    // TODO: Get Store Id From Storage
    var result = await _productServices.getTotalProducts(27);
    productCount = result.toString();
    notifyListeners();
  }

  navigateToOrders() {
    _navigaiton.navigateTo(Orders);
  }
}
