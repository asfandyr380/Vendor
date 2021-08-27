import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Services/Api/SharedPreference/Storage_Services.dart';
import 'package:flutter/material.dart';

class RootViewModel extends ChangeNotifier {
  StorageServices _storageServices = locator<StorageServices>();
  bool authState = false;
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  checkAuthState() async {
    isBusy(true);
    bool result = await _storageServices.getUser();
    authState = result;
    notifyListeners();
    isBusy(false);
  }
}
