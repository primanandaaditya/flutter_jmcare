import 'package:flutter/material.dart';
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
              child: Scaffold(
                appBar: Komponen.getAppBar(context, "Antrian Online", const TabBar(
                  tabs: [
                    Tab(text: "Ambil Antrian",),
                    Tab(text: "Riwayat Antrian",),
                    Tab(text: "Antrian Sekarang",),
                  ],
                )
                ),
                body: TabBarView(
                  children: [
                    Form(
                      key: state.formKey,
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            Obx(
                                    () => logic.is_loading.value
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


                          ],
                        )
                    ),

                    Center(
                      child: Text("Dua"),
                    ),
                    Center(
                      child: Text("Tiga"),
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}
