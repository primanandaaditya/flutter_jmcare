import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/dialog/list_cabang/logic.dart';
import 'package:jmcare/screens/dialog/list_cabang/state.dart';

class DialogCabang extends StatelessWidget {
  const DialogCabang({super.key});

  @override
  Widget build(BuildContext context) {
    //untuk dialogcabangLogic langsung extend ke CabangLogic, bukan BaseLogic lagi...
    final DialogcabangLogic logic = Get.put(DialogcabangLogic());
    final DialogcabangState state = Get.find<DialogcabangLogic>().state;

    return GetBuilder<DialogcabangLogic>(
      assignId: true,
        builder: (logic){
          return JmcareBarScreen(
              title: "Pilih cabang tujuan",
              body: Obx(
                      () => logic.is_loading.value
                      ? Komponen.getLoadingWidget()
                      : Column(
                        children: [
                          TextField(
                            onChanged: (a) => logic.filter(),
                            controller: state.tecSearch,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.search),
                            ),
                          ),
                          logic.cabangRespon.value.data!.isEmpty || logic.cabangRespon.value.data!.length == 0 || logic.cabangRespon.value == null || logic.cabangRespon.value.data == null
                              ? Center(child: Komponen.getTidakAdaData())
                              : Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index){
                                    return const Divider(
                                      color: Colors.grey,
                                    );
                                  },
                                  itemBuilder: (context, index){
                                    return ListTile(
                                        leading: const Icon(Icons.home),
                                        title: Text(logic.cabangRespon.value.data![index].oFFICENAME!),
                                        subtitle:Row(
                                          children: [
                                            Text(logic.cabangRespon.value.data![index].pHONE!),
                                            const Icon(Icons.phone, size: 15)
                                          ],
                                        ),
                                        onTap: () => logic.tapListView(index)
                                    );
                                  },
                                  itemCount: logic.jmlRow.value,
                              )
                          ),
                        ],
                      )
              )
          );
        }
    );
  }
}
