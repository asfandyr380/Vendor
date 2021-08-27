import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Model/OdersModel.dart';
import 'package:admin_panal/Services/Api/Orders/ordersServices.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  OrderServices _orderServices = locator<OrderServices>();
  Navigation _navigation = locator<Navigation>();
  StorageServices _storageServices = locator<StorageServices>();
  List<OrderModel> orderlist = [];
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  orders() async {
    isBusy(true);
    var storeId = await _storageServices.getUserId();
    // TODO: Change to storeId Before Release
    var result = await _orderServices.getOrders(27);
    if (result is List<OrderModel>) {
      orderlist = result;
      notifyListeners();
    }
    isBusy(false);
  }

  searchOrder(String val) async {
    if (val.isEmpty) {
      orders();
    } else {
      isBusy(true);
      var result = await _orderServices.searchOrder(val);
      if (result is List<OrderModel>) {
        orderlist = result;
        notifyListeners();
      }
      isBusy(false);
    }
  }

  navigateToInvoice(OrderModel m) async {
    _navigation.navigateTo(Invoice, arguments: m);
  }
}
