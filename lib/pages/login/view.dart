import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class LoginPage extends StatelessWidget {
  final LoginLogic logic = Get.put(LoginLogic());
  final LoginState state = Get.find<LoginLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: state.formKey,
            // autovalidate: true,
            child: Column(
              children: <Widget>[
                Image.asset(
                  "asset/images/icon-ios.png",
                  width: double.infinity,
                  height: 100,
                ),
                TextFormField(
                    autofocus: state.nameAutoFocus,
                    controller: state.unameController,
                    decoration: InputDecoration(
                      labelText: '账号',
                      hintText: '请输入手机号',
                      prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.next),
                GetBuilder<LoginLogic>(
                  builder: (logic) {
                    return TextFormField(
                      controller: state.pwdController,
                      autofocus: !state.nameAutoFocus,
                      decoration: InputDecoration(
                          labelText: '密码',
                          hintText: '请输入密码',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(state.pwdShow
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              logic.switchShowPwd();
                            },
                          )),
                      obscureText: !state.pwdShow,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (v) {
                        logic.sendLoginData;
                      },
                    );
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      '忘记密码',
                      style: TextStyle(color: Color(0x9CA5A5A9)),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('find_pwd');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      onPressed: logic.sendLoginData,
                      child: Text('登 录'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
