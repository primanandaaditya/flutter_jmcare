import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/pilihkontrak/logic.dart';
import 'package:jmcare/screens/pilihkontrak/state.dart';

class PilihkontrakScreen extends StatelessWidget {
  const PilihkontrakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PilihkontrakLogic logic = Get.put(PilihkontrakLogic());
    final PilihkontrakState state = Get.find<PilihkontrakLogic>().state;
    return GetBuilder<PilihkontrakLogic>(
      assignId: true,
        builder: (logic){
        return JmcareBarScreen(
          title: "Pilih Nomor Kontrak",
          body: Obx(
              () => logic.is_loading.value
                  ? Komponen.getLoadingWidget()
                  : Column(
                      children: [

                        TextField(
                          controller: state.tecSearch,
                          decoration: InputDecoration(
                            hintText: "Cari nomor kontrak",
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () => logic.filter(),
                            )
                          ),
                        ),

                        logic.is_download.value
                        ? Komponen.getDownloadWidget()
                        : Container(),

                        const Padding(padding: EdgeInsets.only(top: 10)),

                        logic.pilihKontrak.value.data!.isEmpty || logic.pilihKontrak.value.data == null || logic.pilihKontrak.value == null || logic.pilihKontrak.value.data == null
                        ? Center(child: Komponen.getTidakAdaData(),)
                        : Expanded(
                            child: ListView.builder(
                                itemCount: logic.jmlRow.value,
                                itemBuilder: (context,index){
                                  return InkWell(
                                    child:  Komponen.getCardKontrak(logic.pilihKontrak.value.data![index]),
                                    onTap: (){
                                      logic.detail(index);
                                    },
                                  ) ;
                                }
                            )
                        )
                      ],
                    )
          )
        );
        }
    );
  }
}
