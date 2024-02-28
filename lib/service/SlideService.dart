import 'package:jmcare/helper/Endpoint.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/SlideshowRespon.dart';
import 'BaseService.dart';

class SlideService extends BaseService{

  static SlideService instance = SlideService();

  Future<SlideshowRespon?> getSlideshow() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_BANNER,body: {
        "param": "slideshow"
      });
    }catch(e){
      return SlideshowError();
    }
  }

  Future<ProdukRespon?> getSlideProduk() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_BANNER,body: {
        "param": "produk"
      });
    }catch(e){
      return ProdukError();
    }
  }

  Future<PromoRespon?> getSlidePromo() async{
    await Future.delayed(const Duration(seconds: 0));
    try{
      return getJsonArray(Endpoint.TAG_BANNER,body: {
        "param": "promo"
      });
    }catch(e){
      return PromoError();
    }
  }
}
