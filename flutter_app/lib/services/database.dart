import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/models/userInfo.dart';
import 'package:flutterapp/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String sugars, String name, int strength) async{
    return await userCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // user list from snapshot
  List<userInfo> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return userInfo(
        name:doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],

    );
  }

  // get users stream
  Stream<List<userInfo>> get users{
    return userCollection.snapshots()
      .map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}