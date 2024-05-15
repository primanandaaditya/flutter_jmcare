import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/dialog/jmo/logic.dart';

class DialogjmoScreen extends StatelessWidget {
  const DialogjmoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final logic = Get.put(DialogjmoLogic());
    final state = Get.find<DialogjmoLogic>().state;

    return GetBuilder<DialogjmoLogic>
      (
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Pilih Data",
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
                                    leading: const Icon(Icons.dataset),
                                    trailing: const Icon(Icons.arrow_right),
                                    title: Text(
                                        (logic.obsJmoRespon.value.data![index].name == null)
                                            ? logic.obsJmoRespon.value.data![index].nama!
                                            : logic.obsJmoRespon.value.data![index].name!
                                    ),
                                    onTap: (){
                                      logic.selectData(index);
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
