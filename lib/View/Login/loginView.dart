import 'package:admin_panal/Config/Const.dart';
import 'package:admin_panal/Config/sizeconfig.dart';
import 'package:admin_panal/View/Login/loginviewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: Form(
          key: model.formKey,
          autovalidateMode: model.mode,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: SizeConfig.blockSizeVertical * 15,
                  width: SizeConfig.blockSizeHorizontal * 10,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 9,
              ),
              Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              TextInputField(
                hint: 'Enter Your Email',
                label: 'Email address',
                onChange: (val) => {model.email = val},
                validate: (val) => model.validateEmail(val),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1,
              ),
              TextInputField(
                hint: 'Enter Your Password',
                label: 'Password',
                onChange: (val) => {model.pass = val},
                validate: (val) => model.validatePassword(val),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2.5,
              ),
              ElevatedButton(
                onPressed: () {
                  var result = model.validateInputs();
                  if (result == 1) {
                    model.loginUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: accentColor,
                  fixedSize: Size(
                    SizeConfig.blockSizeHorizontal * 24,
                    SizeConfig.blockSizeVertical * 5,
                  ),
                ),
                child: model.isLoading
                    ? Container(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 1.2),
                      ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(bottom: 10, left: 10),
                child: Text('©️ 2021 Family Supermart Limited'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  final String? hint;
  final String? label;
  final Function(String)? onChange;
  final Function(String)? validate;
  const TextInputField({this.hint, this.label, this.onChange, this.validate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 1,
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 24,
          child: TextFormField(
            onChanged: (val) => onChange!(val),
            validator: (val) => validate!(val!),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: accentColor),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: accentColor),
                borderRadius: BorderRadius.circular(6),
              ),
              hintText: '$label',
            ),
          ),
        ),
      ],
    );
  }
}
