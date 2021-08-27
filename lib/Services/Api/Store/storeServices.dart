import 'dart:convert';
import 'dart:typed_data';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/passwordGenerator.dart';
import 'package:admin_panal/Model/storeModel.dart';
import 'package:http/http.dart' as http;

class StoreServices {
  Future getStores() async {
    List<StoreModel> storelist = [];
    Uri _url = Uri.parse('$baseUrl/stores');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      List data = decodedBody['data'];
      for (var info in data) {
        String imgName = info['logo'];
        String imgUri = '$baseUrl/stores/logo/$imgName';
        var store = StoreModel.fromJson(info, imgUri);
        storelist.add(store);
      }
      return storelist;
    }
  }

  Future countStores() async {
    Uri _url = Uri.parse('$baseUrl/stores/count');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      var count = decodedBody['totalStores'];
      return count;
    }
  }

  Future uploadLogoFirst(Uint8List imagefile) async {
    Uri _url = Uri.parse('$baseUrl/stores/upload');
    String filename = generatePassword(isSpecial: false);
    var req = http.MultipartRequest('POST', _url);
    req.files.add(
      http.MultipartFile.fromBytes('file', imagefile,
          filename: '$filename.jpg'),
    );
    var res = await req.send();
    var respStr = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return respStr;
    } else
      return 0;
  }

  Future addNewStores(Map<String, dynamic> inputdata) async {
    Uri _url = Uri.parse('$baseUrl/stores/');
    http.Response res = await http.post(_url, body: inputdata);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      return 1;
    } else
      return 0;
  }

  Future removeStore(int id, String pass) async {
    Uri _url = Uri.parse('$baseUrl/stores/$id');
    Map body = {"password": pass, "email": "asfandyr380@gmail.com"};
    http.Response res = await http.delete(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      return 1;
    } else
      return 0;
  }

  Future updateStatus(int id, int status) async {
    Uri _url = Uri.parse('$baseUrl/stores/$id/$status');
    http.Response res = await http.put(_url);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      return 1;
    } else
      return 0;
  }

  Future updateStore(int id, Map body) async {
    Uri _url = Uri.parse('$baseUrl/stores/$id');
    http.Response res = await http.put(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      return 1;
    } else
      return 0;
  }

  searchStore(String key) async {
    List<StoreModel> storelist = [];
    Uri _url = Uri.parse('$baseUrl/stores/search/$key');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    if (decodedBody['success'] == 1 && res.statusCode == 200) {
      List data = decodedBody['data'];
      for (var info in data) {
        String imgName = info['logo'];
        String imgUri = '$baseUrl/stores/logo/$imgName';
        var store = StoreModel.fromJson(info, imgUri);
        storelist.add(store);
      }
      return storelist;
    } else
      return 0;
  }
}
