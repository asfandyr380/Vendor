import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:flutter/material.dart';

class HeaderViewModel extends ChangeNotifier {
  StorageServices _storageServices = locator<StorageServices>();
  String img = '';
  signout() async {
    _storageServices.deleteUser();
  }

  getStoreLogo() async {
    var result = await _storageServices.getImg();
    if (result != null) {
      img = result;
    }
  }
}
