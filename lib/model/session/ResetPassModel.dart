class ResetPassModel {
  String? email;
  String? hp;

  ResetPassModel({this.email, this.hp});

  ResetPassModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    hp = json['hp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['hp'] = this.hp;
    return data;
  }
}
