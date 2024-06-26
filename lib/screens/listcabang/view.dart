import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/listcabang/logic.dart';
import 'package:jmcare/screens/listcabang/state.dart';

class CabangScreen extends StatelessWidget {
  const CabangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CabangLogic logic = Get.put(CabangLogic());
    final CabangState state = Get.find<CabangLogic>().state;
    return GetBuilder<CabangLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Daftar Kantor Cabang",
            body: Obx(
                () => logic.is_loading.value
                    ? Komponen.getLoadingWidget()
                    : Column(
                      children: [
                        TextField(
                          onChanged: (a) => logic.filter(),
                          controller: state.tecSearch,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.search)
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
                                      onTap: () => logic.openMap(index)
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
