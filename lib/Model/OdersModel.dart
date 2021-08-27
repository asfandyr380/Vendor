import 'package:admin_panal/Model/productModel.dart';

class OrderModel {
  int orderId = 0;
  String? username = '';
  int? subTotal = 0;
  String? couponNo = '';
  int? discount = 0;
  String user_postalCode = '';
  int grandTotal = 0;
  String address = '';
  String date = '';
  String orderStatus = '0';
  List<InvoiceModel>? products;
  OrderModel.fromJson(Map map, List products)
      : orderId = map['OrderId'],
        username = map['Username'],
        subTotal = map['SubTotal'],
        couponNo = map['CouponNo'],
        discount = map['Discount'],
        user_postalCode = map['Postal_Code'],
        grandTotal = map['GrandTotal'],
        address = map['Address'],
        date = map['Date'],
        orderStatus = map['orderStatus'].toString(),
        products = products.map((e) => InvoiceModel.fromMap(e)).toList();
}

class InvoiceModel {
  String item = '';
  int unitPrice = 0;
  String storeName = '';
  int quantity = 0;
  String total = '0';
  double vatt = 0;

  InvoiceModel.fromMap(Map map)
      : item = map['name'],
        unitPrice = map['subTotal'],
        storeName = map['store_name'],
        quantity = map['quantity'],
        total = map['grandtotal'].toString(),
        vatt = map['vatt'];
}
