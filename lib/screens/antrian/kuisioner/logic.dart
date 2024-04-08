import 'dart:ffi';

import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/ChoicechipModel.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PertanyaanRespon.dart' as pertanyaan;
import 'package:jmcare/screens/antrian/kuisioner/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/CekkuisionerService.dart';
import 'package:jmcare/service/PertanyaanService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/storage/storage.dart';
import 'package:flutter/material.dart';

import '../../../model/api/PertanyaanRespon.dart';


class KuisionerLogic extends BaseLogic {

  final KuisionerState state = KuisionerState();
  var obxPertanyaan = PertanyaanRespon().obs;
  var load_cek_kuisioner = false.obs;
  var load_get_kuisioner = false.obs;
  var choiceModels = List<ChoicechipModel>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    //get argumen id antrian yang dilempar dari screen detailriwayat antrian
    state.id_antrian = Get.arguments[Konstan.tag_id_antrian];
    //hit api untuk cek apakah kuisioner ini sudah dikerjakan apa belum
    cekKuisioner();
  }

  void clickChoiceChipSingle(String idOPSI, String pertanyaanCode){
    String hasil = ";";

    //looping pertama buat nge-set bool value pada model ybs
    for (var e in choiceModels) {
      if (e.id == idOPSI){
        e.selected = !e.selected!;
      }
    }

    //looping kedua untuk mengumpulkan nilai choice yang diklik apa saja
    for (var e in choiceModels) {
      if (e.pertanyaanCode == pertanyaanCode){
        if (e.selected == true){
          hasil += ";" + e.valueJawaban!.trim();
        }
      }
    }

    if (hasil.isEmpty || hasil.length == 1){
      hasil = "";
    }else{
      hasil = hasil.substring(2);
    }
    debugPrint(hasil);
    state.hashSemua![pertanyaanCode] = hasil;

    //refresh di ui-nya
   update();
  }
  void handleTextField(String pertanyaanCode, String newValue){
    debugPrint("newValue " + newValue);
    state.hashSemua![pertanyaanCode] = newValue;
    debugPrint("nilai last " + state.hashSemua![pertanyaanCode]!);
  }

  // Widget renderPertanyaan(){
  //   final respon = obxPertanyaan.value.data;
  //   return  ListView.separated(
  //     padding: const EdgeInsets.all(0),
  //     separatorBuilder: (context, index){
  //       return const Divider(
  //         color: Colors.grey,
  //       );
  //     },
  //     itemBuilder: (context, index){
  //
  //       return Card(
  //         child: Container(
  //           padding: const EdgeInsets.all(10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(respon[index].pertanyaan!.pERTANYAAN!),
  //
  //               respon[index].pertanyaan!.iDFORMAT == "1" || respon[index].pertanyaan!.iDFORMAT == "2"
  //                   ? respon[index].subPertanyaan.isNull //baris 379
  //                       ? Builder(builder: (context){
  //                         state.hashSemua![respon[index].pertanyaan!.pERTANYAANCODE!] = '';
  //                           return TextField(
  //                             onChanged: (s){
  //                               handleTextField(respon[index].pertanyaan!.pERTANYAANCODE!, s);
  //                             },
  //                           );
  //                         })
  //                       :  Column(
  //                           children: [
  //                               Builder(builder: (context){
  //                                   for (var i in respon[index].subPertanyaan!){
  //                                     //simpan jawaban kalau user mengetik
  //                                     //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
  //                                     //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
  //                                     state.hashSemua![respon[index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!] = "";
  //                                     return Column(
  //                                       children: [
  //                                         Text(i.labelPertanyaan!.vALUE!),
  //                                         TextField(
  //                                           onChanged: (s){
  //                                             handleTextField(respon[index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!, s);
  //                                           },
  //                                         )
  //                                       ],
  //                                     );
  //                                   }
  //                                   return Container();
  //                             })
  //                           ],
  //                         )
  //                   : Container(),
  //
  //               respon[index].pertanyaan!.iDFORMAT == "3" //baris 460
  //                   ? respon[index].subPertanyaan == null //baris 462
  //                     ? Container()                       //baris 463 (kosong if else-nya)
  //                     : (respon[index].subPertanyaan!.length == 1 && respon[index].subPertanyaan![0].labelPertanyaan == null ) //baris 466
  //                       ? //baris 467
  //                         (respon[index].subPertanyaan![0].templateJawaban == null)
  //                         ? Container()
  //                         : // baris 470
  //                         Builder(builder: (context){
  //                           state.hashSemua![respon[index].pertanyaan!.pERTANYAANCODE!] = "";
  //                           for ( var i in respon[index].subPertanyaan![0].templateJawaban! ){
  //                             choiceModels.add(ChoicechipModel(id: i.iDOPSI!, selected: false));
  //                           }
  //
  //                             return Wrap(
  //                                 spacing: 5.0,
  //                                 children: [
  //                                   for ( var i in respon[index].subPertanyaan![0].templateJawaban! )
  //                                     ChoiceChip(
  //                                         label: Text(i.vALUEJAWABAN!),
  //                                         selected: choiceModels.where((e) => e.id == i.iDOPSI!).first.selected!,
  //                                         onSelected: (newValue){
  //                                           clickChoiceChip(i.iDOPSI!);
  //                                         }
  //                                     )
  //                                 ],
  //                               );
  //                         })
  //                       : //baris 520
  //                         respon[index].subPertanyaan == null
  //                             ? Container()
  //                             : Column(
  //                                 children: [
  //                                   for ( var i in respon[index].subPertanyaan! )
  //                                     Wrap(
  //                                       spacing: 5.0,
  //                                       children: [
  //                                         for ( var j in i.templateJawaban! )
  //                                           ChoiceChip(
  //                                               label: Text(j.vALUEJAWABAN!),
  //                                               selected: false
  //                                           )
  //                                       ],
  //                                     )
  //                                 ],
  //                               )
  //                   : Container(),
  //
  //               respon[index].pertanyaan!.iDFORMAT == "4"
  //                   ? Text("Radio group")
  //                   : Container(),
  //
  //               respon[index].pertanyaan!.iDFORMAT == "5"
  //                   ? Text("Range slider")
  //                   : Container(),
  //
  //               respon[index].pertanyaan!.iDFORMAT == "6"
  //                   ? Text("Switch")
  //                   : Container(),
  //
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //     itemCount: respon!.length,
  //   );
  // }

  void getPertanyaan() async {
    load_get_kuisioner.value = true;
    final pertanyaanRespon = await getService<PertanyaanService>()?.getPertanyaan();


    if (pertanyaanRespon is PertanyaanError){
      Fungsi.errorToast("Tidak dapat memproses data kuisioner");
    }else{
      obxPertanyaan.value = pertanyaanRespon!;

      //semua looping dibawah ini nggak bisa dilakuin di view
      //karena semua pakai ternary
      //jadi dilakuin di logicnya, untuk setiap view model
      obxPertanyaan.value.data!.forEach((a) {

        //untuk setiap pertanyaan Checklist atau Choicechip
        //=================================================
        //=================================================
        if (a.pertanyaan!.iDFORMAT == "3"){
          //looping untuk penambahan hashSemua
          if (a.subPertanyaan == null){

          }else{
            if (a.subPertanyaan!.length == 1 && a.subPertanyaan![0].labelPertanyaan == null){
              if (a.subPertanyaan![0].templateJawaban == null){

              }else{
                state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = "-";
              }
            }else{
              a.subPertanyaan!.forEach((sub) {
                state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "";
              });
            }
          }

          for (var i in a.subPertanyaan!){
            for (var j in i.templateJawaban!){
              //tambahkan view model
              choiceModels.add(
                  ChoicechipModel(
                      id: j.iDOPSI,
                      pertanyaanCode: a.pertanyaan!.pERTANYAANCODE!,
                      valueJawaban: j.vALUEJAWABAN,
                      selected: false
                  )
              );
            }
          }
        }
      });
    }
    load_get_kuisioner.value = false;
  }

  void cekKuisioner() async {
    load_cek_kuisioner.value = true;
    final authStorage = await getStorage<LoginRespon>();
    final userID = authStorage.data!.loginUserId;
    final baseRespon = await getService<CekkuisionerService>()?.cekKuisioner(userID!, state.id_antrian);
    load_cek_kuisioner.value = false;

    if (baseRespon is BaseError){
      Fungsi.errorToast("Tidak dapat mengecek kuisioner");
    }else{
      //kalau sudah ngerjain kuisioner, tutup screen
      if (baseRespon!.code == "200"){
        Fungsi.warningToast(baseRespon!.message!);
        Get.back();
      }else{
        //kalau sudah ngerjain, hit api get pertanyaan
        getPertanyaan();
      }
    }

  }
}