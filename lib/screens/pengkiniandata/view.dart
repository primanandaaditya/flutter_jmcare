import 'dart:isolate';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/helper/Konstan.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pengkiniandata/logic.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';


class PengkiniandataScreen extends StatelessWidget {
  const PengkiniandataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PengkiniandataLogic());
    final state = Get.find<PengkiniandataLogic>().state;

    return GetBuilder<PengkiniandataLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Pengkinian Data",
            body: Obx(
                    () => logic.is_loading.value
                        ? Komponen.getLoadingWidget()
                        : Form(
                            key: state.formKey,
                            child: ListView(
                              children: [

                                TextFormField(
                                  controller: state.tecNama,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: "Nama sesuai KTP (tanpa gelar)"
                                  ),
                                ),
                                TextFormField(
                                  controller: state.tecNIK,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: "Nomor KTP"
                                  ),
                                ),
                                TextFormField(
                                  controller: state.tecTempatlahir,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: "Tempat kelahiran"
                                  ),
                                ),
                                TextFormField(
                                  controller: state.tecTgllahir,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: "Tanggal lahir"
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: state.tecNPWP,
                                  decoration: const InputDecoration(
                                      labelText: "NPWP"
                                  ),
                                ),
                                TextFormField(
                                  controller: state.tecNamaibukandung,
                                  decoration: const InputDecoration(
                                      labelText: "Nama ibu kandung"
                                  ),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecPendidikan,
                                  decoration: const InputDecoration(
                                      labelText: "Pendidikan terakhir",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: (){
                                    logic.dialogJMO(Konstan.tag_pendidikan);
                                  },
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecStatusnikah,
                                  decoration: const InputDecoration(
                                      labelText: "Status pernikahan",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: (){
                                    logic.dialogJMO(Konstan.tag_status_nikah);
                                  },
                                ),
                                TextFormField(
                                  buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                                  maxLength: 16,
                                  keyboardType: TextInputType.phone,
                                  controller: state.tecHP,
                                  decoration: const InputDecoration(
                                      labelText: "Nomor HP aktif"
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: state.tecJumlahtanggungan,
                                  decoration: const InputDecoration(
                                      labelText: "Jumlah tanggungan"
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 10)),
                                const Text("Kewarganegaraan"),
                                Row(
                                  children: [
                                    Expanded(child: RadioListTile(
                                        title: const Text("WNI"),
                                        value: state.options_kewarganegaraan[0],
                                        groupValue: state.current_option_kewarganegaraan,
                                        onChanged: (value){
                                          logic.handleOptionKewarganegaraan(value!);
                                        }
                                    ),),
                                    Expanded(child: RadioListTile(
                                        title: const Text("WNA"),
                                        value: state.options_kewarganegaraan[1],
                                        groupValue: state.current_option_kewarganegaraan,
                                        onChanged: (value){
                                          logic.handleOptionKewarganegaraan(value!);
                                        }
                                    )),
                                  ],
                                ),
                                TextFormField(
                                  controller: state.tecAlamat,
                                  decoration: const InputDecoration(
                                      labelText: "Alamat"
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(child: TextFormField(
                                      buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      controller: state.tecRT,
                                      decoration: const InputDecoration(
                                          labelText: "RT",
                                      ),
                                    ),),
                                    Expanded(child: TextFormField(
                                      buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      controller: state.tecRW,
                                      decoration: const InputDecoration(
                                          labelText: "RW"
                                      ),
                                    ),)

                                  ],
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecPropinsi,
                                  decoration: const InputDecoration(
                                      labelText: "Propinsi",
                                    suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: () => logic.dialogWilayah(Konstan.tag_propinsi),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecKabupaten,
                                  decoration: const InputDecoration(
                                      labelText: "Kabupaten",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: () => logic.dialogWilayah(Konstan.tag_kabupaten),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecKecamatan,
                                  decoration: const InputDecoration(
                                      labelText: "Kecamatan",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: () => logic.dialogWilayah(Konstan.tag_kecamatan),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecKelurahan,
                                  decoration: const InputDecoration(
                                      labelText: "Kelurahan",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: () => logic.dialogWilayah(Konstan.tag_kelurahan),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: state.tecPekerjaan,
                                  decoration: const InputDecoration(
                                      labelText: "Pekerjaan",
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined)
                                  ),
                                  onTap: (){
                                    logic.dialogJMO(Konstan.tag_jenis_pekerjaan);
                                  },
                                ),
                                TextFormField(
                                  controller: state.tecAlamatkantor,
                                  decoration: const InputDecoration(
                                      labelText: "Alamat kantor"
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: state.tecTelpkantor,
                                  decoration: const InputDecoration(
                                      labelText: "Telepon kantor"
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 20)),

                                InkWell(
                                  onTap: (){
                                    logic.showPicker(context, "KTP");
                                  },
                                  child: DottedBorder(
                                    color: Colors.grey,
                                    dashPattern: const [8, 4],
                                    strokeWidth: 2,
                                    child: SizedBox(
                                        height: 150,
                                        child: Stack(
                                          children: [
                                            state.imageKTP == null
                                                ? const Align(alignment: Alignment.center, child: Text("Tap disini untuk mengambil foto KTP", style: TextStyle(color: Colors.grey),) )
                                                : Align(alignment: Alignment.center,child: Image.file(state.imageKTP!)),
                                            Align(
                                                alignment: Alignment.bottomRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: (){
                                                    logic.clearFoto("KTP");
                                                  },
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                InkWell(
                                  onTap: (){
                                    logic.showPicker(context, "Profil");
                                  },
                                  child: DottedBorder(
                                    color: Colors.grey,
                                    dashPattern: const [8, 4],
                                    strokeWidth: 2,
                                    child: SizedBox(
                                        height: 150,
                                        child: Stack(
                                          children: [
                                            state.imageProfil == null
                                                ? const Align(alignment: Alignment.center, child: Text("Tap disini untuk mengambil foto profil", style: TextStyle(color: Colors.grey),) )
                                                : Align(alignment: Alignment.center,child: Image.file(state.imageProfil!)),
                                            Align(
                                                alignment: Alignment.bottomRight,
                                                child: IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: (){
                                                    logic.clearFoto("Profil");
                                                  },
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ),

                                CheckboxListTile(
                                  title: const Text("Saya bersedia menerima penawaran produk"),
                                    value: state.is_check_penawaran,
                                    onChanged: (bool? newValue){
                                      logic.handleCekpenawaran(newValue!);
                                    },
                                  tristate: false,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  title: Text(state.title_pernyataan),
                                  value: state.is_check_pernyataan,
                                  onChanged: (bool? newValue){
                                    logic.handleCekpernyataan(newValue!);
                                  },
                                  tristate: false,
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                const Text("Tanda tangan di bawah", textAlign: TextAlign.center,),
                                const Padding(padding: EdgeInsets.only(top: 5)),

                                DottedBorder(
                                  color: Colors.grey,
                                  dashPattern: const [8, 4],
                                  strokeWidth: 2,
                                  child: SizedBox(
                                    height: 150,
                                    child: Stack(
                                      children: [
                                        SfSignaturePad(
                                          key: state.signatureGlobalKey,
                                          backgroundColor: Colors.white,
                                          strokeColor: Colors.black,
                                          minimumStrokeWidth: 3.0,
                                          maximumStrokeWidth: 5.0,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                            child: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: (){
                                                logic.clearSignature();
                                              },
                                            )
                                        )
                                      ],
                                    )
                                  ),
                                ),

                                const Padding(padding: EdgeInsets.only(top: 10)),

                                ElevatedButton(
                                    onPressed: () => logic.submit(),
                                    child: const Text("Submit", style: TextStyle(color: Colors.white),)
                                )
                              ],
                            ),
                          )
            ),
          );
        }
    );
  }

  // void myIsolateFunction(SendPort sendPort){
  //   int result = 0;
  //   for (int i = 0; i < 10000; i++){
  //     result += i;
  //   }
  //   sendPort.send(result);
  // }
  // void isolasi() async {
  //
  //   print("Mulai isolasi...");
  //   ReceivePort receivePort = ReceivePort();
  //   Isolate.spawn(myIsolateFunction, receivePort.sendPort);
  //   int isolateResult = await receivePort.first;
  //   print ("Hasil isolasi adalah $isolateResult");
  // }

}

