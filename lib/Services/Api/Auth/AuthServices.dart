import 'dart:convert';
import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  StorageServices _storageServices = locator<StorageServices>();

  Future login(String email, String pass) async {
    Map<String, dynamic> body = {'email': email, 'password': pass};
    Uri _url = Uri.parse('$baseUrl/stores/login');
    http.Response res = await http.post(_url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      var data = decodedBody['data'];
      String email = data['email'];
      String img = data['logo'];
      String imgUrl = "$baseUrl/stores/logo/$img";
      int id = data['store_Id'];
      await _storageServices.saveUser(email, id);
      await _storageServices.saveImg(imgUrl);
      return 1;
    } else
      return 0;
  }
}
