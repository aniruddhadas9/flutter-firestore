import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FlatRentStart extends StatefulWidget {
  @override
  _FlatRentStartState createState() => _FlatRentStartState();
}

class _FlatRentStartState extends State<FlatRentStart> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, phone, flat, terms, monthlyRent, idProofProvided;
  DateTime? startDate, endDate;
  PlatformFile? idProof;

  final List<String> flatOptions = [
    'GFloor-M1 - 1BHK',
    'GFloor-M2 - 1BHK',
    'FirstFloor-M1 - 2BHK',
    'FirstFloor-M2 - 1BHK + puja',
    '2ndFloor-M1 - 2BHK',
    '2ndFloor-M2 - 1BHK + puja',
    '3rdFloor-M1 - 2BHK',
    '3rdFloor-M2 - 1BHK + puja',
    '4thFloor-M1 - 2BHK',
    '4thFloor-M2 - Studio'
  ];

  final List<String> idProofOptions = [
    'Adhaar Card',
    'Driving Licence',
    'Voter ID',
    'Passport',
    'Birth Certificate',
    'Educational Certificate'
  ];

  bool isLoading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    if (result != null) {
      setState(() {
        idProof = result.files.first;
      });
    }
  }

  Future<void> _submitForm() async {
    log('reached _submitForm: ${_formKey.currentState.toString()}');
    // if (_formKey.currentState?.validate() ?? false && terms == 'Agree' && idProof != null) {
    if (_formKey.currentState?.validate() ?? false && terms == 'Agree') {
      _formKey.currentState?.save();
      setState(() => isLoading = true);

      try {

        // file upload section
        // final ref = FirebaseStorage.instance.ref('id_proofs/${idProof!.name}');
        // await ref.putData(idProof!.bytes!);
        // final fileUrl = await ref.getDownloadURL();
        log('file upload is done');

        // Store data section
        final data = {
          'name': name,
          'email': email,
          'phone': phone,
          'flat': flat,
          'monthly_rent': monthlyRent,
          'start_date': startDate?.toIso8601String(),
          'end_date': endDate?.toIso8601String(),
          'id_proof_provided': idProofProvided,
          'id_proof_url': 'fileUrl',
          'agreed': terms == 'Agree',
        };
        log('submitted data ${data.toString()}');

        await FirebaseFirestore.instance.collection('tenantOnboarding').add(data);

        await _sendEmail();
        await _showNotification();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved and email sent.')));
      } catch (e) {
        log('renterRegistration|Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => isLoading = false);
      }
    } else {
      log('validation failed ');
    }
  }

  Future<void> _sendEmail() async {
    final email = Email(
      body: 'Your registration data has been saved successfully.',
      subject: 'Registration Confirmation',
      recipients: ['aniruddhadas9@gmail.com'],
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> _showNotification() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max);
    const platform = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Rent request!',
      'Your Rent request submitted successfully',
      platform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rent Request Form")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (val) => email = val,
                validator: (val) => val!.contains('@') ? null : 'Invalid email',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (val) => phone = val,
                validator: (val) => val!.length >= 10 ? null : 'Invalid phone',
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Flat Number'),
                items: flatOptions.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (val) => flat = val,
                validator: (val) => val == null ? 'Select flat' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Monthly Rent'),
                keyboardType: TextInputType.number,
                onSaved: (val) => monthlyRent = val,
                validator: (val) => val!.length >= 5 ? null : 'Invalid monthly',
              ),
              ListTile(
                title: Text("Start Date: ${startDate?.toLocal().toString().split(' ')[0] ?? ''}"),
                trailing: Icon(Icons.date_range),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => startDate = picked);
                },
              ),
              ListTile(
                title: Text("End Date: ${endDate?.toLocal().toString().split(' ')[0] ?? ''}"),
                trailing: Icon(Icons.date_range),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => endDate = picked);
                },
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'ID proof to upload'),
                items: idProofOptions.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (val) => idProofProvided = val,
                validator: (val) => val == null ? 'Select flat' : null,
              ),
              ElevatedButton(
                child: Text(idProof == null ? 'Upload ID Proof' : 'ID Proof Selected'),
                onPressed: _pickFile,
              ),
              Row(
                children: [
                  Text('Agree to Terms?'),
                  Radio<String>(
                    value: 'Agree',
                    groupValue: terms,
                    onChanged: (val) => setState(() => terms = val),
                  ),
                  Text('Agree'),
                  Radio<String>(
                    value: 'Not Agree',
                    groupValue: terms,
                    onChanged: (val) => setState(() => terms = val),
                  ),
                  Text('Not Agree'),
                ],
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
