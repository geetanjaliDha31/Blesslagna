class UserModel {
  String? username;
  String? password;
  String? userid;

  UserModel(
      {required this.username, required this.password, required this.userid});

  UserModel.fromMap(Map<String, dynamic> map) {
    userid = map['Activited'];
    username = map['Applicationid'];
    password = map['userName'];
  }
}
