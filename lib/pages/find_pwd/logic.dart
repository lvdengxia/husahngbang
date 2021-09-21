import 'dart:async';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'state.dart';

class FindPwdLogic extends GetxController {
  final state = FindPwdState();

  /// 发送验证码
  void sendMsg() async {
    /// 验证字段
    if(state.phoneController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '手机号不能为空');
      return;
    }
    /// 调用接口
    var sendVerifyCode = await ApiService.getVerifyCode(state.phoneController.text);
    if(sendVerifyCode['code'] != 200){
      Get.defaultDialog(title: '错误', middleText: sendVerifyCode['msg']);
      return;
    }
    /// 重置按钮文本
    int timeTotal = 61;
    int currentTime = timeTotal;
    state.btnEnable = false;

    /// 按钮置灰
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == timeTotal) {
        //倒计完当前时间重新等于总时间
        currentTime = timeTotal;
        state.btnEnable = true;
        timer.cancel();
        state.btnText = '获取短信';
      } else {
        currentTime--;
        state.btnText = currentTime.toString() + '秒后再次获取';
      }
      update();
    });
  }

  /// 提交表单
  void onSubmit() async {
    /// 验证字段
    if(state.newPwdController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '新密码不能为空');
      return;
    }
    if(state.rePwdController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '确认密码不能为空');
      return;
    }
    if(state.phoneController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '手机号不能为空');
      return;
    }
    if(state.verifyCodeController.text == ''){
      Get.defaultDialog(title: '错误', middleText: '验证码不能为空');
      return;
    }
    if(state.newPwdController.text != state.rePwdController.text){
      Get.defaultDialog(title: '错误', middleText: '两次输入的密码不一致');
      return;
    }
    /// 发送请求
    var findPwd = await ApiService.sendPwdData(
        state.newPwdController.text,
        state.rePwdController.text,
        state.phoneController.text,
        state.verifyCodeController.text);
    print(findPwd);
    if (findPwd['code'] == 200) {
      Get.defaultDialog(title: findPwd['msg'], middleText: '这里写文字或者定义Icon');
      Future.delayed(Duration(seconds: 2), () {
        Get.offNamed('/login');
      });
    } else {
      Get.defaultDialog(title: findPwd['msg'], middleText: '这里写文字或者定义Icon');
    }
  }
}
