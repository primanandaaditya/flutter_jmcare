import 'package:flutter/material.dart';
import 'package:jmcare/model/sqlite/DatabaseHelper.dart';

import '../../model/sqlite/entity/Epolis.dart';

class PilihkontrakState{

  TextEditingController? tecSearch;
  String? rute; //agreement card atau epolis
  DatabaseHelper? databaseHelper;
  int jmlEpolis =0;
  Epolis? epolis;

  PilihkontrakState(){
    tecSearch = TextEditingController();
    databaseHelper = DatabaseHelper();
  }
}