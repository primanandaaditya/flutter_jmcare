import 'package:flutter/material.dart';
import 'package:jmcare/screens/home/logic.dart';
import 'package:jmcare/screens/home/state.dart';
import 'package:get/get.dart';
import '../../helper/Komponen.dart';
import '../../helper/Warna.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final HomeLogic logic = Get.put(HomeLogic());
    final HomeState state = Get.find<HomeLogic>().state;

    return GetBuilder<HomeLogic>(
      assignId: true,
        builder: (logic){

        return Scaffold(
          //jika sdh login munculkan navigationdrawer
            endDrawer:
                Obx(
                      () => logic.sdhLogin.value
                          ? Komponen.getMainDrawer(
                              context,
                              () => logic.doLogout(context),
                              () => logic.dialogDeleteAkun(context))
                          : Container(),),

            body: SafeArea(

              child: Stack(
                children: [

                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green,
                              Warna.hijau
                            ]
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)
                        )
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [

                        Row(
                          children: [
                            Komponen.getLogoPutih(),
                            const Spacer(),
                            // const Spacer(),
                            // const Spacer(),
                            Obx(() =>
                              logic.sdhLogin.value ?
                              //kalau sudah login, tampilkan loading grade
                              logic.loading_grade.value
                                  ? const CircularProgressIndicator(color: Colors.white,)
                                  : InkWell(
                                      onTap: (){
                                        logic.clickBadgeUser();
                                      },
                                      child: Row(
                                        children: [
                                          logic.icon_jenis_member.value == ''
                                              ? const Icon(
                                                Icons.supervised_user_circle,
                                              color: Colors.white,
                                              size: 30,
                                            )
                                          : Image.asset(logic.icon_jenis_member.value, height: 30, width: 30,),
                                          const Padding(padding: EdgeInsets.only(left: 4)),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Selamat datang, ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10
                                                ),
                                              ),
                                              Text(
                                                logic.nama_user.value,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12
                                                ),
                                              ),
                                              // Row(
                                              //   children:  [
                                              //     Text(logic.point.value.toString(), style: const
                                              //     TextStyle(color: Colors.white, fontSize: 10),),
                                              //     const Text(" point", style: TextStyle(color: Colors.white, fontSize: 8),),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                          const Padding(padding: EdgeInsets.only(left: 25)),
                                        ],
                                      )
                              )
                              //kalau belum login tampilkan Container kosongan
                                : Container(),),
                            // const Spacer()
                          ],
                        ),

                        Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [

                                Obx(() => (logic.is_loading.value || logic.arraySlideshow.value == null)
                                    ? SizedBox(height: 300, child: Komponen.getLoadingWidget()) //loading ditaruh di Sizedbox, biar ga ngegap kalo api bisa
                                    : Stack(
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            child: CarouselSlider(
                                                carouselController: state.carouselController,
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    viewportFraction: 1.0,
                                                    enlargeCenterPage: false,
                                                    autoPlayInterval: const Duration(seconds: 5),
                                                    height: double.infinity,
                                                    onPageChanged: (index,reason){
                                                      logic.setIndeksCarousel(index);
                                                    }
                                                ),
                                                items: logic.konversi(logic.arraySlideshow.value)
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: logic.konversi(logic.arraySlideshow.value).asMap().entries.map((entry) {

                                                return GestureDetector(
                                                  onTap: () {
                                                    logic.state.carouselController!.animateToPage(entry.key);
                                                  },
                                                  child: Container(
                                                    width: logic.indeksCarousel.value == entry.key ? 9.0 : 6.0,
                                                    height: logic.indeksCarousel.value == entry.key ? 9.0 : 6.0,
                                                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: (Theme.of(context).brightness == Brightness.dark
                                                            ? Colors.white
                                                            : Warna.hijau
                                                        ).withOpacity(logic.indeksCarousel.value == entry.key ? 0.9 : 0.4)
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      )
                                ),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                //jika belum login munculkan link untuk login/register
                                Obx(() => logic.sdhLogin.value ? Container() : Komponen.linkMasukOrRegister(context) ),

                                const Padding(padding: EdgeInsets.only(top: 20)),

                                Komponen.teksJudul("Menu Favorit"),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                Row(
                                  children: [
                                    const Spacer(),
                                    Komponen.menuUtama(
                                        context,
                                        "assets/images/selfservice.png",
                                        "Self Service",
                                        () => logic.klikMenuSelfService(context)
                                    ),
                                    const Spacer(),
                                    Komponen.menuUtama(
                                        context,
                                        "assets/images/mservice.png",
                                        "M-Service", () => logic.klikMenuMService(context)
                                    ),
                                    const Spacer(),
                                  ],
                                ),

                                const Padding(padding: EdgeInsets.only(top: 30)),

                                Komponen.teksJudul("Info Produk dan Melayani"),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                Obx(
                                      () =>
                                      logic.is_loading.value || logic.arrayProduk.value == null
                                          ? SizedBox(height: 200, child: Komponen.getLoadingWidget())
                                          : Komponen.getProdukListView(logic.arrayProduk.value),
                                ),

                                const Padding(padding: EdgeInsets.only(top: 30)),

                                Komponen.teksJudul("Info Promosi"),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                Obx(
                                      () => logic.is_loading.value || logic.arrayPromo.value == null
                                          ? SizedBox(height: 200, child: Komponen.getLoadingWidget())
                                          : Komponen.getPromoListView(logic.arrayPromo.value)
                                ),

                                const Padding(padding: EdgeInsets.only(top: 20)),
                              ],
                            )
                        )
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: true,
                    ),
                  ),
                ],
              ),
            )
        );
        }
    );
  }
}
