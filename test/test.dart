import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/screens/copy_bpkb/RequestBpkbScreen.dart';
import 'package:jmcare/screens/home/IndicatorProvider.dart';
import 'package:jmcare/screens/home/ProdukBloc.dart';
import 'package:jmcare/screens/home/ProfilBloc.dart';
import 'package:jmcare/screens/home/ProfilModel.dart';
import 'package:jmcare/screens/home/PromoBloc.dart';
import 'package:jmcare/screens/home/PromoModel.dart';
import 'package:jmcare/screens/home/SlideBloc.dart';
import 'package:jmcare/screens/home/SlideModel.dart';
import 'package:jmcare/screens/login/CekloginBloc.dart';
import 'package:jmcare/screens/versi/VersiBloc.dart';
import 'package:jmcare/screens/versi/VersiModel.dart';
import 'package:provider/provider.dart';

CarouselController carouselController = CarouselController();

late SlideBloc slideBloc;
late CekloginBloc cekloginBloc;
late ProfilBloc profilBloc;
late PromoBloc promoBloc;
late ProdukBloc produkBloc;
late VersiBloc versiBloc;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/drawer_bg.png"), context);

    // SystemChrome.restoreSystemUIOverlays();
    versiBloc = VersiBloc(0);
    slideBloc = SlideBloc(List<SlideBegin>.empty());
    cekloginBloc = CekloginBloc(0);
    profilBloc = ProfilBloc(ProfilBegin());
    promoBloc = PromoBloc(List<PromoBegin>.empty(growable: true));
    produkBloc = ProdukBloc(List<PromoBegin>.empty(growable: true));

    return MultiBlocProvider(
        providers: [
          BlocProvider<VersiBloc>(
              create: (BuildContext context) => versiBloc
          ),
          BlocProvider<SlideBloc>(
              create: (BuildContext context) => slideBloc
          ),
          BlocProvider<CekloginBloc>(
              create: (BuildContext context) => cekloginBloc
          ),
          BlocProvider<ProfilBloc>(
              create: (BuildContext context) => profilBloc
          ),
          BlocProvider<PromoBloc>(
              create: (BuildContext context) => promoBloc
          ),
          BlocProvider<ProdukBloc>(
              create: (BuildContext context) => produkBloc
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<IndicatorProvider>(
                create: (_) => IndicatorProvider(0)
            ),
          ],
          child: const HomeCekLogin(),
        )
    );
  }
}

class HomeCekLogin extends StatelessWidget {
  const HomeCekLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    cekloginBloc.cekLogin();

    return BlocBuilder<CekloginBloc,int>(
        builder: (context,state){
          if (state == 2 || state == 4){
            return HomeView(false);
          }else{
            return HomeView(true);
          }
        }
    );
  }
}


class HomeView extends StatelessWidget {
  bool sdhLogin;
  HomeView(this.sdhLogin, {super.key});

  @override
  Widget build(BuildContext context) {

    versiBloc.getVersi();

    slideBloc.getSlide();
    profilBloc.getProfil();
    promoBloc.getPromo("promo");
    produkBloc.getProduk("produk");

    void dialogVersi(BuildContext context) {
      var alertDialog =  AlertDialog(
        title: const Text("Pembaharuan Aplikasi"),
        content: const Text("Silakan perbaharui aplikasi JMCare di playstore/appstore"),
        icon: const Icon(Icons.warning),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("OK")
          )
        ],
        elevation: 4.0,
      );

