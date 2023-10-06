import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// getData() async {
//   QuerySnapshot data =
//       await FirebaseFirestore.instance.collection('user').get();
//   print(
//     data,
//   );
// }

Future<void> getData() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();

    // Iterate through the documents in the QuerySnapshot
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      // Convert each document to a map and print it
      Map<String, dynamic> dataMap =
          documentSnapshot.data() as Map<String, dynamic>;
      print(dataMap);
    }
  } catch (e) {
    print(e.toString());
  }
}
