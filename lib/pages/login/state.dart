import 'package:flutter/material.dart';

class LoginState {

  late TextEditingController unameController;
  late TextEditingController pwdController;
  late bool pwdShow;
  late GlobalKey formKey;
  late bool nameAutoFocus;

  LoginState() {
    ///Initialize variables
    unameController = new TextEditingController();
    pwdController = new TextEditingController();
    pwdShow = false; //密码是否显示明文
    formKey = new GlobalKey<FormState>();
    nameAutoFocus = true;
  }
}
