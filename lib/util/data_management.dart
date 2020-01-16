import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doggy_poop_diary/datastructures/haufen.dart';

import 'constants.dart';

Future<Haufen> getEvents() async {
  QuerySnapshot qS =
      await Firestore.instance.collection(collection).getDocuments();
  qS.documents.map((e) => print(e.data));

  return null;
}

/*
*    Firestore.instance
        .collection(collection)
        .document()
        .setData({'iostest': 'iostest', 'author': 'author'});
*
*/
