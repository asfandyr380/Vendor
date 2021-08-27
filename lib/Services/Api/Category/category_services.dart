import 'dart:convert';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Model/categoryModel.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  Future getProductCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/productCate/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      Map map = {
        'main': decodedBody['data']['main_cate'],
        'super': decodedBody['data']['cate_name'],
        'sub': decodedBody['data']['subCate_name'],
      };
      return map;
    }
  }

  Future getGeneralCate() async {
    Uri _url = Uri.parse('$baseUrl/categories/main');
    http.Response res = await http.get(_url);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return decodedBody.map((e) => GeneralCate.fromJson(e)).toList();
    }
  }

  Future getSuperCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/super/$id');
    http.Response res = await http.get(_url);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return decodedBody.map((e) => SuperCate.fromMap(e)).toList();
    }
  }

  Future getSubCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/sub/$id');
    http.Response res = await http.get(_url);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(decodedBody);
      return decodedBody.map((e) => SubCate.fromJson(e)).toList();
    }
  }

  Future addCategory(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories');
    http.Response res = await http.post(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      int id = decodedBody['data']['insertId'];
      return id;
    } else {
      return 0;
    }
  }

  Future uploadNewCate(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories/create');
    final b = jsonEncode(body);
    http.Response res = await http
        .post(_url, body: b, headers: {"Content-Type": "application/json"});
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future updateSuperCategories(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories/super');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  updateGeneralCate(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories/general');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  updateSubCategories(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories/sub');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  updateProductCate(int id, var body) async {
    Uri _url = Uri.parse('$baseUrl/categories/$id');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  addNewNode(Map body) async {
    Uri _url = Uri.parse('$baseUrl/categories/AddNode');
    print(body);
    http.Response res = await http.post(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  deleteGeneralCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/$id');
    http.Response res = await http.delete(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  deleteSuperCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/super/$id');
    http.Response res = await http.delete(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  deleteSubCate(int id) async {
    Uri _url = Uri.parse('$baseUrl/categories/sub/$id');
    http.Response res = await http.delete(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future getAllSuperCate() async {
    Uri _url = Uri.parse('$baseUrl/categories/super');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      return data.map((e) => SuperCate.fromMap(e)).toList();
    } else {
      return 0;
    }
  }
}
