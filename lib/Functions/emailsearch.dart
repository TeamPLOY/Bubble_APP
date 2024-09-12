    
    
import 'package:flutter/material.dart';

class Emailsearch {
  List<bool> isState=[false,false];
  TextEditingController emailController = TextEditingController();
  TextEditingController comController = TextEditingController();

  Emailsearch({required this.emailController,required this.comController});
  List<bool> checkForm(){
    if(emailController.text.isEmpty){
      isState[0]=true;
    }
    if(comController.text.isEmpty){
      isState[1]=true;
    }
    return isState;
  }
}