import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/helper/Warna.dart';
import 'package:jmcare/model/api/AgreementcardRespon.dart';
import 'package:jmcare/model/api/PilihkontrakRespon.dart' as pilihkontrak;
import 'package:jmcare/model/api/ProdukRespon.dart';
import 'package:jmcare/model/api/PromoRespon.dart';
import 'package:jmcare/model/api/RiwayatantrianRespon.dart' as riwayatantrian;
import 'package:jmcare/model/api/AntriansekarangRespon.dart' as antriansekarang;
import 'package:get/get.dart';

class Komponen{

  static Widget pullDowntoRefresh(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
            Icons.refresh,
          color: Colors.green,
        ),
        Text("Pull down to refresh"),
      ],
    );
  }

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
      String title,
      [PreferredSizeWidget? bottomTab]
      ){
    return AppBar(
      bottom: bottomTab,
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
      Function onLogout,
      Function onDeleteAccount
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
          ListTile(
            tileColor: Colors.white,
            title: const Text('Hapus akun'),
            onTap: () {
              onDeleteAccount();
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
      Function klik
      ){

    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: (){
              klik();
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

  static Widget getCardAntrianSekarang(antriansekarang.Data respon, {bool? showAnda}){
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.person),
            const VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( "Nama \t\t\t\t\t\t\t\t\t\t: ${respon.nAMAPENGUNJUNG!}"),
                Text( "No. antrian \t: ${respon.nOANTRIAN!}"),
                Text(respon.sTATUSPROGRESS!, style: const TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            const Spacer(),
            showAnda == true ? const RawChip(label: Text("ANDA",style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,) : Container()
          ],
        )
      ),
    );
  }

  static Widget getCardRiwayatantrian(riwayatantrian.Data respon){
    return InkWell(
      onTap: () => Get.toNamed(
          Konstan.rute_detail_riwayat_antrian,
          arguments: {
            Konstan.tag_agreement_no : respon.aGRMNTNO.toString(),
            Konstan.tag_nomor_plat : respon.nOPLAT.toString(),
            Konstan.tag_tanggal : respon.tGLKEDATANGAN.toString(),
            Konstan.tag_tgl : respon.tANGGAL.toString(),
            Konstan.tag_jam : respon.jAMKEDATANGAN.toString(),
            Konstan.tag_office_name : respon.oFFICENAME.toString(),
            Konstan.tag_nama : respon.nAMADEBITUR.toString(),
            Konstan.tag_pic : respon.pICTUJUAN.toString(),
            Konstan.tag_tujuan : respon.tUJUANKEDATANGAN.toString(),
            Konstan.tag_token : respon.nOANTRIAN.toString(),
            Konstan.tag_id : respon.iD.toString(),
            Konstan.tag_is_finished : respon.iSFINISHED.toString(),
            Konstan.tag_konfirmasi_kedatangan : respon.kONFIRMASIKEDATANGAN.toString(),
            Konstan.tag_sudah_kuisioner : respon.sUDAHKUISIONER.toString(),
            Konstan.tag_office_lat : respon.oFFICELAT.toString().replaceAll("\r\n", ""),
            Konstan.tag_office_long : respon.oFFICELONG.toString().replaceAll("\r\n", "")
          }
      ),
      child: Card(
          color: respon.sUDAHKADALUWARSA! > 0 ? Colors.grey : null,
          elevation: 5.0,
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                        size: 50,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        respon.tGLKEDATANGAN!.substring(0,2),
                        style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.watch,
                                size: 15,
                                color: Colors.green,
                              ),
                              Text(respon.jAMKEDATANGAN!)
                            ],
                          ),
                          Text(respon.tGLKEDATANGAN!.substring(3,11).replaceAll("-", " "))
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            respon.nOPLAT!.replaceAll("\r\n", ""),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          const Divider(height: 1, color: Colors.green,),
                          Text(
                              respon.oFFICENAME!
                          )
                        ],
                      )
                    ],
                  ),
                  const Divider(height: 1.0, color: Colors.grey,),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text("NOMOR ANTRIAN"),
                  Text(respon.nOANTRIAN!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.green
                    ),),

                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Divider(height: 1.0, color: Colors.grey,),
                  Row(
                    children: [
                      respon.iSFINISHED! == "0"
                          ? Container()
                          : const Chip(
                            label: Text("SELESAI"),
                            labelStyle: TextStyle(
                                color: Colors.green
                            ),
                      ),
                      const Spacer(),

                      respon.iSFINISHED! == "0"
                          ? chipKuisioner_TidakTersedia()
                          : respon.sUDAHKUISIONER! == 0
                            ? chipKuisioner_Tersedia()
                            : chipKuisioner_TidakTersedia()
                    ],
                  ),

                ],
              )
          )
      )
    );
  }

  static Widget chipKuisioner_Tersedia(){
    return const Chip(
      label: Text("Survey tersedia", style: TextStyle(fontSize: 10),),
      backgroundColor: Colors.purple,
      labelStyle: TextStyle(
          color: Colors.white
      ),
    );
  }

  static Widget chipKuisioner_TidakTersedia(){
    return const Chip(
      elevation: 1.0,
        label: Text("Survey tidak tersedia", style: TextStyle(fontSize: 10),),
        backgroundColor: Colors.deepOrange,
        labelStyle: TextStyle(
        color: Colors.white
        ));
  }

  static Widget getCardKontrak(pilihkontrak.Data respon){
    return Card(
        elevation: 5.0,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child:  Table(
                    border: TableBorder.symmetric(outside: BorderSide.none),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: const Text("No. agreement")
                              )
                          ),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: Text(" : ${respon.aGRMNTNO}")
                              )
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: const Text("No. plat")
                              )
                          ),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: Text(" : ${respon.pLATNO}")
                              )
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: const Text("Merk/tipe")
                              )
                          ),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: const EdgeInsets.all(Konstan.tag_padding_cell),
                                  child: Text(
                                    " : ${respon.merkType}",
                                    maxLines: 3,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  )
                              )
                          ),
                        ],
                      ),
                    ],
                  )),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.chevron_right)
              )
            ],
          ),
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
    // rowAtas.add(const Spacer());
    // rowAtas.add(subMenu(context, "assets/images/gradecustomer.png", "Topup\nPlafond", "/topupplafond"));
    // rowAtas.add(const Spacer());
    // rowAtas.add(subMenu(context, "assets/images/redeem.png", "Renewal\nAsuransi", "/renewalasuransi"));
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
                produkRespon.data![index].imgUrl2!,
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

  static Widget getGpsLoading(){
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            LinearProgressIndicator(),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(Konstan.tag_gps_searching, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),)
          ],
        )
    );
  }

  static Widget getDownloadWidget(){
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            LinearProgressIndicator(),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(Konstan.tag_downloading, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),)
          ],
        )
    );
  }

  static TableRow getRowSpacer(double tinggi){
    return TableRow(
      children: <Widget>[
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(height: tinggi,)
        ),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(height: tinggi,)
        ),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.top,
            child: SizedBox(height: tinggi,)
        ),
      ],
    );
  }

  static Widget getWidgetAgreementCard(String judul, String subjudul, String angka){

    Random random = Random();
    int i = random.nextInt(5);
    debugPrint(i.toString());

    late Color c;
    switch(i) {
      case 0: {
        c=Colors.green;
      }
      break;
      case 1: {
        c=Colors.orange;
      }
      break;
      case 2: {
        c=Colors.red;
      }
      break;
      case 3: {
        c=Colors.black;
      }
      break;
      case 4: {
        c=Colors.purple;
      }
      break;
      default: {
        c=Colors.green;
      }
      break;
    }

    return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              judul,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            Flexible(child: Divider(color: c, thickness: 1.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subjudul,
                  style: const TextStyle(
                      fontSize: 10.0
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  angka,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16.0
                  ),
                )

              ],
            )
          ],
        )
    );
  }

  static Widget getWidgetHeaderAgreementCard(BuildContext context, AgreementcardRespon respon){

    var header = respon.data!.first;
    return  Container(
        padding: const EdgeInsets.all(20),
        child:   Table(

          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FixedColumnWidth(10),
            2: IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(

              children: <Widget>[

                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Tanggal kontrak", "", header.dUEDT!),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Kantor cabang","", header.oFFICENAME!),
                ),

              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[

                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Nomor kontrak", "", header.aGRMNTNO!),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Atas nama", "", header.cUSTNAME!),
                ),

              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[

                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Denda dibayarkan", Konstan.tag_rupiah, Fungsi.formatNumberDouble(header.lCINSTPAIDAMTAAM!)),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Hutang biaya", Konstan.tag_rupiah, Fungsi.formatNumberDouble(header.vISITFEE!)),
                ),
              ],
            ),
            Komponen.getRowSpacer(20),
            TableRow(
              children: <Widget>[

                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Komponen.getWidgetAgreementCard("Sisa denda keterlambatan", Konstan.tag_rupiah, Fungsi.formatNumberDouble( header.oSLCINST!)),
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()
                ),
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Container()
                ),

              ],
            ),
          ],
        )
    );
  }


}
