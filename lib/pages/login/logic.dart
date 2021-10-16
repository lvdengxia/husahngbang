import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  ///显示/隐藏密码
  void switchShowPwd() {
    state.pwdShow = !state.pwdShow;
    update();
  }

  /// 发送登录请求
  void sendLoginData() async {
    /// 校验账号和密码
    if(state.pwdController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '密码不能为空');
      return;
    }
    if(state.unameController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '用户名不能为空');
      return;
    }
    var login = await ApiService.sendLoginData(state.unameController.text,state.pwdController.text);
    if(login['code'] == '200'){
      /// 保存登录状态
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token',login['data']['token']);
      prefs.setString('account',state.unameController.text);
      prefs.setString('pwd',state.pwdController.text);
      Get.offNamed('/');
    }else{
      Get.defaultDialog(title: login['msg'],middleText:'这里写文字或者定义Icon');
    }
  }
}
