
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/model/api/BaseRespon.dart';
import 'package:jmcare/model/api/GradeRespon.dart';
import 'package:jmcare/model/api/LoginRespon.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/SlideshowRespon.dart';
import 'package:jmcare/model/api/VersiRespon.dart';
import 'package:jmcare/screens/base/base_logic.dart';
import 'package:jmcare/screens/home/state.dart';
import 'package:jmcare/service/GradeService.dart';
import 'package:jmcare/service/Service.dart';
import 'package:jmcare/service/VersiService.dart';
import 'package:jmcare/storage/storage.dart';
import '../../service/DeleteakunService.dart';
import '../../service/SlideService.dart';

class HomeLogic extends BaseLogic{

  final HomeState state = HomeState();
  var sdhLogin = false.obs;
  var indeksCarousel = 0.obs;
  var grade = "".obs;
  var point = "0".obs;
  var loading_grade = false.obs;
  var nama_user = "".obs;
  var icon_jenis_member = "".obs;
  var arraySlideshow = SlideshowRespon().obs;
  var arrayProduk = ProdukRespon().obs;
  var arrayPromo = PromoRespon().obs;

  @override
  void onInit() {
    super.onInit();
    is_loading.value = true;
    checkIsLogin();
    cekVersi();
    getSlides();
    getGrade();
  }

