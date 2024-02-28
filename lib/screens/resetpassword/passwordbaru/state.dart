import 'package:flutter/material.dart';

class PasswordbaruState{

  GlobalKey<FormState>? formKey;
  TextEditingController? tecPassword;
  TextEditingController? tecUlangpassword;

  PasswordbaruState(){
    formKey = GlobalKey<FormState>();
    tecPassword = TextEditingController();
    tecUlangpassword = TextEditingController();
  }
}