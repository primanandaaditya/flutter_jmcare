
import 'dart:async';
import 'package:flutter/material.dart';

class VerifikasiotpState{

  TextEditingController? tecOTP;
  String email = "";
  String hp = "";
  Timer? countdownTimer;

  VerifikasiotpState(){
    tecOTP = TextEditingController();
  }
}
