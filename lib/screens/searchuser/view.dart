import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/searchuser/logic.dart';

class SearchuserScreen extends StatelessWidget {
  const SearchuserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SearchuserLogic());
    final state = Get.find<SearchuserLogic>().state;
    final nama = Get.arguments['nama'];

    return GetBuilder<SearchuserLogic>(
        assignId: true,
        builder: (logic){
          logic.searchUser(nama);
          return JmcareBarScreen(
              title: "Pencarian User",
              body: Obx(
                      () => (logic.is_loading.value)
                      ? Komponen.getLoadingWidget()
                      : ListView.separated(
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
                            onTap: () => logic.dialogSwitchAccount(context, logic.paginationuserRespon.value, index)
                          );
                        },
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: logic.paginationuserRespon.value.data!.length,
                      )
              )
          );
        }
    );
  }
}
