import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../auth/auth_service.dart';
import '../services/KrenterEmailService.dart';

class FlatRentStart extends StatefulWidget {
  const FlatRentStart({super.key});

  @override
  _FlatRentStartState createState() => _FlatRentStartState();
}

class _FlatRentStartState extends State<FlatRentStart> {
  final _auth = AuthService();
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
          'startDate': startDate?.toIso8601String(),
          'endDate': endDate?.toIso8601String(),
          'idProofProvided': idProofProvided,
          'idProofUrl': 'fileUrl',
          'agreed': 'Agree',
        };
        log('submitted data ${data.toString()}');

        // Check if user is login and then update the tenant or add the new tenant
        if(_auth.getCurrentUser() != null) {
          log('the user is already login | ${_auth.getCurrentUserToString()}');
          final String? userEmail = _auth.getCurrentUser()?.email;

          // Step 1: Query the document by email
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('tenantOnboarding')
              .where('email', isEqualTo: email)
              .get();

          if (snapshot.docs.isNotEmpty) {
            // Step 2: Get the document ID
            DocumentReference docRef = snapshot.docs.first.reference;
            // Step 3: Update the document
            await docRef.update(data);
            log("tenantOnboarding|Tenant details updated!");
          } else {
            await FirebaseFirestore.instance.collection('tenantOnboarding').add(data);
            log("tenantOnboarding|New tenant details added!");
          }

        }

        await _sendEmail(data);
        await _showNotification();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved and email sent.')));

      } catch (e, r) {
        log('renterRegistration|Error: $e');
        log('renterRegistration|Error||r: $r');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));

      } finally {
        setState(() => isLoading = false);
      }
    } else {
      log('tenantOnboarding form validation failed ');
    }
  }

  Future<void> _sendEmail(data) async {
    KrenterEmailService().sendEmail(
        'fakebabadance@gmail.com',
        'ovdq ptnz jbbq ejsw',
        '9islandbbsr@gmail.com',
        '9 Island: Building manager',
        data.email,
        'New tenant registration done',
        '<!doctypehtml><meta content="text/html; charset=utf-8"http-equiv=Content-Type><meta content=text/css http-equiv=Content-Style-Type><title></title><meta content="Cocoa HTML Writer"name=Generator><meta content=2575.4 name=CocoaVersion><style>p.p1{margin:0;text-align:center;font:12px Times;-webkit-text-stroke:#000}p.p2{margin:0;text-align:center;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p3{margin:0;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p5{margin:0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}p.p7{margin:0;font:14px Times;-webkit-text-stroke:#000}p.p8{margin:0;text-align:right;font:14px Times;-webkit-text-stroke:#000}p.p9{margin:0;text-align:center;font:14px Times;-webkit-text-stroke:#000}li.li6{margin:0 0 15px 0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}span.s1{font-kerning:none}span.s2{font-kerning:none;background-color:#f9f9f9}span.s3{background-color:#f9f9f9;-webkit-text-stroke:0 #000}span.s4{text-decoration:underline;font-kerning:none;background-color:#f9f9f9}span.s5{text-decoration:underline;font-kerning:none}table.t1{width:800px;background-color:#f9f9f9;border-collapse:collapse}table.t2{border-collapse:collapse;table-layout:fixed}table.t3{margin:0 100px 0 100px;border-collapse:collapse}table.t4{width:560px;border-collapse:collapse}table.t5{background-color:#fff;margin:0 100px 0 100px;border-style:solid;border-width:10px 0 10px 0;border-color:#494edb #6d6d6d #494edb #6d6d6d;border-collapse:collapse}table.t6{background-color:#fff;margin:0 100px 0 100px;border-collapse:collapse}table.t7{border-collapse:collapse}table.t8{width:115px;border-collapse:collapse}table.t9{width:425px;border-collapse:collapse}td.td1{width:800px}td.td2{width:560px;padding:10px 20px 10px 20px}td.td3{width:560px}td.td4{width:560px;padding:0 0 20px 0}td.td5{width:270px;padding:15px 5px 15px 5px}td.td6{width:560px;padding:30px 20px 0 20px}td.td7{width:560px;padding:20px 20px 0 20px}td.td8{width:560px;padding:5px 0 10px 0}td.td9{width:560px;padding:20px 20px 20px 20px}td.td10{width:115px}td.td11{width:115px;padding:5px 0 5px 0}td.td12{width:425px}td.td13{width:425px;padding:5px 0 5px 0}td.td14{width:24px;padding:0 10px 0 0}td.td15{width:24px}ul.ul1{list-style-type:disc}</style><table cellpadding=0 cellspacing=0 class=t1 width=800.0><tr><td class=td1 valign=top><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t3><tr><td class=td2 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td4 valign=middle><p class=p1><span class=s1><img alt=93351617889024778.png src=file:///93351617889024778.png></span><tr><td class=td3 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td5 valign=top><p class=p2><span class=s2>+91 7838874494</span><td class=td5 valign=top><p class=p2><span class=s2>fakebabadance@email.com</span></table></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t5><tr><td class=td6 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=middle><p class=p3><span class=s2>March 13, 2025</span></table></table><tr><td class=td7 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td8 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Dear Renter,</b><b></b></span></h3><tr><td class=td8 valign=middle><p class=p5><span class=s2>It was nice meeting you.</span><p class=p5><span class=s2>This email is a short follow-up to the conversation that took place online yesterday.</span> <span class=s1><br><br></span><span class=s2><b>Things we agreed on:</b><b></b></span><ul class=ul1><li class=li6><span class=s3></span> <span class=s2>Both sides are to finish preparation for collaboration. Due date: October 1, 2021.</span><li class=li6><span class=s3></span><span class=s2>Both sides agreed on the payment conditions -- we will send them in a new email.</span><li class=li6><span class=s3></span><span class=s2>Invoices will be sent 5 businesses days before the billing period ends.</span><li class=li6><span class=s3></span><span class=s2>Online meetings will take place every second Friday of the month starting from June.</span></ul><p class=p5><span class=s2>All these questions and conditions are a subject for further discussion.</span> <span class=s1><br><br></span><span class=s2>Dear Renter, I hope our collaboration will be fruitful for both sides.</span> <span class=s1><br><br></span><span class=s2>Sincerely,</span><span class=s1><br></span><span class=s2>Aniruddha Das</span><span class=s1><br></span></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t6><tr><td class=td9 valign=middle><table cellpadding=0 cellspacing=0 class=t7><tr><td class=td12 valign=middle><table cellpadding=0 cellspacing=0 class=t9 width=425.0><tr><td class=td12 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Aaron Parker</b><b></b></span></h3><p class=p5><span class=s2>CEO of "Style Casual"</span><p class=p5><span class=s2>+91 7838874494</span><p class=p5><span class=s4><a href=mailto:aaronparker@email.com>fakebabadance@email.com<span class=s5></span></a></span></table></table></table></table></table>'
    );
  }

  Future<void> _showNotification() async {
    log('sending push notification');
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const android = AndroidNotificationDetails('channelId', 'KRenter', importance: Importance.max);
    const platform = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Rent request!',
      'Your Rent request submitted successfully',
      platform,
    );
    log('push notification sent !!!!');
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
                onPressed: _pickFile,
                child: Text(idProof == null ? 'Upload ID Proof' : 'ID Proof Selected'),
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
