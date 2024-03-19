import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/dialog/tujuan_kedatangan/logic.dart';
import 'package:jmcare/screens/dialog/tujuan_kedatangan/state.dart';

class DialogTujuankedatangan extends StatelessWidget {
  const DialogTujuankedatangan({super.key});

  @override
  Widget build(BuildContext context) {
    final TujuankedatanganLogic logic = Get.put(TujuankedatanganLogic());
    final TujuankedatanganState state = Get.find<TujuankedatanganLogic>().state;

    return GetBuilder<TujuankedatanganLogic>(
      assignId: true,
        builder: (logic){
        return JmcareBarScreen(
          title: "Pilih tujuan kedatangan",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: state.tecSearch,
                onChanged: (a) => logic.filter(),
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search)
                ),
              ),

              Obx(
                      () => logic.is_loading.value
                          ? Komponen.getLoadingWidget()
                          : Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context,index){
                                  return const Divider(
                                    color: Colors.grey,
                                  );
                                },
                                itemBuilder: (context, index){
                                  return ListTile(
                                    onTap: () => logic.tapListView(index),
                                    trailing: const Icon(Icons.arrow_right),
                                    title: Text(logic.kategoris.value.data![index].kATEGORI!),
                                  );
                                },
                                itemCount: logic.jmlRow.value,
                              )
                            )
              ),
            ],
          ),
        );
        }
    );
  }
}
