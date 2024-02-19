import 'package:flutter/material.dart';
import 'package:jmcare/model/BaseRespon.dart';


class RegisterDebiturState{

  GlobalKey<FormState>? formKey;
  TextEditingController? ktpController;
  TextEditingController? hpController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? ulangipasswordController;
  BaseRespon? baseRespon;

  RegisterDebiturState(){
    formKey = GlobalKey<FormState>();
    ktpController = TextEditingController();
    hpController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    ulangipasswordController = TextEditingController();
    baseRespon = BaseBegin();
  }
}
