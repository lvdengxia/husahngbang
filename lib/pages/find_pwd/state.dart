import 'package:flutter/material.dart';

class FindPwdState {

  late TextEditingController newPwdController;
  late TextEditingController rePwdController;
  late TextEditingController phoneController;
  late TextEditingController verifyCodeController;
  late GlobalKey formKey;
  late String  btnText;
  late bool btnEnable;  /// 按钮状态

  FindPwdState() {
    newPwdController = new TextEditingController();
    rePwdController = new TextEditingController();
    phoneController = new TextEditingController();
    verifyCodeController = new TextEditingController();
    formKey = new GlobalKey<FormState>();
    btnText = '获取短信';
    btnEnable = true;
  }
}
