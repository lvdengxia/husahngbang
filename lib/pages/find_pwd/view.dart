import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logic.dart';
import 'state.dart';

class FindPwdPage extends StatelessWidget {
  final FindPwdLogic logic = Get.put(FindPwdLogic());
  final FindPwdState state = Get.find<FindPwdLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('找回密码'),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: state.formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: state.newPwdController,
                    decoration: InputDecoration(
                      labelText: '新密码',
                      hintText: '设置新密码',
                      // prefixIcon: Icon(Icons.person),
                    ),
                    textInputAction: TextInputAction.next),
                TextFormField(
                    controller: state.rePwdController,
                    decoration: InputDecoration(
                      labelText: '重复密码',
                      hintText: '重复新密码',
                      // prefixIcon: Icon(Icons.lock),
                    ),
                    textInputAction: TextInputAction.next),
                TextFormField(
                  controller: state.phoneController,
                  decoration: InputDecoration(
                    labelText: '手机号',
                    hintText: '请输入手机号',
                    // prefixIcon: Icon(Icons.lock),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    // 校验密码（不能为空）
                    // return v.trim().isNotEmpty ? null : gm.passwordRequired;
                  },
                ),
                TextFormField(
                  controller: state.verifyCodeController,
                  decoration: InputDecoration(
                    labelText: '验证码',
                    hintText: '请输入验证码',
                    suffixIcon: GetBuilder<FindPwdLogic>(
                      builder: (logic) {
                        return state.btnEnable ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              textStyle: TextStyle(color: Colors.white, fontSize: 14)),
                          onPressed: logic.sendMsg,
                          child: Text(state.btnText),
                        ) : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              textStyle: TextStyle(color: Colors.white, fontSize: 14)),
                          onPressed: null, child: Text(state.btnText));
                      },
                    ),
                    // prefixIcon: Icon(Icons.lock),
                  ),
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (v) {
                    logic.onSubmit();
                  },
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      onPressed: logic.onSubmit,
                      child: Text('提  交'),
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
