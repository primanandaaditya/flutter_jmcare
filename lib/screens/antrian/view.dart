import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/antrian/logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/antrian/state.dart';

class AntrianScreen extends StatelessWidget {
  const AntrianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AntrianLogic logic = Get.put(AntrianLogic());
    final AntrianState state = Get.find<AntrianLogic>().state;

    return GetBuilder<AntrianLogic>(
        assignId: true,
        builder: (logic){
          return DefaultTabController(
              length: 3,
              initialIndex: state.selected_index,
              child: Scaffold(
                appBar: Komponen.getAppBar(context, "Antrian Online", const TabBar(
                  tabs: [
                    Tab(text: "Formulir Antrian",),
                    Tab(text: "Riwayat Antrian",),
                    Tab(text: "Antrian Sekarang",),
                  ],)
                ),
                body: TabBarView(
                  children: [

                    //tab pertama => Formulir Antrian
                    //===============================
                    //===============================
                    Form(
                        key: state.formKey,
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            Obx(
                              //jika nilai obsIsDebitur = true, buat dropdown kontrak dan 2 textfield nama & noplat
                              //kalau false, buat container biasa
                                    () => logic.obsIsDebitur.value
                                    ? (logic.is_loading.value
                                    ? Komponen.getLoadingWidget()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                  labelText: "Nomor kontrak",
                                                  icon: Icon(Icons.folder_shared)
                                              ),
                                              isExpanded: true,
                                              value: logic.idxDdNomorKontrak.value,
                                              items: logic.ddNomorKontrak.value,
                                              onChanged: (newValue){
                                                logic.setDDNomorKontrak(newValue);
                                              }) ,

                                          TextFormField(
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                labelText: "Nama",
                                                icon: Icon(Icons.people)
                                            ),
                                            controller: state.tecNama,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                labelText: "Nomor plat",
                                                icon: Icon(Icons.confirmation_number_rounded)
                                            ),
                                            controller: state.tecNomorPlat,
                                          )

                                        ],
                                    )
                                )
                                    : Container()
                            ),

                            TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                  labelText: "Tanggal kedatangan",
                                  icon: Icon(Icons.calendar_month)
                              ),
                              controller: state.tecTanggal,
                              onTap: () => logic.tapTanggal(context),
                            ),

                            TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                  labelText: "Jam kedatangan",
                                  icon: Icon(Icons.watch_later)
                              ),
                              controller: state.tecJam,
                              onTap: () => logic.tapJam(context),
                            ),

                            DropdownButtonFormField(
                                isExpanded: true,
                                decoration: const InputDecoration(
                                    labelText: "PIC tujuan",
                                    icon: Icon(Icons.person)
                                ),
                                value: state.idxKasir,
                                items: state.ddPIC,
                                onChanged: (newValue){
                                  logic.setDDpic(newValue);
                                }) ,

                            TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                  labelText: "Tujuan kedatangan",
                                  icon: Icon(Icons.deck)
                              ),
                              controller: state.tecTujuanKedatangan,
                              onTap: () => logic.tapTujuanKedatangan(),
                            ),

                            TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                  labelText: "Cabang tujuan",
                                  icon: Icon(Icons.house_siding)
                              ),
                              controller: state.tecCabangTujuan,
                              onTap: () => logic.tapPilihCabang(),
                            ),

                            const Padding(padding: EdgeInsets.only(top: 10)),

                            Html(data: state.htmlString),

                            const Padding(padding: EdgeInsets.only(top: 10)),

                            Obx(
                                    () => logic.loadSubmit.value
                                    ? Komponen.getLoadingWidget()
                                    : ElevatedButton(
                                      onPressed: () => logic.submitAntrian(context),
                                        child: const Text(
                                            "Submit"
                                        )
                                )
                            )

                          ],
                        )
                    ),

                    //tab kedua => Riwayat antrian
                    //===============================
                    //===============================
                    Container(
                      padding: const EdgeInsets.all(0),
                      child:  Obx(
                                () => logic.is_loading.value
                                      ? Komponen.getLoadingWidget()
                                      : RefreshIndicator(
                                            child: Column(
                                              children: [
                                                Komponen.pullDowntoRefresh(),
                                                Expanded(
                                                    child: ListView.builder(
                                                        padding: const EdgeInsets.all(20),
                                                        itemCount: logic.riwayats.value.data!.length,
                                                        itemBuilder: (BuildContext context, int index){
                                                          return Komponen.getCardRiwayatantrian(logic.riwayats.value.data![index]);
                                                        }
                                                    ),
                                                )
                                              ],
                                            ),
                                            onRefresh: () async {
                                              logic.getRiwayatAntrian();
                                            }
                                        )
                      ),
                    ),


                    //tab ketiga => Antrian sekarang
                    //===============================
                    //===============================
                    Container(
                      padding: const EdgeInsets.all(0),
                      child:  Obx(
                              () => logic.is_loading.value
                              ? Komponen.getLoadingWidget()
                              : RefreshIndicator(
                                child: Column(
                                  children: [
                                    Komponen.pullDowntoRefresh(),
                                    const Padding(padding: EdgeInsets.only(top: 20)),
                                    SizedBox(
                                      height: 230,
                                      child: Column(
                                        children: [
                                          const Text(
                                              "NOMOR ANTRIAN ANDA",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                              logic.obsNoAntrianAnda.value,
                                            style: const TextStyle(
                                              fontSize: 40,
                                              color: Colors.green
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.green,
                                                width: 8.0,
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Text("Sisa Antrian"),
                                                  Text(
                                                      logic.obsSisaAntrian.value.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 50,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(20),
                                          itemCount: logic.obsRowcountAntriansekarang.value,
                                          itemBuilder: (BuildContext context, int index){
                                            return Komponen.getCardAntrianSekarang(
                                                logic.obsAntrianSekarang.value.data![index],
                                                showAnda: logic.obsAntrianSekarang.value.data![index].iDUSERJMCARE.toString() == state.userID.toString()
                                            );
                                          }
                                      ),
                                    )
                                  ],
                                ),
                                onRefresh: () async {
                                  logic.getAntrianSekarang();
                                }
                          )
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
