import 'package:dio/dio.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/service/AddantrianService.dart';
import 'package:jmcare/service/AgreementcardService.dart';
import 'package:jmcare/service/CabangService.dart';
import 'package:jmcare/service/CekkuisionerService.dart';
import 'package:jmcare/service/CeknomorhpService.dart';
import 'package:jmcare/service/DeleteakunService.dart';
import 'package:jmcare/service/DownloadepolisService.dart';
import 'package:jmcare/service/EpolisService.dart';
import 'package:jmcare/service/GradeService.dart';
import 'package:jmcare/service/HistoripoinService.dart';
import 'package:jmcare/service/KategoriService.dart';
import 'package:jmcare/service/KonfirmasikedatanganService.dart';
import 'package:jmcare/service/LupapinService.dart';
import 'package:jmcare/service/OtpemailService.dart';
import 'package:jmcare/service/OtpwaService.dart';
import 'package:jmcare/service/PaginationuserService.dart';
import 'package:jmcare/service/PertanyaanService.dart';
import 'package:jmcare/service/PilihkontrakService.dart';
import 'package:jmcare/service/RegisterDebiturService.dart';
import 'package:jmcare/service/RegisterNonDebiturService.dart';
import 'package:jmcare/service/ResetpasswordService.dart';
import 'package:jmcare/service/RiwayatantrianService.dart';
import 'package:jmcare/service/SearchuserService.dart';
import 'package:jmcare/service/SlideService.dart';
import 'package:jmcare/service/SmsService.dart';
import 'package:jmcare/service/VersiService.dart';
import 'BaseService.dart';
import 'LoginService.dart';

class Service {
  Dio? client;
  static late Service instance;

  Service();

  Service.setup(this.client) {
    instance = this;
  }

  Map<Type, BaseService> get classes {
    return {
      LoginService: LoginService.instance,
      RegisterDebiturService: RegisterDebiturService.instance,
      RegisterNonDebiturService: RegisterNonDebiturService.instance,
      CeknomorhpService: CeknomorhpService.instance,
      OtpemailService: OtpemailService.instance,
      OtpwaService: OtpwaService.instance,
      SmsService: SmsService.instance,
      ResetpasswordService: ResetpasswordService.instance,
      VersiService: VersiService.instance,
      SlideService: SlideService.instance,
      GradeService: GradeService.instance,
      HistoripoinService: HistoripoinService.instance,
      PaginationuserService: PaginationuserService.instance,
      SearchuserService: SearchuserService.instance,
      DeleteakunService: DeleteakunService.instance,
      CabangService: CabangService.instance,
      LupapinService: LupapinService.instance,
      PilihkontrakService: PilihkontrakService.instance,
      AgreementcardService: AgreementcardService.instance,
      EpolisService: EpolisService.instance,
      DownloadepolisService: DownloadepolisService.instance,
      KategoriService: KategoriService.instance,
      AddantrianService: AddantrianService.instance,
      RiwayatantrianService: RiwayatantrianService.instance,
      KonfirmasikedatanganService: KonfirmasikedatanganService.instance,
      CekkuisionerService: CekkuisionerService.instance,
      PertanyaanService: PertanyaanService.instance
    };
  }

  static T? resolve<T extends BaseService?>() {
    if (instance.classes[T] == null) {
      throw "$T belum diregistrasi. Periksa service!";
    }
    return instance.classes[T] as T?;
  }
}

T? getService<T extends BaseService>() {
  return Service.resolve<T>();
}
