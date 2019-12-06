class SignUpRequest   {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequest({this.name, this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}