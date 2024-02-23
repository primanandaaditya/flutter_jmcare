class BaseRespon {
  String? code;
  String? message;
  String? status;

  BaseRespon({this.code, this.message, this.status});

  BaseRespon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class BaseBegin extends BaseRespon{}
class BaseLoading extends BaseRespon{}
class BaseError extends BaseRespon{}
class BaseEmpty extends BaseRespon{}
class BaseWaiting extends BaseRespon{}
