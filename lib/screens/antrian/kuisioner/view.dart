import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/antrian/kuisioner/logic.dart';
import 'package:jmcare/screens/antrian/kuisioner/state.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

import '../../../model/api/ChoicechipModel.dart';

class KuisionerScreen extends StatelessWidget {
  const KuisionerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final KuisionerLogic logic = Get.put(KuisionerLogic());
    final KuisionerState state = Get.find<KuisionerLogic>().state;

    return GetBuilder<KuisionerLogic>
      (assignId: true,
        builder: (logic){
          return JmcareBarScreen(
            title: "Kuisioner Antrian",
            body: Container(
              padding: const EdgeInsets.all(0),
              child: Obx(
                      () => logic.load_get_kuisioner.value
                          ? Komponen.getLoadingWidget()
                          : ListView.separated(
                              padding: const EdgeInsets.all(0),
                              separatorBuilder: (context, index){
                                return const Divider(
                                  color: Colors.grey,
                                );
                              },
                              itemBuilder: (context, index){
                                return Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAAN!),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "1" || logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "2"
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan.isNull //baris 379
                                            ? Builder(builder: (context){
                                                state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!] = '';
                                                return TextField(
                                                  onChanged: (s){
                                                    logic.handleTextField(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!, s);
                                                  },
                                                );
                                              })
                                            :  Column(
                                                children: [
                                                  Builder(builder: (context){
                                                    for (var i in logic.obxPertanyaan.value.data![index].subPertanyaan!){
                                                      //simpan jawaban kalau user mengetik
                                                      //kalau ada subpertanyaan, hash dikasih tanda ; digabung IDvalue, nanti waktu dilempar ke API
                                                      //displit, supaya bisa masuk column PERTANYAAN_CODE dan VALUE_ID
                                                      state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!] = "";
                                                      return Column(
                                                        children: [
                                                          Text(i.labelPertanyaan!.vALUE!),
                                                          TextField(
                                                            onChanged: (s){
                                                              logic.handleTextField(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!, s);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                    return Container();
                                                  })
                                                ],
                                            )
                                            : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "3"
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan == null
                                              ? Container()
                                              : (logic.obxPertanyaan.value.data![index].subPertanyaan!.length == 1 && logic.obxPertanyaan.value.data![index].subPertanyaan![0].labelPertanyaan == null ) //baris 466
                                                ? (logic.obxPertanyaan.value.data![index].subPertanyaan![0].templateJawaban == null)
                                                  ? Container()
                                                  : Wrap(
                                                      spacing: 5.0,
                                                      children: [
                                                        for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan![0].templateJawaban! )
                                                          ChoiceChip(
                                                              selectedColor: Colors.green,
                                                              label: Text(i.vALUEJAWABAN!),
                                                              selected: logic.choiceModels.where((e) => e.id == i.iDOPSI!).first.selected!,
                                                              onSelected: (s){
                                                                logic.clickChoiceChipSingle(i.iDOPSI!, i.pERTANYAANCODE!);
                                                              }
                                                          ),
                                                      ],
                                                    )
                                                : logic.obxPertanyaan.value.data![index].subPertanyaan == null
                                                  ? Container()
                                                  : Column(
                                                    children: [
                                                      for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan! )
                                                        Wrap(
                                                          spacing: 5.0,
                                                          children: [
                                                            for ( var j in i.templateJawaban! )
                                                              ChoiceChip(
                                                                  selectedColor: Colors.green,
                                                                  label: Text(j.vALUEJAWABAN!),
                                                                  selected: logic.choiceModels.where((e) => e.id == j.iDOPSI!).first.selected!,
                                                                  onSelected: (s){
                                                                    logic.clickChoiceChipSingle(j.iDOPSI!, j.pERTANYAANCODE!);
                                                                  }
                                                              ),
                                                          ],
                                                        )
                                                    ],
                                                  )
                                                  : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "4"
                                            ? Text("Radio group")
                                            : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "5"
                                            ? Text("Range slider")
                                            : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "6"
                                            ? Text("Switch")
                                            : Container(),

                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: logic.obxPertanyaan.value.data!.length,
                            )
              ),
            )
          );
        }
    );
  }
}
