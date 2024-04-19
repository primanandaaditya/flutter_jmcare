class AntriansekarangRequest {
  String? idUser;

  AntriansekarangRequest({this.idUser});

  AntriansekarangRequest.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    return data;
  }
}
