class SignUpResponse {
  int status;
  String token;
  UserData userData;
  String error;

  SignUpResponse({this.status, this.token, this.userData,this.error});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    token = json['token'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  int id;
  String name;
  String email;
  int planId;

  UserData({this.id, this.name, this.email, this.planId});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    planId = json['plan_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['plan_id'] = this.planId;
    return data;
  }
}

