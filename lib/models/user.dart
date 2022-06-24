class UserData {
  late String userID;
  late String name;

  UserData.fromMap(Map<String, dynamic>? data) {
    this.userID = data!['userID'];
    this.name = data['name'];
  }
}
