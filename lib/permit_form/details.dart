
import 'package:flutter/material.dart';

class FormDetailsPage extends StatelessWidget {
  final Map<String, dynamic> formData;

  const FormDetailsPage({Key? key, required this.formData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${formData['name']}'),
            Text('Permit Type: ${formData['permitType']}'),
            Text('Email: ${formData['email']}'),
            Text('Number: ${formData['number']}'),
            Text('Date/Time: ${formData['dateTime']}'),
            Text('Address: ${formData['address']}'),
            // You can display images here using Image.file if paths are available.
          ],
        ),
      ),
    );
  }
}