import 'dart:convert';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Model/OdersModel.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future getOrderCount(int id) async {
    Uri _url = Uri.parse('$baseUrl/orders/storeCount/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return decodedBody['totalOrders'];
    }
  }

  Future getOrders(int id) async {
    final List<OrderModel> orders = [];
    Uri _url = Uri.parse('$baseUrl/orders/store/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var order in data) {
        List info = order['result'];
        var ord = OrderModel.fromJson(order, info);
        orders.add(ord);
      }
      return orders;
    }
  }

  searchOrder(String key) async {
    final List<OrderModel> orders = [];
    Uri _url = Uri.parse('$baseUrl/orders/search/$key');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var order in data) {
        List info = order['result'];
        var ord = OrderModel.fromJson(order, info);
        orders.add(ord);
      }
      return orders;
    }
  }

  updateStatus(int id, String status) async {
    Uri _url = Uri.parse('$baseUrl/orders/$id');
    var map = {"status": status};
    http.Response res = await http.put(_url, body: map);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return true;
    } else
      return false;
  }
}
