import 'package:location/location.dart';

class DetailriwayatState {

  String agreement_no = "";
  String nomor_plat = "";
  String tanggal = "";
  String tgl = "";
  String jam = "";
  String office_name = "";
  String nama = "";
  String pic = "";
  String tujuan = "";
  String token = "";
  String id = "";
  String is_finished = "";
  String konfirmasi_kedatangan = "";
  String sudah_kuisioner = "";
  String office_lat = "";
  String office_long = "";

  Location? location;
  bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;

  DetailriwayatState(){
    location = Location();
  }
}