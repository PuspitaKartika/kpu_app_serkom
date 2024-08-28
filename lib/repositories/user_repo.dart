import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpu_app_serkom/model/user_model.dart';



class UsersRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UsersModel>> getListUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('pemilih').get();

      return querySnapshot.docs
          .map((e) => UsersModel.fromFirestore(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<UsersModel> getUsers(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('pemilih').doc(id).get();

      return UsersModel.fromFirestore(docSnapshot);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUsers(UsersModel data) async {
    try {
      await _firestore.collection('pemilih').add(data.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUsers(
      {required UsersModel data, required String id}) async {
    try {
      await _firestore
          .collection('pemilih')
          .doc(id)
          .update(data.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUsers(String id) async {
    try {
      await _firestore.collection('pemilih').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}