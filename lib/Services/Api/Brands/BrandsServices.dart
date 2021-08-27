import 'dart:convert';

import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Model/brandsModel.dart';
import 'package:http/http.dart' as http;

class BrandServices {
  Future getBrands() async {
    Uri _url = Uri.parse('$baseUrl/brands/');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      return data.map((e) => Brand.fromMap(e)).toList();
    }
  }
}
