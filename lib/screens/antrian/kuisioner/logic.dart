import 'dart:convert';

import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/ChoicechipModel.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/PertanyaanRespon.dart' as pertanyaan;
import 'package:jmcare/model/api/SubmitjawabanRequest.dart';
import 'package:jmcare/screens/antrian/kuisioner/state.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/service/CekkuisionerService.dart';
import 'package:jmcare/service/PertanyaanService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/SubmitjawabanService.dart';
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

  void clickRadioButton(String id_value, String pertanyaanCode, String newValue){
    state.hashRadio![id_value] = newValue;
    state.hashSemua![pertanyaanCode] = newValue;
    debugPrint( pertanyaanCode + " " + state.hashSemua![pertanyaanCode]!);
    debugPrint( state.hashRadio![id_value]);
    //refresh di view-nya
    update();
  }

  void clickSwitch(String pertanyaanCode, bool newValue){
    if (newValue == true){
      state.hashSemua![pertanyaanCode] = "1";
    }else{
      state.hashSemua![pertanyaanCode] = "0";
    }
    debugPrint(state.hashSemua![pertanyaanCode] );
    //refresh di view
    update();
  }

  void handleSlider(String pertanyaanCode, double newValue ){
    //ingat, slider di fluter itu rangenya 100, bukan 10, jadi yang diset ke hashSemua itu dibagi 10
    double baru = newValue/10; //simpan value baru dibagi dengan 10 pada hashSemua, bukan hashSlider
    state.hashSlider![pertanyaanCode] = newValue.toString(); //disimpan disini
    state.hashSemua![pertanyaanCode] = baru.toString(); //hashse
    debugPrint("nilai " + pertanyaanCode + " : " + state.hashSemua![pertanyaanCode]!);
    //refresh di view
    update();
  }

  void handleTextField(String pertanyaanCode, String newValue){
    state.hashSemua![pertanyaanCode] = newValue;
    debugPrint("nilai " + pertanyaanCode + " : " + state.hashSemua![pertanyaanCode]!);
  }

  void getPertanyaan() async {
    //ini untuk nomor pertanyaan yang didepan pertanyaan
    state.nomor_pertanyaan = 0;
    //loading animation
    load_get_kuisioner.value = true;
    //hit api untuk get pertanyaan
    final pertanyaanRespon = await getService<PertanyaanService>()?.getPertanyaan();
    //jika hit api gagal
    if (pertanyaanRespon is PertanyaanError){
      Fungsi.errorToast("Tidak dapat memproses data kuisioner");
    }else{
      //jika hit api berhasil
      obxPertanyaan.value = pertanyaanRespon!;
      //sesudah hit api, yang dilakukan di logic disini adalah...
      //membuat variabel anak map untuk setiap pertanyaan => lihat variabel state.hashSemua
      //harus looping setiap pertanyaan
      //kalau pertanyaan tidak ada sub pertanyaan => state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = ""
      //kalau pertanyaan ada sub pertanyaan =>  state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "";
      //jadi kalau survey disubmit, state.hashSemua tinggal dilooping, lalu diinsert ke tabel [JMPMFI_Mysystem].[dbo].[CS_SURVEY_PELANGGAN]
      //pertanyaan_code masuk field PERTANYAAN_CODE, idVALUE masuk field VALUE_ID
      //jadi setiap pertanyaan code ada variabelnya


      //semua looping dibawah ini nggak bisa dilakuin di view
      //karena semua pakai ternary
      //jadi dilakuin di logicnya, untuk setiap view model
      obxPertanyaan.value.data!.forEach((a) {

        //counter untuk nomor pertanyaan
        state.nomor_pertanyaan += 1;
        a.pertanyaan!.pERTANYAAN = state.nomor_pertanyaan!.toString() + ". " + a.pertanyaan!.pERTANYAAN!;

        //untuk setiap pertanyaan TextBox
        //=================================================
        //=================================================
        if (a.pertanyaan!.iDFORMAT == "1" || a.pertanyaan!.iDFORMAT == "2"){
          if (a.subPertanyaan == null){
            state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = "";
          }else{
            a.subPertanyaan!.forEach((sub) {
              state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "";
            });
          }
        }

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
                state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = "";
              }
            }else{
              a.subPertanyaan!.forEach((sub) {
                //simpan jawaban user di hash
                //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
                //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
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


        //untuk setiap pertanyaan RadioGroup
        //=================================================
        //=================================================
        if (a.pertanyaan!.iDFORMAT == "4"){
          if (a.subPertanyaan![0].templateJawaban == null){ //299
          }else{
            //jika ada template jawaban, tapi tdk ada sub pertanyaan
            if (a.subPertanyaan!.length == 1 && a.subPertanyaan![0].labelPertanyaan == null ){ //304
              if (a.subPertanyaan![0].templateJawaban == null){ //305
              }else{
                state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = ""; //308
              }
            }else{ //335
              a.subPertanyaan!.forEach((sub) {
                //simpan jawaban user saat user memilih
                //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
                //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
                state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "";
              });
            }
          }

          //cek ada berapa jumlah array sub pertanyaan
          //jika tidak ada, hashRadio di set dengan pertanyaan_code
          if (a.subPertanyaan!.isEmpty || a.subPertanyaan!.length == 0){
            state.hashRadio![a.pertanyaan!.pERTANYAANCODE!] = "";
          }else{
            //jika ada array sub pertanyaan
            //hashRadio di set dengan id value
            for (var i in a.subPertanyaan!){
              //simpan setiap id value di sini ke dalam hashRadio
              state.hashRadio![i.labelPertanyaan!.iDVALUE!] = "";
            }
          }
        }

        //untuk setiap pertanyaan Slider
        //=================================================
        //=================================================
        if (a.pertanyaan!.iDFORMAT == "5"){
          if (a.subPertanyaan == null || a.subPertanyaan!.isEmpty){ //226
            state.hashSlider![a.pertanyaan!.pERTANYAANCODE!] = "10";
            state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = "1";
          }else{ //252
            //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
            //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
            a.subPertanyaan!.forEach((sub) {
              state.hashSlider![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "10";
              state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "1";
            });
          }
        }

        //untuk setiap pertanyaan YesNo atau Switch
        //=================================================
        //=================================================
        if (a.pertanyaan!.iDFORMAT == "6"){
          if (a.subPertanyaan == null){ //184
            state.hashSemua![a.pertanyaan!.pERTANYAANCODE!] = "0";
          }else{ //199
            //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
            //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
            a.subPertanyaan!.forEach((sub) {
              state.hashSemua![a.pertanyaan!.pERTANYAANCODE! + ";" + sub.labelPertanyaan!.iDVALUE!] = "0";
            });
          }
        }






      });
    }
    load_get_kuisioner.value = false;
  }

  void submit() async {
    Get.defaultDialog(
      radius: 10.0,
      title: "Kuisioner Antrian",
      barrierDismissible: false,
      content: const Padding(
        padding: EdgeInsets.all(10),
        child: Text("Apakah Anda akan mengirimkan jawaban kuisioner ini?")
      ),
      textCancel: "Tidak",
      textConfirm: "Ya",
      onCancel: (){

      },
      onConfirm: () {
        Get.back();
        kirimJawabanKuisioner();
      }
    );
  }

  void kirimJawabanKuisioner() async {
    load_get_kuisioner.value = true;
    await Future.delayed(const Duration(seconds: 1));
    //get user id
    final authStorage = await getStorage<LoginRespon>();
    final userID = authStorage.data!.loginUserId;

    List<SubmitjawabanRequest> requests = List<SubmitjawabanRequest>.empty(growable: true);
    SubmitjawabanRequest request;

    state.hashSemua!.keys.forEach((e) {
      //pisahkan kalau ada pertanyaan yang pakai ;
      final splitted = e.split(";");
      if (splitted.isEmpty || splitted.length == 1){
        request = SubmitjawabanRequest(
            iDANTRIAN: state.id_antrian,
            uSERID: int.parse(userID!),
            pERTANYAANCODE: e,
            vALUEID: "",
            jAWABAN: state.hashSemua![e]
        );
      }else{
        final pertanyaan_code = splitted[0].toString();
        final value_id = splitted[1].toString();
        request = SubmitjawabanRequest(
            iDANTRIAN: state.id_antrian,
            uSERID: int.parse(userID!),
            pERTANYAANCODE: pertanyaan_code,
            vALUEID: value_id,
            jAWABAN: state.hashSemua![e]
        );
      }
      requests.add(request);
    });

    //convert json array ke string
    final sRequest = jsonEncode(requests);
    //hit api submit jawaban
    final baseRespon = await getService<SubmitjawabanService>()?.doSubmit(sRequest);
    load_get_kuisioner.value  = false;

    if (baseRespon is BaseError){
      Fungsi.errorToast("Tidak dapat mengirimkan jawaban kuisioner!");
    }else{
      Get.offAllNamed(Konstan.rute_home);
      Fungsi.suksesToast("Jawaban kuisioner berhasil dikirimkan. Terima kasih atas partisipasi Anda.");
    }

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