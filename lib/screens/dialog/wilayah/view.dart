import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/dialog/wilayah/logic.dart';

class DialogWilayahScreen extends StatelessWidget {
  const DialogWilayahScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(DialogWilayahLogic());
    final state = Get.find<DialogWilayahLogic>().state;

    return GetBuilder<DialogWilayahLogic>
      (
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Pilih Wilayah",
            body: Obx(
                () => logic.is_loading.value
                    ? Komponen.getLoadingWidget()
                    : Column(
                        children: [
                          TextFormField(
                            controller: state.tecSearch,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    logic.filter();
                                  },
                                  icon: const Icon(Icons.search)
                              )
                            ),
                          ),
                          Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index){
                                  return const Divider(
                                    color: Colors.grey,
                                  );
                                },
                                itemBuilder: (context, index){
                                  return ListTile(
                                    leading: const Icon(Icons.account_balance_rounded),
                                    trailing: const Icon(Icons.arrow_right),
                                    title: Text(logic.ObsWilayahResponse.value.data![index].nama!),
                                    onTap: (){
                                      logic.selectWilayah(index);
                                    },
                                  );
                                },
                                itemCount: logic.rowCount.value,
                              )
                          )
                        ],
                      )
            ),
          );
        }
    );
  }
}
