import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Services/Api/Messages/messageServices.dart';
import 'package:admin_panal/Services/Api/Orders/ordersServices.dart';
import 'package:admin_panal/Services/Api/Products/Products_Services.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Api/Store/storeServices.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class AdminConsoleViewModel extends ChangeNotifier {
  OrderServices _services = locator<OrderServices>();
  ProductServices _productServices = locator<ProductServices>();
  Navigation _navigaiton = locator<Navigation>();
  StorageServices _storageServices = locator<StorageServices>();
  String orderCount = '';
  String productCount = '';

  countOrder() async {
    int userId = await _storageServices.getUserId();
    var result = await _services.getOrderCount(userId);
    orderCount = result.toString();
    notifyListeners();
  }

  countProducts() async {
    int userId = await _storageServices.getUserId();
    var result = await _productServices.getTotalProducts(userId);
    productCount = result.toString();
    notifyListeners();
  }

  navigateToOrders() {
    _navigaiton.navigateTo(Orders);
  }
}
