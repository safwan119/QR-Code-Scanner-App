import 'package:flutter/material.dart';
import 'package:qr_code_scanner/NotificationServices/notification_services.dart';

class NotificationSendScreen extends StatelessWidget {
  NotificationSendScreen({super.key});

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Center(child: Text("Notification Send Screen")),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              minLines: 1,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Enter title for notification..",
                label: Text("title*"),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              style: TextStyle(color: Colors.white),
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter description for notification..",
                labelStyle: TextStyle(color: Colors.white),
                label: Text("desc*"),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Title and description cannot be empty.'),
                    ),
                  );
                  return;
                }
                await notificationServices.sendNotification(
                  titleController.text,
                  descriptionController.text,
                  context,
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.amber.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Send Notification",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
