import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'logic.dart';

class PaginationuserScreen extends StatelessWidget {
  const PaginationuserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PaginationuserLogic());
    final state = Get.find<PaginationuserLogic>().state;

    return GetBuilder<PaginationuserLogic>(
        assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Pilih User",
            body: Obx(
                () => logic.is_loading.value
                    ? Komponen.getLoadingWidget()
                    : ListView.separated(
                      separatorBuilder: (context, index){
                        return const Divider(
                          color: Colors.grey,
                        );
                      },

                      itemBuilder: (context, index){
                        return ListTile(
                          leading: Icon(Icons.people),
                          title: Text(logic.paginationuserRespon.value.data![index].namaUser!),
                          subtitle: Text(logic.paginationuserRespon.value.data![index].email!),
                        );
                      },
                      itemCount: logic.paginationuserRespon.value.data!.length,
                    )
            )
          );
        }
    );
  }
}
