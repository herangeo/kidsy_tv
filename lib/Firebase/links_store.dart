import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference kidsy = FirebaseFirestore.instance.collection('kidsy');

  Future<String?> getLink() async {
    try {
      QuerySnapshot querySnapshot = await kidsy.get();
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        return document['links'];
      }
      return null;
    } catch (e) {
      print("Error fetching link $e");
      return null;
    }
  }

  Future<void> updateLink(String link) async {
    try {
      QuerySnapshot querySnapshot = await kidsy.get();
      if (querySnapshot.docs.isNotEmpty) {
        await kidsy.doc(querySnapshot.docs.first.id).update({'links': link});
      }
    } catch (e) {
      print("Error updating link: $e");
    }
  }
}
