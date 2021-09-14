import 'dart:convert';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Config/passwordGenerator.dart';
import 'package:admin_panal/Model/attributeModel.dart';
import 'package:admin_panal/Model/productModel.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:http/http.dart' as http;

StorageServices _storageServices = locator<StorageServices>();

class ProductServices {
  Future addProduct(Map body) async {
    Uri _url = Uri.parse('$baseUrl/products');
    http.Response res = await http.post(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      int id = decodedBody['data']['insertId'];
      return id;
    } else {
      return 0;
    }
  }

  Future uploadImages(List files) async {
    Uri _url = Uri.parse('$baseUrl/products/upload');
    var req = http.MultipartRequest('POST', _url);
    for (var file in files) {
      String randomName = generatePassword(isSpecial: false);
      req.files.add(
        http.MultipartFile.fromBytes('files', file,
            filename: '$randomName.jpg'),
      );
    }

    var res = await req.send();
    http.Response respStr = await http.Response.fromStream(res);
    if (res.statusCode == 200) {
      List decodedBody = jsonDecode(respStr.body);
      return decodedBody;
    } else
      return 0;
  }

  getTotalProducts(int id) async {
    Uri _url = Uri.parse('$baseUrl/products/storeCount/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      int total = decodedBody['count']['total'];
      return total;
    } else {
      return 0;
    }
  }

  Future getAllProducts() async {
    List<String> images = [];
    List<String> rawPath = [];
    List<ProductModel1> products = [];

    Uri _url = Uri.parse('$baseUrl/products');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var product in data) {
        String imgPath = product['image'];
        rawPath.add(imgPath);
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          if (product['image$i'] != "") {
            String imgPath = product['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
            rawPath.add(imgPath);
          }
        }
        var pro = ProductModel1.fromJson(product, images, rawPath);
        products.add(pro);
        images = [];
        rawPath = [];
      }
      return products;
    } else {
      return 0;
    }
  }

  Future getProducts(int id) async {
    List<String> images = [];
    List<String> rawPath = [];
    List<ProductModel1> products = [];

    Uri _url = Uri.parse('$baseUrl/products/storeProducts/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var product in data) {
        String imgPath = product['image'];
        rawPath.add(imgPath);
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          if (product['image$i'] != "") {
            String imgPath = product['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
            rawPath.add(imgPath);
          }
        }
        var pro = ProductModel1.fromJson(product, images, rawPath);
        products.add(pro);
        images = [];
        rawPath = [];
      }
      return products;
    } else {
      return 0;
    }
  }

  Future removeProduct(int id, String pass) async {
    String userEmail = await _storageServices.getUserEmail();
    Map map = {'email': userEmail, 'password': pass};
    Uri _url = Uri.parse('$baseUrl/products/store/$id');
    http.Response res = await http.delete(_url, body: map);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future updateProduct(int id, Map body) async {
    Uri _url = Uri.parse('$baseUrl/products/$id');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  filterProductsByName(String key, int id) async {
    List<String> images = [];
    List<String> rawPath = [];

    List<ProductModel1> products = [];
    Uri _url = Uri.parse('$baseUrl/products/store/searchAll/$key/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var product in data) {
        String imgPath = product['image'];
        rawPath.add(imgPath);
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          if (product['image$i'] != "") {
            String imgPath = product['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
            rawPath.add(imgPath);
          }
        }
        var pro = ProductModel1.fromJson(product, images, rawPath);
        products.add(pro);
        images = [];
        rawPath = [];
      }
      return products;
    } else {
      return 0;
    }
  }

  filterProductByStore(String key) async {
    List<String> images = [];
    List<String> rawPath = [];
    List<ProductModel1> products = [];
    Uri _url = Uri.parse('$baseUrl/products/searchAllByStore/$key');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var product in data) {
        String imgPath = product['image'];
        rawPath.add(imgPath);
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          if (product['image$i'] != "") {
            String imgPath = product['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
            rawPath.add(imgPath);
          }
        }
        var pro = ProductModel1.fromJson(product, images, rawPath);
        products.add(pro);
        images = [];
        rawPath = [];
      }
      return products;
    } else {
      return 0;
    }
  }

  filterByCate(String key, int id) async {
    List<String> images = [];
    List<String> rawPath = [];
    List<ProductModel1> products = [];
    Uri _url = Uri.parse('$baseUrl/products/store/searchAllByCate/$key/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var product in data) {
        String imgPath = product['image'];
        rawPath.add(imgPath);
        String image = '$baseUrl/products/getimage/$imgPath';
        images.add(image);
        for (int i = 2; i <= 4; i++) {
          if (product['image$i'] != "") {
            String imgPath = product['image$i'];
            String image = '$baseUrl/products/getimage/$imgPath';
            images.add(image);
            rawPath.add(imgPath);
          }
        }
        var pro = ProductModel1.fromJson(product, images, rawPath);
        products.add(pro);
        images = [];
        rawPath = [];
      }
      return products;
    } else {
      return 0;
    }
  }
}
