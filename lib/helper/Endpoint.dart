import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Endpoint{
  static const String base_url = "http://ws.mpm-finance.com/JMCare_development/Service1.svc/";
  // static const String base_url = "https://apicloud.jaccs-mpmfinance.com/JMCare-xrgis8hm4zcwdt3ktsgy/Service1.svc/";
  static const String base_url_reset_pass_sms = "http://web-server-api.mpmf.com/M1cr0s1t3T3st1ng/Service1.svc/";
  
  
  static const String login                            = "login.json";
  static const String TAG_VERSION                      = "getversion.json";
  static const String TAG_REGISTER_DEBITUR             = "LoginJM/register.json";
  static const String TAG_REGISTER_NONDEBITOR          = "UpdateUserNonDebitur.json";
  static const String TAG_SUBMIT_AJUKAN_KREDIT         = "submitajukankredit.json";
  static const String TAG_DETAIL_PENGAJUAN_KREDIT      = "getdtlpengajuankredit/{nomor}";

  static const String TAG_FORGET_PIN                   = "forgetpin.json";
  static const String TAG_AUTOFILL_PENGAJUANKREDIT     = "autofillpengajuankredit.json";
  static const String TAG_GETEPOLIS                    = "getfile-url.json";
  static const String TAG_BANNER                       = "getwebsite-data.json";
  static const String TAG_GRADE                        = "getgradecustomer.json";
  static const String TAG_LIST_CABANG                  = "getlistcabang.json";

  static const String TAG_RESET_PASSWORD_CEK_NOMOR_HP      = "CekNomorHP.json";
  static const String TAG_RESET_PASSWORD_OTP_BY_EMAIL      = "otpbyemail.json";
  static const String TAG_RESET_PASSWORD_OTP_BY_WA         = "otpbywa.json";
  static const String TAG_RESET_PASSWORD                   = "resetpassword.json";
  static const String TAG_RIWAYAT_POIN                     = "gethistorypointcustomer/{noKTP}";

  static const String TAG_ANTRIAN_GET_ANTRIANBYCABANG      = "getAntrianByCabang.json";
  static const String TAG_ANTRIAN_KONFIRMASI_KUISIONER     = "getKonfirmasidanKuisioner.json";
  static const String TAG_ANTRIAN_GETLISTREQ_BPKB          = "getlistReqBPKB/q=";
  static const String TAG_ANTRIAN_GETANTRIAN_SEKARANG      = "getantriansekarang.json";
  static const String TAG_ANTRIAN_GETANTRIAN_ONLINE        = "GetAntrianOnline.json";
  static const String TAG_ANTRIAN_KONFIRMASI_KEDATANGAN    = "KonfirmasiKedatangan.json";
  static const String TAG_ANTRIAN_INSERT_APM               = "apmInsertAntrian.json";
  static const String TAG_ANTRIAN_INSERT_ANTRIAN_CS        = "InsertAntrianCS.json";
  static const String TAG_ANTRIAN_GETSUBKATEGORI           = "getSubKategori.json/{jenis_pic}";
  static const String TAG_ANTRIAN_NOTIFIKASI_KUISIONER     = "getNotifikasiKuisioner.json";
  static const String TAG_ANTRIAN_GET_PERTANYAAN           = "getPertanyaan.json";
  static const String TAG_ANTRIAN_SUBMIT_JAWABAN           = "submitJawaban.json";
  static const String TAG_ANTRIAN_TOLAK_KUISIONER          = "tolakKuisioner.json";

  static const String TAG_LIST_USER                = "getlistuser.json";
  static const String TAG_SEARCH_USER              = "searchuser.json";
  static const String TAG_AGREEMENT_CARD           = "getlistagrmntcard.json";
  static const String TAG_GET_LIST_AGREEMENT_KTP   = "getlistagrmntktp.json";
  static const String TAG_TOKEN_ENKRIPSI           = "EoXiV1ZgSXdhKC94fsAGOdgMDZZK3VCBjSuP3Phd6s3yD55vDhevxRoyjt2fvm8PADweDeMvaVM9IfqDC5lQO7p38I2toddcwigjlcZeXXEB0O2Pmyo177gmofpvQgGVXGcjXpL3Qqu5AHkYj0ZdsAgWhtqsF0c7Ip388oTWV0rHkUwVvhcCuU70SYTo8KkMBgJKtPYwvKH3PWCh9GWm3JWk5MGrLPdzI0RpMatdG8bL6j9ErFXs0dIgjIlhLOAL6bl7hPhGlKAYFfTcxDLQZWcIyhflwscVhL7Dod8tF8cs0rQTavH5u17MyVzbIJH70EAZHG4XpbWqAZTyJfOQrhYSv4QfQETyjr2";
  static const String TAG_DELETE_AKUN              = "DeleteAccount.json";

  static const String TAG_KONFIRMASI_TOPUP_PLAFOND             = "konfirmasiTopupPlafond.json";
  static const String TAG_BATALKAN_TOPUP_PLAFOND               = "batalkanTopupPlafond.json";
  static const String TAG_HISTORI_TOPUP_PLAFOND                = "historiTopupPlafond.json";
  static const String TAG_KONFIRMASI_BATAL_TOPUP_PLAFOND       = "cekKonfBatalTopupPlafond.json";
  static const String TAG_PENCAIRAN_DAN_ANGSURAN               = "GetPencairanDanAngsuran.json";
  static const String TAG_INSERT_TOPUPPLAFOND_JMCARE           = "insertTopUpPlafond_JMCare.json";
  static const String TAG_JM_SUBMIT_ORDER                      = "jm_submitorder.json";
  static const String TAG_GETPRICE_FROMBRAND                   = "getpricefrom_brandtype.json";
  static const String TAG_PARAM_COMBO                          = "getlistparam-combo.json";
  static const String TAG_VIEWLIST_JENISDOKUMEN                = "getviewlist/JnsDokumen/0";
  static const String TAG_LISTPARAM_CONFINS_PEKERJAAN          = "getlistparam-confins/Pekerjaan/sKdCbg";
  static const String TAG_LISTPARAM_CONFINS_PENDIDIKANTERAKHIR = "getlistparam-confins/PendidikanTerakhir/sKdCbg";
  static const String TAG_VIEWLIST_STATUSPERNIKAHAN            = "getviewlistWO/501/statuspernikahan/0";
  static const String TAG_VIEWLIST_STATUS_KEPEMILIKAN_RUMAH    = "getviewList/StatusKepemilikanRumah/0";
  static const String TAG_VIEWLIST_JENIS_PEKERJAAN             = "getviewjnspekerjaan";
  static const String TAG_VIEWLIST_PRODUK                      = "getTipeProduk.json";
  static const String TAG_VIEWLIST_SOURCE_OF_APPLICATION       = "getviewlistsoa/0/SourceOfApplication/0/";
  static const String TAG_VIEWLIST_JAMINAN_BPKB                = "getviewlist/JaminanBPKB/0";
  static const String TAG_VIEWLIST_ASSET                       = "getviewlistasset/0/";
  static const String TAG_VIEWLIST_TUJUAN_PEMBIAYAAN           = "getlistparam-infomedia/tujuan_pembiayaan";
  static const String TAG_VIEWLIST_ADDRESS                     = "GetlistAdress/{a}/{b}/{c}";
  static const String TAG_VIEWLIST_MERKKENDARAAN               = "getlistmerkkend/{tipeJaminan}";
  static const String TAG_VIEWLIST_TIPEKENDARAAN               = "getlisttipekend/{id}";

  static const String TAG_SEND_OTP                             = "sendSMS/";
  // static const String TAG_SEND_OTP                             = "sendSMS/{nomor_hp}/{pesan}";

  static List<Interceptor> dioInterceptors = [
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
    )
  ];

}