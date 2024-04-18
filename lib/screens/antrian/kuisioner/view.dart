import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jmcare/helper/Komponen.dart';
import 'package:jmcare/screens/antrian/kuisioner/logic.dart';
import 'package:jmcare/screens/antrian/kuisioner/state.dart';
import 'package:jmcare/screens/base/jmcare_bar_screen.dart';

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
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:[
                            Expanded(child: ListView.separated(
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAAN!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "1" || logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "2"
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan.isNull //baris 379
                                              ? TextField(
                                                  onChanged: (s){
                                                    logic.handleTextField(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!, s);
                                                  },
                                                )
                                              :  Column(
                                                  children: [
                                                    for (var i in logic.obxPertanyaan.value.data![index].subPertanyaan!)
                                                      Column(
                                                        children: [
                                                          Text(i.labelPertanyaan!.vALUE!),
                                                          TextField(
                                                            onChanged: (s){
                                                              logic.handleTextField(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!, s);
                                                            },
                                                          )
                                                        ],
                                                      )
                                                  ])
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
                                                            avatar: logic.choiceModels.where((e) => e.id == i.iDOPSI!).first.selected! ? const Icon(Icons.check_outlined, color: Colors.white) : null,
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
                                                              avatar: logic.choiceModels.where((e) => e.id == j.iDOPSI!).first.selected! ? const Icon(Icons.check_outlined, color: Colors.white) : null,
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

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "4" //298
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan == null //299
                                              ? Container()
                                              : logic.obxPertanyaan.value.data![index].subPertanyaan!.length == 1 && logic.obxPertanyaan.value.data![index].subPertanyaan![0].labelPertanyaan == null //304
                                                ? logic.obxPertanyaan.value.data![index].subPertanyaan![0].templateJawaban == null //305
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan![0].templateJawaban! )
                                                          RadioListTile(
                                                              title: Text(i.oPSI!),
                                                              value: i.vALUEJAWABAN!,
                                                              groupValue: i.pERTANYAANCODE,
                                                              onChanged: (newValue){
                                                                logic.clickRadioButton(i.pERTANYAANCODE!, i.pERTANYAANCODE!, newValue!);
                                                              }
                                                          )
                                                      ],
                                                    )
                                                : Column(
                                                    children: [
                                                      for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan! )
                                                        Column(
                                                          children: [
                                                            const Divider(),
                                                            Text(
                                                              i.labelPertanyaan!.vALUE!,
                                                              style: const TextStyle(
                                                                fontStyle: FontStyle.italic
                                                              ),
                                                            ),

                                                            for ( var j in i.templateJawaban! )
                                                              RadioListTile(
                                                                  title: Text(j.oPSI!),
                                                                  value: j.vALUEJAWABAN!,
                                                                  groupValue: state.hashRadio![i.labelPertanyaan!.iDVALUE!],
                                                                  onChanged: (value){
                                                                    logic.clickRadioButton(i.labelPertanyaan!.iDVALUE!, j.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!, value!);
                                                                  }
                                                              )
                                                          ],
                                                        )
                                                    ],
                                                  )
                                            : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "5"
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan == null
                                              ?  Slider(
                                                  value: double.parse(state.hashSlider![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!]!),
                                                  max: 100,
                                                  min: 0,
                                                  divisions: 10,
                                                  label: (double.parse(state.hashSlider![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!]!)/10).round().toString(),
                                                  onChanged: (d){
                                                    logic.handleSlider(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!, d);
                                                  }
                                              )
                                              : Column(
                                                  children: [
                                                    for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan! )
                                                      Column(
                                                        children: [
                                                          Text(i.labelPertanyaan!.vALUE!),
                                                          Slider(
                                                              value: double.parse(state.hashSlider![
                                                                logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!]!
                                                              ),
                                                              min: 0,
                                                              max: 100,
                                                              divisions: 10,
                                                              label: (double.parse(state.hashSlider![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!]!)/10).round().toString(),
                                                              onChanged: (d){
                                                                logic.handleSlider(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE! + ";" + i.labelPertanyaan!.iDVALUE!, d);
                                                              }
                                                          )
                                                        ],
                                                      )
                                                  ],
                                                )
                                            : Container(),

                                        logic.obxPertanyaan.value.data![index].pertanyaan!.iDFORMAT == "6" //183
                                            ? logic.obxPertanyaan.value.data![index].subPertanyaan == null //184
                                              ? Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Switch(
                                                      value: state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!] == "0" ? false : true,
                                                      onChanged: (s){
                                                        logic.clickSwitch(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!, s);
                                                      }
                                                  ),
                                                  Text( state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!] == "0" ? "Tidak" : "Ya")
                                                ],
                                              )
                                              : Column(
                                                  children: [
                                                    for ( var i in logic.obxPertanyaan.value.data![index].subPertanyaan! )
                                                      Column(
                                                        children: [
                                                          Text(i.labelPertanyaan!.vALUE!),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Switch(
                                                                  value: state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!] == "0" ? false : true,
                                                                  onChanged: (s){
                                                                    logic.clickSwitch(logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!, s);
                                                                  }
                                                              ),
                                                              Text( state.hashSemua![logic.obxPertanyaan.value.data![index].pertanyaan!.pERTANYAANCODE!] == "0" ? "Tidak" : "Ya")
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                  ],
                                                )
                                            : Container(),

                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: logic.obxPertanyaan.value.data!.length,
                            )),
                            ElevatedButton(
                                onPressed: (){
                                  logic.submit();
                                },
                                child: const Text("Submit"))
                          ]
                    )
                ),
              )
          );
        }
    );
  }
}
