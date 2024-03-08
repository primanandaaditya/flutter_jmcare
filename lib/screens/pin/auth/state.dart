import 'dart:async';
import 'package:flutter/material.dart';

class AuthpinState{

  TextEditingController? tecPIN;
  Timer? countdownTimer;

  AuthpinState(){
    tecPIN = TextEditingController();
  }
}