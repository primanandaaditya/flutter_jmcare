import 'package:flutter/material.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/agreementcard/logic.dart';
import 'package:get/get.dart';
import 'package:jmcare/screens/agreementcard/state.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

class AgreementcardScreen extends StatelessWidget {
  const AgreementcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AgreementcardLogic logic = Get.put(AgreementcardLogic());
    final AgreementcardState state = Get.find<AgreementcardLogic>().state;

    return GetBuilder<AgreementcardLogic>(
      assignId: true,
        builder: (logic){
        return JmcareBarScreen(
          title: "Agreement Card",
          body: Obx(
                  () => logic.is_loading.value
                      ? Komponen.getLoadingWidget()
                      : ListView(
                        children: [
                          Komponen.getWidgetHeaderAgreementCard(context, logic.agreementCard.value),
                          const Padding(padding: EdgeInsets.only(bottom: 10)),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                border: TableBorder.all(color: Colors.green.shade200),
                                headingTextStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                ),
                                columns: logic.getColumns(),
                                rows: logic.getRows()
                            ),
                          )
                        ],
                      )
          )
        );
        }
    );
  }
}
