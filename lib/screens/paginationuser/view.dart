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
          logic.addListen();
          return JmcareBarScreen(
              title: "Pilih User",
              body: Obx(
                      () => (logic.is_loading.value)
                      ? Komponen.getLoadingWidget()
                      : Column(
                        children: [
                            TextField(
                              controller: logic.state.tecSearch,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () => logic.search(),
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
                                      leading: const Icon(Icons.people),
                                      title: Text(logic.paginationuserRespon.value.data![index].namaUser!),
                                      subtitle: Text(logic.paginationuserRespon.value.data![index].email!),
                                      onTap: () => logic.dialogSwitchAccount(context, logic.paginationuserRespon.value, index),
                                    );
                                  },
                                  key: logic.state.pageStorageKey,
                                  controller: logic.state.scrollController,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: logic.paginationuserRespon.value.data!.length,
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
