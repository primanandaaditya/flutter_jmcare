class ChoicechipModel {
  String? id;
  String? pertanyaanCode;
  String? valueJawaban;
  bool? selected;

  ChoicechipModel({this.id, this.pertanyaanCode, this.valueJawaban, this.selected});

  ChoicechipModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pertanyaanCode = json['pertanyaanCode'];
    valueJawaban = json['valueJawaban'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pertanyaanCode'] = this.pertanyaanCode;
    data['selected'] = this.selected;
    data['valueJawaban'] = this.valueJawaban;
    return data;
  }
}
