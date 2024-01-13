import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'details.dart';

class SavedFormsPage extends StatefulWidget {
  @override
  _SavedFormsPageState createState() => _SavedFormsPageState();
}

class _SavedFormsPageState extends State<SavedFormsPage> {
  late SharedPreferences _prefs;
  List<String> _savedFormKeys = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _getSavedFormKeys();
  }

  void _getSavedFormKeys() {
    // Get the keys of saved forms.
    final keys = _prefs.getKeys();
    setState(() {
      _savedFormKeys = keys.where((key) => key.startsWith('form_')).toList();
    });
  }

  // Function to display form details when a card is tapped.
  void _showFormDetails(String formKey) {
    final formDataJson = _prefs.getString(formKey);
    final formData = json.decode(formDataJson ?? '{}');
    // Navigate to a new page to display all the details.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormDetailsPage(formData: formData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Forms'),
      ),
      body: ListView.builder(
        itemCount: _savedFormKeys.length,
        itemBuilder: (context, index) {
          final formKey = _savedFormKeys[index];
          final formDataJson = _prefs.getString(formKey);
          final formData = json.decode(formDataJson ?? '{}');
          final permitType = formData['permitType'] ?? '';
          return ListTile(
            title: Card(
              child: ListTile(
                title: Text('Permit Type: $permitType'),
                onTap: () {
                  _showFormDetails(formKey);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
