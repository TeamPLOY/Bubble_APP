import 'package:flutter/material.dart';

class Formsearch {
  TextEditingController passwordController;
  TextEditingController repasswordController;
  TextEditingController nameController;
  TextEditingController roomController;

  Formsearch({
    required this.passwordController,
    required this.repasswordController,
    required this.nameController,
    required this.roomController,
  });

  // Validation states: password, name, room, repassword, special character
  List<bool> isState = [false, false, false, false, false];

  // Utility methods for validation
  bool containsKorean(String text) {
    return RegExp(r'[\uac00-\ud7af]').hasMatch(text);
  }

  bool containsSpecialCharacter(String text) {
    return RegExp(r'[!@#\$&*~]').hasMatch(text);
  }

  bool isRoomNumberValid(String text) {
    return RegExp(r'^\d{3}$').hasMatch(text);
  }

  bool isNumericOnly(String text) {
    return RegExp(r'^[0-9]+$').hasMatch(text);
  }

  // Validation methods for each field
  bool validatePassword(String password) {
    if (password.isEmpty) return false;
    if (password.length < 5) return false;
    if (containsKorean(password)) return false;
    return true;
  }

  bool validateName(String name) {
    return name.isNotEmpty && name.length <= 5;
  }

  bool validateRoom(String room) {
    return isRoomNumberValid(room);
  }

  bool validateRepassword(String password, String repassword) {
    return password == repassword;
  }

  // Comprehensive form validation
  List<bool> checkForm() {
    String password = passwordController.text;
    String repassword = repasswordController.text;
    String name = nameController.text;
    String room = roomController.text;

    isState[0] = !validatePassword(password); // Password validity
    isState[1] = !validateName(name);        // Name validity
    isState[2] = !validateRoom(room);        // Room validity
    isState[3] = !validateRepassword(password, repassword); // Repassword match
    isState[4] = !containsSpecialCharacter(password); // True if no special character

    return isState;
  }
}
