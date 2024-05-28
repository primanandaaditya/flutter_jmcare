import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/antrian/detailriwayat/logic.dart';
import 'package:jmcare/screens/antrian/detailriwayat/state.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

class DetailRiwayatAntrian extends StatelessWidget {
  const DetailRiwayatAntrian({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailRiwayatLogic logic = Get.put(DetailRiwayatLogic());
    final DetailriwayatState state = Get.find<DetailRiwayatLogic>().state;

    return GetBuilder<DetailRiwayatLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Detail Riwayat Antrian",
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [

                Row(
                  children: [
                    const Icon(
                        Icons.calendar_month,
                      color: Colors.green,
                    ),
                    Text(state.tanggal),
                    const Spacer(),
                    Text(state.jam),
                    const Icon(
                      Icons.watch,
                      color: Colors.green,
                    )
                  ],
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          const Text("Nomor kontrak"),
                          Text(" : ${state.agreement_no}")
                        ]
                      ),
                      TableRow(
                          children: [
                            const Text("Nama"),
                            Text(" : ${state.nama}")
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Nomor plat"),
                            Text(" : ${state.nomor_plat}")
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("PIC tujuan"),
                            Text(" : ${state.pic}")
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Tujuan kedatangan"),
                            Text(" : ${state.tujuan}")
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Kantor cabang"),
                            Text(" : ${state.office_name}")
                          ]
                      )
                    ],
                  )
                ),
                const Divider(),
                const Text(
                    "NO. ANTRIAN",
                  textAlign: TextAlign.center,
                ),
                Text(
                    state.token,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.green
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Text("Silakan kunjungi kantor cabang dan lakukan konfirmasi kedatangan untuk mendapatkan pelayanan."),
                const Divider(),

                const Padding(padding: EdgeInsets.only(top: 20)),
                //cek apakah tanggal antrian sama dengan hari ini
                Obx(
                        () => logic.isToday.value //jika ini hari yang sama

                            ? logic.obxGpsSearching.value //searching lokasi
                              ? Komponen.getGpsLoading()

                              //jika jarak lebih dari 200 meter
                              : logic.obxJarak.value >= 0.02
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: const [
                                      Text("Anda belum berada di kantor cabang tujuan",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                        ),),
                                      ElevatedButton(
                                          onPressed: null,
                                          child: Text("KONFIRMASI KEDATANGAN")
                                      )
                                    ],
                                  )

                                //jika jarak <= 200 meter dari kantor tujuan
                                //cek dulu apakah sudah konfirmasi kedatangan
                                : state.konfirmasi_kedatangan == "1"
                                  ? Container()
                                  : ElevatedButton(
                                    onPressed: (){
                                      logic.konfirmasiKedatangan();
                                    },
                                    child: const Text("KONFIRMASI KEDATANGAN")
                                )

                            : Container()

                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                
                Obx(() => (!logic.obxButtonKuisioner.value)
                    ? Container()
                    : ElevatedButton(
                      onPressed: (){
                        logic.tampilKuisioner();
                      },
                      child: const Text("SURVEY KEPUASAN PELANGGAN")
                  )
                ),

              ],
            ),
          );
        }
    );
  }
}
