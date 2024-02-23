import 'package:flutter/material.dart';

import '../../model/api/LoginRespon.dart';

class LoginState{

  GlobalKey<FormState>? formKey;
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  LoginRespon? loginrespon;

  LoginState(){
    formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    loginrespon = LoginBegin();
  }
}
