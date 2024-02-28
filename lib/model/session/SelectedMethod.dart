class SelectedMethod {
  int? selectedMethod;

  SelectedMethod({this.selectedMethod});

  SelectedMethod.fromJson(Map<String, dynamic> json) {
    selectedMethod = json['selected_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected_method'] = this.selectedMethod;
    return data;
  }
}
