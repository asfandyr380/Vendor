import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/routes.dart';
import 'package:admin_panal/Model/OdersModel.dart';
import 'package:admin_panal/Services/Api/Orders/ordersServices.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:flutter/material.dart';

class InvoiceViewModel extends ChangeNotifier {
  double subTotal = 0;
  double grandTotal = 0;
  double minusAmount = 0;
  String status = '';
  List<String> items = [
    'Pending',
    'In Process',
    'Packing',
    'Out For Delivery',
    'Delivered'
  ];
  String selectedState = '';
  Navigation _navigation = locator<Navigation>();
  OrderServices _orderServices = locator<OrderServices>();
  calculate(OrderModel me) async {
    for (var m in me.products!) {
      var total = (m.vatt / 100 + 1) * double.parse(m.total);
      var finalAmount = double.parse(total.toStringAsFixed(2));
      m.total = finalAmount.toString();
      subTotal += double.parse(m.total);
    }
    minusDiscount(me.discount!);
    print(me.orderStatus);
    getStatus(me.orderStatus);
  }

  minusDiscount(int discount) {
    var decimal = discount / 100;
    minusAmount = subTotal * decimal;
    grandTotal = subTotal - minusAmount;
  }

  getStatus(String st) {
    switch (st) {
      case '0':
        selectedState = items[0];

        break;
      case '1':
        selectedState = items[1];

        break;

      case '2':
        selectedState = items[2];

        break;

      case '3':
        selectedState = items[3];

        break;

      case '4':
        selectedState = items[4];

        break;
    }
  }

  checkStatus(String st) {
    switch (st) {
      case 'Pending':
        status = "0";

        break;
      case 'In Process':
        status = "1";

        break;

      case 'Packing':
        status = "2";

        break;

      case 'Out For Delivery':
        status = "3";

        break;

      case 'Delivered':
        status = "4";

        break;
    }
  }

  onChange(int id, String st) async {
    selectedState = st;
    notifyListeners();
    checkStatus(st);
    print('Test2 ==> $st');
    print('Test1 ==> $status');
    var result = await _orderServices.updateStatus(id, status);
    if (result == 1) {
      return true;
    } else
      return false;
  }

  navigateToPrint(OrderModel m, var model) {
    _navigation.navigateTo(PrintPage, arguments: {"m": m, "model": model});
  }
}
