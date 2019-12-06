class LoginResponse {
  String response;
  String username;
  String email;
  String name;
  String estado;
  String token;

  LoginResponse(
      {this.response,
      this.username,
      this.email,
      this.name,
      this.estado,
      this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    estado = json['estado'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['estado'] = this.estado;
    data['token'] = this.token;
    return data;
  }
}