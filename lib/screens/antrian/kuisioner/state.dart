import 'package:jmcare/model/api/ChoicechipModel.dart';


class KuisionerState {

  String id_antrian = "";
  int nomor_pertanyaan = 0;
  Map<String,String>? hashSemua; //map ini untuk menyimpan semua pertanyaan survei dan masing2 jawaban
  Map<String,String>? hashRadio; //map ini untuk pertanyaan radiobutton
  Map<String,String>? hashSlider; //map ini untuk pertanyaan slider, karena slider di flutter harus 100 gabisa 10


  KuisionerState(){
    hashSemua = Map<String,String>();
    hashRadio = Map<String,String>();
    hashSlider = Map<String,String>();
  }
}