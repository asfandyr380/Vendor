import 'dart:convert';
import 'dart:typed_data';

import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/passwordGenerator.dart';
import 'package:admin_panal/Model/attributeModel.dart';
import 'package:http/http.dart' as http;

class AttributeService {
  Future addAttribute(Map map, int id, String image) async {
    Uri _url = Uri.parse('$baseUrl/products/addAttribute');
    Map<String, dynamic> body = {
      'stock': map['stock'],
      'variant': map['variant'],
      'price': map['price'],
      'image': image,
      'productId': id.toString(),
      "salePrice": "0",
    };

    http.Response res = await http.post(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future uploadImage(Uint8List file) async {
    Uri _url = Uri.parse('$baseUrl/products/addAttribute/upload');
    var req = http.MultipartRequest('POST', _url);

    String randomName = generatePassword(isSpecial: false);
    req.files.add(
      http.MultipartFile.fromBytes('file', file, filename: '$randomName.jpg'),
    );

    var res = await req.send();
    http.Response respStr = await http.Response.fromStream(res);
    if (res.statusCode == 200) {
      var decodedBody = jsonDecode(respStr.body);
      return decodedBody;
    } else
      return 0;
  }

  Future getAttribute(int id) async {
    List<AttributeModel> attributeList = [];
    Uri _url = Uri.parse('$baseUrl/products/getAttribute/$id');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      List data = decodedBody['data'];
      for (var attribute in data) {
        String img = attribute['image'];
        String imgUrl = "$baseUrl/products/getimg/$img";
        var att = AttributeModel.fromJson(
          attribute['stock'],
          attribute['variant'],
          attribute['price'],
          id: attribute['attribute_Id'],
          img: imgUrl,
        );
        attributeList.add(att);
      }
      return attributeList;
    } else {
      return 0;
    }
  }
}
