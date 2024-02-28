import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Fungsi.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';
import 'package:jmcare/screens/historipoin/logic.dart';
import 'package:jmcare/screens/historipoin/state.dart';

class HistoripoinScreen extends StatelessWidget {
  const HistoripoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoripoinLogic logic = Get.put(HistoripoinLogic());
    final HistoripoinState state = Get.find<HistoripoinLogic>().state;
    return GetBuilder<HistoripoinLogic>(
      assignId: true,
        builder: (logic){
        return JmcareBarScreen(
          title: "Histori Point",
          body: Obx(
              () => logic.is_loading.value
                  ? Komponen.getLoadingWidget()
                  : logic.historipoinRespon.value.data==null || logic.historipoinRespon.value.data!.isEmpty
                    ? Center(child: Komponen.getTidakAdaData())
                    : ListView.separated(
                        separatorBuilder: (context, index){
                          return const Divider(
                            color: Colors.grey,
                          );
                        },
                        itemBuilder: (context, index){
                          return ListTile(
                            leading: const Icon(Icons.card_giftcard),
                            title: Text(logic.historipoinRespon.value.data![index].itemName!),
                            subtitle: Text(Fungsi.formatNumber(logic.historipoinRespon.value.data![index].point,0))
                          );
                        },
                        itemCount: logic.historipoinRespon.value.data!.length,
                      )
          )
        );
        }
    );
  }
}
