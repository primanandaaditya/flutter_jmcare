
import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:flutter/material.dart';
import 'BaseService.dart';

class DeleteakunService extends BaseService{

  static DeleteakunService instance = DeleteakunService();

  Future<BaseRespon?> deleteAkun(String userID) async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return postJSON(Endpoint.TAG_DELETE_AKUN, body: {
        "id":userID
      });
    }catch(e){
      debugPrint('Error delete akun $e');
      return BaseError();
    }
  }
}
