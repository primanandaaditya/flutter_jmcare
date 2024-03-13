class Epolis {
  int? id;
  String? agreement_no;
  String? filepath;
  String? create_date;

  Epolis({this.id, this.agreement_no, this.filepath, this.create_date});

  Epolis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agreement_no = json['agreement_no'];
    filepath = json['filepath'];
    create_date = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agreement_no'] = this.agreement_no;
    data['filepath'] = this.filepath;
    data['create_date'] = this.create_date;
    return data;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['agreement_no'] = agreement_no;
    map['filepath'] = filepath;
    map['create_date'] = create_date;
    return map;
  }

}
