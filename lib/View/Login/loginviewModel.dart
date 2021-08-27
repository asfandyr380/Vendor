import 'package:admin_panal/Config/locator.dart';
import 'package:admin_panal/Services/Api/Auth/AuthServices.dart';
import 'package:admin_panal/Services/Navigation/navigation_services.dart';
import 'package:admin_panal/View/AdminConsole/adminConsoleView.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  AuthServices _authServices = locator<AuthServices>();
  Navigation _navigation = locator<Navigation>();
  String email = '';
  String pass = '';
  AutovalidateMode mode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  isBusy(bool state) {
    isLoading = state;
    notifyListeners();
  }

  validateInputs() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return 1;
    } else {
      mode = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Password';
    } else if (value.length < 6) {
      return 'Password Can\'t be less Then 6 Characters';
    }
  }

  validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  loginUser() async {
    isBusy(true);
    var result = await _authServices.login(email, pass);
    if (result == 1) {
      _navigation.pushReplaceRoute(AdminConsoleView());
    } else {
      print(result);
    }
    isBusy(false);
  }
}
