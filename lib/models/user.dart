class User{
String username;
String name;
String email;
String passwordConfirm;
String password;

User({this.username, this.name, this.email, this.passwordConfirm, this.password});
 
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordConfirm: json['passWodConfirm'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["passwordConfirm"] = passwordConfirm;
    return map;
  }

}