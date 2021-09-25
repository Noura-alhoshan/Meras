import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meras_sprint1/Models/ContactModel.dart';
import 'package:meras_sprint1/Services/Database.dart';
import 'package:random_string/random_string.dart';
import '../Global.dart';
import '../NotificationsHandler.dart';

class TRhome extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool validateForm() {
    if (nameController.text.length < 3) {
      showMessage(
          'Error - Name must be of minimum 3 characters', Status.FAILED);
      return false;
    } else if (emailController.text.length < 3) {
      showMessage(
          'Error - Email must be of minimum 3 characters', Status.FAILED);
      return false;
    } else if (messageController.text.length < 3) {
      showMessage(
          'Error - Message must be of minimum 3 characters', Status.FAILED);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Name',
                  labelText: 'Name'),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Email',
                  labelText: 'Email'),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Message',
                  labelText: 'Message'),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (validateForm()) {
                  final ContactModel contactData = ContactModel.fromJson({
                    'id': randomAlpha(20),
                    'name': nameController.text,
                    'email': emailController.text,
                    'message': messageController.text,
                    'createdAt': FieldValue.serverTimestamp()
                  });

                  await Database().createContactRequest(contactData);

                  showMessage('Hoorrayyy!, Your Form Is Valid', Status.SUCCESS);

                  await createLocalNotification(message: {
                    'title': 'Contact Form Submitted',
                    'message':
                        'Thankyou, your message from ${nameController.text}'
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
