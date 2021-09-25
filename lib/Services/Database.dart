import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meras_sprint1/Models/ContactModel.dart';

final databaseReference = FirebaseFirestore.instance;

class Database {
  createContactRequest(ContactModel contactData) async {
    await databaseReference
        .collection('Contact Form')
        .doc(contactData.id)
        .set(contactData.toJson());
  }

  fetchContactRequest() {}

  updateContactRequest() {}

  deleteContactRequest() {}
}
