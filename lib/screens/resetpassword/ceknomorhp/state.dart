import 'package:flutter/material.dart';

class CeknomorhpState{

  TextEditingController? tecNomorHP;
  GlobalKey<FormState>? formKey;

  CeknomorhpState(){
    tecNomorHP = TextEditingController();
    formKey = GlobalKey<FormState>();
  }
}
