class ShowWelcome {
  bool? showWelcome;

  ShowWelcome({this.showWelcome});

  ShowWelcome.fromJson(Map<String, dynamic> json) {
    showWelcome = json['show_welcome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_welcome'] = this.showWelcome;
    return data;
  }
}

