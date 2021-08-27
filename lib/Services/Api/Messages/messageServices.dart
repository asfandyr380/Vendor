import 'dart:convert';

import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Model/messagesModel.dart';
import 'package:http/http.dart' as http;

class MessageServices {
  Future getCount() async {
    Uri _url = Uri.parse('$baseUrl/message/count');
    http.Response res = await http.get(_url);
    var decodedBody = jsonDecode(res.body);
    print(decodedBody);
    if (res.statusCode == 200) {
      var count = decodedBody['totalMsg'];
      return count;
    }
  }

  Future getMessages() async {
    Uri _url = Uri.parse('$baseUrl/message');
    http.Response res = await http.get(_url);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return decodedBody.map((e) => MessagesModel.fromJson(e)).toList();
    }
  }

  updateSeen(int id) async {
    Uri _url = Uri.parse('$baseUrl/message/$id');
    http.Response res = await http.put(_url);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1)
      return 1;
    else
      return 0;
  }
}