      showDialog(
          context: context,
          barrierDismissible: false,
          useSafeArea: true,
          builder: (BuildContext context) => alertDialog);
    }

    return Scaffold(
      //jika sdh login munculkan navigationdrawer
        endDrawer: sdhLogin ? Komponen.getMainDrawer(context) : null,

        body: SafeArea(

          child: Stack(

            children: [

              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: BlocListener<VersiBloc,int>(
                  listener: (context,state){
                    debugPrint("versi:$state");
                    switch(state) {

                      case 0: {
                      }
                      break;
                      case -1: {
                        //error waktu get versi
                      }
                      break;
                      case 1: {

                      }
                      break;
                      case 2: {
                        //versi ok
                      }
                      break;
                      case 3: {
                        Navigator.popAndPushNamed(context, "/updateversi");
                      }
                      break;
                      default: {

                      }
                      break;
                    }
                  },
                  child: Container(),
                ),
              ),

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
                          sdhLogin ? InkWell(
                              onTap: (){
                                debugPrint("aaa");
                              },
                              child: Komponen.getProfil(context)
                          )
                              : Container(),
                          const Padding(padding: EdgeInsets.only(right: 30)),
                        ],
                      ),
                    ),


                    Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [

                            SizedBox(
                                height: 300,
                                child: BlocBuilder<SlideBloc, List<SlideModel>>(
                                    builder: (context, state) {
                                      if (state is List<SlideBegin>){
                                        return Container();
                                      }else if (state is List<SlideLoading>){
                                        return const Center(child: CircularProgressIndicator());
                                      }else if (state is List<SlideError>){
                                        return Center(child: Komponen.teksMerah(Konstan.tag_error),);
                                      }else{
                                        return Stack(
                                          children: [

                                            CarouselSlider(
                                                carouselController: carouselController,
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    viewportFraction: 1.0,
                                                    enlargeCenterPage: false,
                                                    autoPlayInterval: const Duration(seconds: 5),
                                                    height: double.infinity,
                                                    onPageChanged: (index,reason){
                                                      context.read<IndicatorProvider>().commit(index);
                                                    }
                                                ),
                                                items: slideBloc.konversi(state)
                                            ),

                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: slideBloc.konversi(state).asMap().entries.map((entry) {

                                                  return GestureDetector(
                                                    onTap: () {
                                                      carouselController.animateToPage(entry.key);
                                                    },
                                                    child: Container(
                                                      width: context.watch<IndicatorProvider>().indeks == entry.key ? 9.0 : 6.0,
                                                      height: context.watch<IndicatorProvider>().indeks == entry.key ? 9.0 : 6.0,
                                                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: (Theme.of(context).brightness == Brightness.dark
                                                              ? Colors.white
                                                              : Warna.hijau
                                                          ).withOpacity(context.read<IndicatorProvider>().indeks == entry.key ? 0.9 : 0.4)
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    }
                                )
                            ),

                            const Padding(padding: EdgeInsets.only(top: 10)),

                            //jika belum login munculkan link untuk login/register
                            sdhLogin ? Container() : Komponen.linkMasukOrRegister(context),

                            const Padding(padding: EdgeInsets.only(top: 20)),

                            Komponen.teksJudul("Menu Favorit"),

                            //tentukan menu untuk membedakan menu debitur dan nondebitur
                            BlocBuilder<ProfilBloc,ProfilModel>(
                                builder: (context,state){
                                  if (state is ProfilModel){
                                    if (state.jenisdebitur.toString().trim() == Konstan.tag_debitur){
                                      return Row(
                                        children: [
                                          Komponen.menuUtama(
                                              context,
                                              "assets/images/mpoint.png",
                                              "M-Point",
                                              sdhLogin,
                                              Komponen.getBottomSheet(
                                                  context,
                                                  "M-Point",
                                                  200,
                                                  Komponen.getChildren_MPoint(context)
                                              )
                                          ),
                                          Komponen.menuUtama(
                                              context,
                                              "assets/images/selfservice.png",
                                              "Self Service",
                                              sdhLogin,
                                              Komponen.getBottomSheet(
                                                  context,
                                                  "Self Service",
                                                  200,
                                                  Komponen.getChildren_SelfService(context)
                                              )
                                          ),
                                          Komponen.menuUtama(
                                              context,
                                              "assets/images/mservice.png",
                                              "M-Service",
                                              sdhLogin,
                                              Komponen.getBottomSheet(
                                                  context,
                                                  "M-Service",
                                                  200,
                                                  Komponen.getChildren_MService(context, jenisDebitur: state.jenisdebitur)
                                              )
                                          ),
                                          Komponen.menuUtama(
                                              context,
                                              "assets/images/mpayment.png",
                                              "M-Payment",
                                              sdhLogin,
                                              Komponen.getBottomSheet(
                                                  context,
                                                  "M-Payment",
                                                  100,
                                                  const Center(
                                                    child: Text("Menu ini belum tersedia"),
                                                  )
                                              )
                                          ),
                                        ],
                                      );
                                    }else{
                                      return Padding(
                                          padding: const EdgeInsets.only(top: 10, left: 10),
                                          child: InkWell(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/images/selfservice.png",
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                const Padding(padding: EdgeInsets.only(top: 10)),
                                                const Text("Antrian")
                                              ],
                                            ),
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestBpkbScreen(jenisDebitur: Konstan.tag_non_debitur,)),);
                                            },
                                          )
                                      );
                                    }
                                  }else{
                                    return Container();
                                  }
                                }),

                            const Padding(padding: EdgeInsets.only(top: 30)),

                            Komponen.teksJudul("Info Produk dan Melayani"),

                            const Padding(padding: EdgeInsets.only(top: 10)),

                            Komponen.getProdukListView(context),

                            const Padding(padding: EdgeInsets.only(top: 30)),

                            Komponen.teksJudul("Info Promosi"),

                            const Padding(padding: EdgeInsets.only(top: 10)),

                            Komponen.getPromoListView(context),

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
}