  void klikMenuMService(BuildContext context) async {
    final authStorage = await getStorage<LoginRespon>();
    if (authStorage.data == null){
      Fungsi.toastBelumLogin();
    }else{
      Get.bottomSheet(
          FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black12
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    )
                ),
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: [
                    Center(
                      child:  FractionallySizedBox(
                        widthFactor: 0.4,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black12
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    ListTile(
                      leading: Image.asset('assets/images/selfservice.png', width: 50, height: 50,),
                      title: const Text("Agreement Card"),
                      subtitle: const Text("Lihat agreement card berdasarkan nomor kontrak"),
                      onTap: () => Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_agreement_card}),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Image.asset('assets/images/selfservice.png', width: 50, height: 50,),
                      title: const Text("Antrian Online"),
                      subtitle: const Text("Sistem reservasi nomor antrian loket pendaftaran secara online"),
                      onTap: () => Get.toNamed(Konstan.rute_pilih_no_kontrak),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Image.asset('assets/images/selfservice.png', width: 50, height: 50,),
                      title: const Text("E-Polis"),
                      subtitle: const Text("Unduh epolis Anda dalam format PDF"),
                      onTap: () => Get.toNamed(Konstan.rute_pilih_no_kontrak, arguments: {'detail': Konstan.rute_epolis}),
                    ),
                  ],
                ),
              )
          )

      );
    }
  }

  void klikMenuSelfService(BuildContext context) async {
    final authStorage = await getStorage<LoginRespon>();
    if (authStorage.data == null){
      Fungsi.toastBelumLogin();
    }else{
      Get.bottomSheet(
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black12
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                )
            ),
            padding: EdgeInsets.all(10),
            child: Wrap(
              children: [
                Center(
                  child:  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black12
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                ListTile(
                  leading: Image.asset('assets/images/selfservice.png', width: 50, height: 50,),
                  title: Text("Jaringan Kami"),
                  subtitle: Text("Lihat daftar semua kantor cabang"),
                  onTap: () => Get.toNamed(Konstan.rute_list_cabang),
                ),
              ],
            ),
          )
        )

      );
    }
  }

  Future<bool> deleteAkun() async {
    final authStorage = await getStorage<LoginRespon>();
    var id = authStorage.data!.loginUserId;
    final baseRespon = await getService<DeleteakunService>()?.deleteAkun(id!);
    if (baseRespon is BaseError){
      return false;
    }else{
      if (baseRespon?.code == "200" || baseRespon?.message == 'Success'){
        return true;
      }else{
        return false;
      }
    }
  }

  Future<bool?> dialogDeleteAkun(
      BuildContext context
      ) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: true, // user must tap button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus akun'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah Anda yakin akan menghapus akun Anda?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: ()  {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () async {
                //hit api
                final hasil = await deleteAkun();
                if (hasil == true){
                  Fungsi.suksesToast("Akun berhasil dihapus!");
                  //clear session
                  clearSP();
                  //restart aplikasi ke splash screen
                  Get.offNamedUntil(Konstan.rute_splash, (route) => false);
                }else{
                  Fungsi.errorToast("Akun gagal dihapus!");
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void hapusAkunPermanen(){
    deleteAkun();
  }

  void gotoHistoripoin(){
    Get.toNamed(Konstan.rute_histori_poin);
  }

  void gotoPaginationuser(){
    Get.toNamed(Konstan.rute_pagination_user);
  }

  void clickBadgeUser() async {
    final loginStorage = await getStorage<LoginRespon>();
    bool is_admin = loginStorage.data!.isAdmin! == "1";
    if (is_admin){
      gotoPaginationuser();
    }else{
      gotoHistoripoin();
    }
  }

  void getGrade() async {
    loading_grade.value = true;
    //get no ktp dari session
    final loginRespon = await getStorage<LoginRespon>();
    state.noKTP = loginRespon.data!.noKtp!;
    nama_user.value = Fungsi.splitNamaUser(loginRespon.data!.namaUser!);
    final gradeRespon = await getService<GradeService>()?.getGrade(state.noKTP);
    loading_grade.value = false;
    if (gradeRespon is GradeError || gradeRespon == null){
      grade.value = "";
      point.value = "0";
    }else{
      var data = gradeRespon.data!.first;
      grade.value = data.grade!;
      point.value = data.point!.toString().isEmpty ? '0' : Fungsi.formatNumber(data.point!,0);
      //simpan grade dan point di session
      baseSaveStorage<GradeRespon>(gradeRespon);
      //set image dan point
      if (grade.value.toLowerCase() == Konstan.tag_gold) {
        icon_jenis_member.value = "assets/images/gold.png";
      } else if (grade.value.toLowerCase() == Konstan.tag_bronze) {
        icon_jenis_member.value = "assets/images/bronze.png";
      } else if (grade.value.toLowerCase() == Konstan.tag_silver) {
        icon_jenis_member.value = "assets/images/platinum.png";
      } else if (grade.value.toLowerCase() == Konstan.tag_platinum) {
        icon_jenis_member.value = "assets/images/platinum.png";
      } else {
        icon_jenis_member.value = "";
      }
      debugPrint('icon jenis member ' + icon_jenis_member.value.toString());
    }
  }

  void checkIsLogin() async{
    is_loading.value = true;
    final storageAuth = await getStorage<LoginRespon>();
    if(storageAuth.data?.loginUserId != null){
      sdhLogin.value = true;
    }else{
      sdhLogin.value = false;
    }
    is_loading.value= false;
    debugPrint('sdh login ' + sdhLogin.value.toString());
  }

  void cekVersi() async {
    var versiRespon = await getService<VersiService>()?.getVersion();
    if (versiRespon is VersiError || versiRespon?.data!.length == 0){
      debugPrint('versi error!');
    }else{
      var v = versiRespon!.data!.first;
      debugPrint(v.versionCode);
    }
  }

  void getSlides() async {
    is_loading.value = true;
    //get slideshow
    var slideshow = await getService<SlideService>()?.getSlideshow();
    if (slideshow is SlideshowError || slideshow?.data?.length == 0){
      Fungsi.errorToast("Error get slide data");
    }else{
      arraySlideshow.value = slideshow!;
    }
    is_loading.value = false;


    //get slide produk
    is_loading.value = true;
    var produks = await getService<SlideService>()?.getSlideProduk();
    if (produks is ProdukError || produks?.data?.length == 0){
      Get.snackbar(Konstan.tag_error, "Error get slide product");
    }else{
      arrayProduk.value = produks!;
    }
    is_loading.value = false;

    is_loading.value = true;
    //get slide promo
    var promos = await getService<SlideService>()?.getSlidePromo();
    if (promos is PromoError || promos?.data?.length == 0){
      Get.snackbar(Konstan.tag_error, "Error get slide promo");
    }else{
      arrayPromo.value = promos!;
    }
    is_loading.value = false;
  }

  void setIndeksCarousel(int value){
    indeksCarousel.value = value;
  }

  void showDetailSlide(String detail){
    debugPrint("detail " + detail);
  }
}