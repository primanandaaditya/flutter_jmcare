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
                      () => logic.sdhLogin.value ?
                      Komponen.getMainDrawer(context, () => logic.doLogout(context))
                          :
                      Container(),),

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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(

                            children: [
                              Komponen.getLogoPutih(),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Obx(() => logic.sdhLogin.value ? InkWell(
                                  onTap: (){
                                    debugPrint("aaa");
                                  },
                                  child: Container()
                              )
                                  : Container(),),

                              const Padding(padding: EdgeInsets.only(right: 30)),
                            ],
                          ),
                        ),


                        Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [

                                Obx(() => logic.is_loading.value ?
                                Komponen.getLoadingWidget()
                                    :
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
                                            // context.read<IndicatorProvider>().commit(index);
                                          }
                                      ),
                                      items: logic.konversi(logic.arraySlideshow.value)
                                  ),
                                ),),


                                const Padding(padding: EdgeInsets.only(top: 10)),

                                //jika belum login munculkan link untuk login/register
                                Obx(() => logic.sdhLogin.value ? Container() : Komponen.linkMasukOrRegister(context), ),

                                const Padding(padding: EdgeInsets.only(top: 20)),

                                Komponen.teksJudul("Menu Favorit"),

                                const Padding(padding: EdgeInsets.only(top: 30)),

                                Komponen.teksJudul("Info Produk dan Melayani"),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                Obx(() => logic.is_loading.value ? LinearProgressIndicator() : Komponen.getProdukListView(logic.arrayProduk.value),),

                                const Padding(padding: EdgeInsets.only(top: 30)),

                                Komponen.teksJudul("Info Promosi"),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                Obx(() => logic.is_loading.value ? LinearProgressIndicator() : Komponen.getPromoListView(logic.arrayPromo.value),),

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
