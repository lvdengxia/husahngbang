class Login {
  late String name;
  late String pwd;
  late String code;
  late String msg;
  late Data? data;

  Login({required this.name, required this.pwd, required this.code, required this.msg, required this.data});

  Login.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pwd = json['pwd'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['pwd'] = this.pwd;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  late String token;

  Data({required this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}