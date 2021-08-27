class MessagesModel {
  int id = 0;
  String name = '';
  String email = '';
  String phone = '';
  String message = '';
  bool isExpaned = false;
  int seen = 0;

  MessagesModel.fromJson(Map map)
      : id = map['Id'],
        name = map['name'],
        email = map['email'],
        phone = map['phone'],
        message = map['message'],
        isExpaned = false,
        seen = map['seen'];
}
