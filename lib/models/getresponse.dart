class GetResponse {
  String name;
  String email;
  String username;
  String estado;

  GetResponse({this.name, this.email, this.username});

  GetResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}