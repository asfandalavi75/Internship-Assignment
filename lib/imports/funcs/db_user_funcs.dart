import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> getUserName() async {
  String userName = "";

  final User? user = auth.currentUser;
  final uid = user!.uid;
  List<UserData> userlist = [];
  if (uid.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        UserData userD = UserData.fromMap(doc.data());
        userlist.add(userD);
      });
    });
    for (var currentUser in userlist) {
      if (currentUser.userID == uid) {
        userName = currentUser.name;
      }
    }
  }
  return userName;
}
