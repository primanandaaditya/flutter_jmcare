import 'package:flutter/material.dart';

import '../../helper/Komponen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeState {

  String lewati = "Lewati >>";

  List<Widget> getCarousel(){
    return <Widget>[
      Komponen.widgetWelcome("assets/images/welcome1.png", "Dapatkan info produk, update promosi, suku bunga dari JM Care lebih cepat", false,true),
      Komponen.widgetWelcome("assets/images/welcome2.png", "Ajukan pembiayaan motor, mobil dan pantau prosesnya tanpa harus keluar rumah", true,true),
      Komponen.widgetWelcome("assets/images/welcome3.png", "Terhubung langsung dengan layanan digital JM Care, seperti mendapatkan sertifikat polis secara digital, request copy BPKB anti ribet", true, false)
    ];
  }

  CarouselOptions getCarouselOption(){
    return CarouselOptions(
      height: double.infinity,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: false,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: false,
      scrollDirection: Axis.horizontal,
    );
  }


  WelcomeState(){

  }
}