import 'package:flutter/material.dart';

class Deletesearch {
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Deletesearch({
    required this.passwordController,
    required this.repasswordController,
    required this.emailController,
  });

  List<bool> isState = [false, false, false];

  bool containsKorean(String text) {
    RegExp koreanRegex = RegExp(r'[\uac00-\ud7af]');
    return koreanRegex.hasMatch(text);
  }

  List<bool> checkForm() {
    // 패스워드 검증
    if (passwordController.text.isEmpty || 
        passwordController.text.length <= 3 || 
        containsKorean(passwordController.text)) {
      isState[0] = true;
    } else {
      isState[0] = false;
    }

    // 패스워드 재입력 확인
    if (passwordController.text != repasswordController.text) {
      isState[1] = true;
    } else {
      isState[1] = false;
    }

    // 이메일 입력 확인
    if (emailController.text.isEmpty) {
      isState[2] = true;
    } else {
      isState[2] = false;
    }

    return isState;
  }
}
