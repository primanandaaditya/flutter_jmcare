
import 'package:carousel_slider/carousel_slider.dart';

class HomeState {

  CarouselController? carouselController;
  String noKTP = "";
  String isDebitur = "";

  HomeState(){
    carouselController = CarouselController();
  }
}