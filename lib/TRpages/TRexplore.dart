import 'package:flutter/material.dart';
import '../NotificationsHandler.dart';

class TRexplore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () async {
            await createLocalNotification(message: {
              'title': 'Admin',
              'message': 'Do you want to Approve/Disapprove this coach?'
            });
          },
          child: Text('Click')),
    );
  }
}
