import 'package:flutter/material.dart';

class Formsearch {
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();


  Formsearch({required this.passwordController,required this.repasswordController,required this.nameController,required this.roomController,});
  List<bool> isState=[false,false,false,false];
  // password의 에러 , name의 오류, room의 오류, password와 repasswrod의 일치 여부,email
  bool containsKorean(String text) {
    RegExp koreanRegex = RegExp(r'[\uac00-\ud7af]'); // 한글 범위의 유니코드
    return koreanRegex.hasMatch(text);
  }

  bool checkSpecialCharacter(String text) {
    RegExp regex = RegExp(r'[!@#\$&*~]');
    return regex.hasMatch(text);
  }

  bool isRoomNumberValid(String text) {
    RegExp regex = RegExp(r'^\d{3}$');
    return regex.hasMatch(text);
  }

  bool isNumericOnly(String text) {
    RegExp numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(text);
  }

  List<bool> checkForm(){
    if (passwordController.text.isNotEmpty) {
      if(passwordController.text.length >= 5){
        if(checkSpecialCharacter(passwordController.text)){
          if(!containsKorean(passwordController.text)){
            print('완료');
            isState[0] = false;
          }
          else {
            isState[0] = true;
          }
        }
        else {
          isState[0] = true;
        }
      }
      else {
        isState[0] = true;
      }
    }
    else {
      isState[0] = true;
    }

    if(passwordController.text.isEmpty){
      isState[0]=true;
    }
    else if(passwordController.text.length<=5){
      isState[0]=true;
    }

    if(nameController.text.isEmpty || nameController.text.length>5){
      isState[1]=true;
    }

    if(roomController.text.isEmpty){
      isState[1]=true;
    }

    if(roomController.text.length==3){
      if(isNumericOnly(roomController.text)){
        isState[2]=false;
      }
      else{
        isState[2]=true;
      }
    }
    else{
      isState[2]=true;
    }

    if(passwordController.text==repasswordController.text){
      isState[3]=false;
    }
    else{
      isState[3]=true;
    }

    // if(bufferController.text.isEmpty){
    //   isState[6]=true;
    // }
    return isState;
  }
}

