class RegisterpinModel {
  bool? sudahRegister;
  String? pin;

  RegisterpinModel({this.sudahRegister, this.pin});

  RegisterpinModel.fromJson(Map<String, dynamic> json) {
    sudahRegister = json['sudah_register'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sudah_register'] = this.sudahRegister;
    data['pin'] = this.pin;
    return data;
  }
}
class RegisterpinError extends RegisterpinModel{}