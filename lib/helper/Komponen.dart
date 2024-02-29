import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:get/get.dart';

class Komponen{

  static Widget getCardOption({
    required String title,
    required String subtitle,
    required int radioValue,
    required int groupValue,
    required Function changeGroupValue

}){

    return Card(
      elevation: 4,
      child: Row(
        children: [
          Radio(
            value: radioValue,
            groupValue: groupValue,
            onChanged: (value){
              changeGroupValue();
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: const TextStyle(
                    fontSize: 14
                ),
              ),
              Text(subtitle,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Widget getLogoHijau(){
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: ConstrainedBox(
            constraints: const BoxConstraints.expand(
                height: 100
            ),
            child: Image.asset("assets/images/jmcare_hijau.png")
        )
    );
  }

  static AppBar getAppBar(
      BuildContext context,
      String title
      ){
    return AppBar(
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green,
              Warna.hijau,
            ]
          )
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: (){
          Get.back();
        },
      ),
      title: Text(title, textAlign: TextAlign.center,),
    );
  }

  static Widget getMainDrawer(
      BuildContext context,
      Function onLogout
      ){
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
      ),
      backgroundColor: Colors.white,
      child: ListView(
        children: [

          Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Warna.hijau,
                  image: DecorationImage(
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/drawer_bg.png")
                  )
              ),
              child:  Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      )
                  )
              )
          ),

          ListTile(
            tileColor: Colors.white,
            title: const Text('Logout'),
            onTap: () {
              onLogout();
            },
          ),

          Container(
            color: Colors.white,
            constraints: const BoxConstraints(
                maxHeight: double.infinity
            ),
          )

        ],
      ),
    );
  }

  static Widget menuUtama(
      BuildContext context,
      String urlImage,
      String titleMenu,
      bool sdhLogin,
      Widget bottomModal){

    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: (){
              if (sdhLogin){
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return bottomModal;
                    },
                    backgroundColor: Colors.transparent
                );
              }else{
                Fungsi.toastBelumLogin(context);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.75,
                  child: Image.asset(
                    urlImage,
                  ),
                ),
                Text(
                  titleMenu,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12
                  ),
                )
              ],
            )
        )

    );
  }

  static Widget getBottomSheet(BuildContext context, String title, double tinggi, Widget contentSubmenu){
    return FractionallySizedBox(
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
          height: tinggi,
          child: Center(
            child: Column(

              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Expanded(child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            )
                        )
                    )
                  ],
                ),
                const Divider(),
                contentSubmenu
              ],
            ),
          ),
        )
    );
  }

  static Widget subMenu(BuildContext context, String imageUrl, String title, String routeName){
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, routeName);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.6,
                  child: Image.asset(imageUrl),
                ),
                FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    )
                ),

              ],
            )
        )
    );
  }

  static Widget getChildren_MPoint(BuildContext context){
    List<Widget> hasil = List<Widget>.empty(growable: true);
    hasil.add(const Spacer());
    hasil.add(subMenu(context, "assets/images/gradecustomer.png", "Grade", "/hpoin"));
    hasil.add(const Spacer());
    hasil.add(const Spacer());
    hasil.add(subMenu(context, "assets/images/redeem.png", "Redeem\npoint", "/redeem"));
    hasil.add(const Spacer());
    return Row(
      children: hasil,
    );
  }

  static Widget getChildren_SelfService(BuildContext context){
    List<Widget> rowAtas = List<Widget>.empty(growable: true);
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/gradecustomer.png", "Topup\nPlafond", "/topupplafond"));
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/redeem.png", "Renewal\nAsuransi", "/renewalasuransi"));
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/redeem.png", "Jaringan\nKami", "/jaringankami"));
    rowAtas.add(const Spacer());
    return Row(
      children: rowAtas,
    );
  }

  static Widget getChildren_MService(BuildContext context){
    List<Widget> rowAtas = List<Widget>.empty(growable: true);
    // rowAtas.add(const Padding(padding: EdgeInsets.only(left: 20)));
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/gradecustomer.png", "Agreement\nCard", "/agreementcard"));
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/redeem.png", "Request\nCopy\nBPKB", "/copybpkb"));
    rowAtas.add(const Spacer());
    rowAtas.add(subMenu(context, "assets/images/redeem.png", "E-Polis", "/epolis"));
    // rowAtas.add(const Padding(padding: EdgeInsets.only(right: 20)));
    rowAtas.add(const Spacer());
    return Row(
      children: rowAtas,
    );
  }

  static Widget getLogoPutih(){
    return  Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child:   SizedBox(
          width: 120,
          height: 80,
          child: Image.asset(
              "assets/images/ic_jmcare_putih.png"
          ),
        ),
      ),
    );
  }

  static Widget linkMasukOrRegister(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: (){
              Get.offAllNamed(Konstan.rute_login);
            },
            child: const Text(
              "Masuk",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ),
        const Text(" atau "),
        TextButton(
            onPressed: (){
              Get.offAllNamed(Konstan.rute_pilih_register);
            },
            child: const Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ),
      ],
    );
  }

  static Widget widgetWelcome(String imageAsset, String title, bool panahKiri, boolPanahKanan){
    return Row(
      children: [
        Visibility(
          visible: panahKiri,
          child: const Expanded(
              flex: 0,
              child: Icon(Icons.arrow_left)
          ),
        ),
        Expanded(
            flex: 5,
            child: Column(
              children: [
                Image.asset(
                  imageAsset,
                  fit: BoxFit.fill,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            )
        ),
        Visibility(
          visible: boolPanahKanan,
          child: const Expanded(
              flex: 0,
              child: Icon(Icons.arrow_right)
          ),
        ),
      ],
    );
  }

  static Widget slideBox(String url){
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            url,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        )
    );
  }

  static Widget getProdukListView(
      ProdukRespon produkRespon
      ){
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: produkRespon.data == null ? 0 : produkRespon.data!.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: () => Get.toNamed(Konstan.rute_detail_slide, arguments: {'detail': produkRespon.data![index].descriptionId}),
              child: getBoxPromo(
                produkRespon!.data![index].imgUrl2!,
                produkRespon.data![index].nameId!,
                produkRespon.data![index].descriptionId!,
              )
            );
          },
        )
    );
  }

  static Widget getBoxPromo(
      String imageUrl,
      String title,
      String descriptionID
      ){
    return SizedBox(
        height: 200,
        width: 150,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child:  Image.network(
                  imageUrl,
                  height: 130,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                        height: 130,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        )
                    );
                  },
                ),
              ),
              SizedBox(
                  height: 40,
                  child: Center(
                      child:Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                      )
                  ))
            ],
          ),
        ),
    );
  }

  static Widget getPromoListView(PromoRespon promoRespon){
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: promoRespon.data == null ? 0 : promoRespon.data!.length,
          itemBuilder: (context,index){
            return InkWell(
                onTap: () => Get.toNamed(Konstan.rute_detail_slide, arguments: {'detail': promoRespon.data![index].descriptionId}),
                child: getBoxPromo(
                  promoRespon.data![index].imgUrl!,
                  promoRespon.data![index].titleId!,
                  promoRespon.data![index].descriptionId!,
                )
            );
          },
        )
    );
  }

  static Widget teksMerah(String caption){
    return Text(
      caption,
      style: const TextStyle(
          color: Colors.red
      ),
    );
  }

  static Widget teksJudul(String caption){
    return Text(
      caption,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
      ),
    );
  }

  static Widget getTidakAdaData(){
    return const Text("Tidak ada data");
  }

  static Widget getLoadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(Konstan.tag_now_loading, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),)
        ],
      )
    );
  }

}
