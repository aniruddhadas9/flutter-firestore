import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/cloud-firestore.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  NewPayment createState() {
    return NewPayment();
  }
}

// Define the new page
class NewPayment extends State<MyCustomForm> {
  // const NewPayment({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  CloudFirestoreService? service;

  @override
  void initState() {
    // Initialize an instance of Cloud Firestore
    service = CloudFirestoreService(FirebaseFirestore.instance);
    super.initState();
  }

  /*Future<void> sendEmail() async {
    final smtpServer = gmail('fakebabadance@gmail.com', 'ovdq ptnz jbbq ejsw');
    // final smtpServer = gmail('aniruddhadas9@gmail.com', 'Asaxcom8*123gagan');
    // final smtpServer = SmtpServer('smtp.gmail.com', username: 'aniruddhadas9@gmail.com', password: 'Asaxcom8*123gagan');
    // final smtpServer = gmailSaslXoauth2('fakebabadance@gmail.com', 'ovdq ptnz jbbq ejsw');

    final message = Message()
      ..from = Address('fakebabadance@gmail.com', 'I Renter team: Payment Update')
      ..recipients.add('aniruddhadas9@gmail.com')
      ..subject = 'Payment updates'
      ..html = '<!doctypehtml><meta content="text/html; charset=utf-8"http-equiv=Content-Type><meta content=text/css http-equiv=Content-Style-Type><title></title><meta content="Cocoa HTML Writer"name=Generator><meta content=2575.4 name=CocoaVersion><style>p.p1{margin:0;text-align:center;font:12px Times;-webkit-text-stroke:#000}p.p2{margin:0;text-align:center;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p3{margin:0;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p5{margin:0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}p.p7{margin:0;font:14px Times;-webkit-text-stroke:#000}p.p8{margin:0;text-align:right;font:14px Times;-webkit-text-stroke:#000}p.p9{margin:0;text-align:center;font:14px Times;-webkit-text-stroke:#000}li.li6{margin:0 0 15px 0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}span.s1{font-kerning:none}span.s2{font-kerning:none;background-color:#f9f9f9}span.s3{background-color:#f9f9f9;-webkit-text-stroke:0 #000}span.s4{text-decoration:underline;font-kerning:none;background-color:#f9f9f9}span.s5{text-decoration:underline;font-kerning:none}table.t1{width:800px;background-color:#f9f9f9;border-collapse:collapse}table.t2{border-collapse:collapse;table-layout:fixed}table.t3{margin:0 100px 0 100px;border-collapse:collapse}table.t4{width:560px;border-collapse:collapse}table.t5{background-color:#fff;margin:0 100px 0 100px;border-style:solid;border-width:10px 0 10px 0;border-color:#494edb #6d6d6d #494edb #6d6d6d;border-collapse:collapse}table.t6{background-color:#fff;margin:0 100px 0 100px;border-collapse:collapse}table.t7{border-collapse:collapse}table.t8{width:115px;border-collapse:collapse}table.t9{width:425px;border-collapse:collapse}td.td1{width:800px}td.td2{width:560px;padding:10px 20px 10px 20px}td.td3{width:560px}td.td4{width:560px;padding:0 0 20px 0}td.td5{width:270px;padding:15px 5px 15px 5px}td.td6{width:560px;padding:30px 20px 0 20px}td.td7{width:560px;padding:20px 20px 0 20px}td.td8{width:560px;padding:5px 0 10px 0}td.td9{width:560px;padding:20px 20px 20px 20px}td.td10{width:115px}td.td11{width:115px;padding:5px 0 5px 0}td.td12{width:425px}td.td13{width:425px;padding:5px 0 5px 0}td.td14{width:24px;padding:0 10px 0 0}td.td15{width:24px}ul.ul1{list-style-type:disc}</style><table cellpadding=0 cellspacing=0 class=t1 width=800.0><tr><td class=td1 valign=top><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t3><tr><td class=td2 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td4 valign=middle><p class=p1><span class=s1><img alt=93351617889024778.png src=file:///93351617889024778.png></span><tr><td class=td3 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td5 valign=top><p class=p2><span class=s2>+0 (000) 123 45 67</span><td class=td5 valign=top><p class=p2><span class=s2>parker@email.com</span></table></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t5><tr><td class=td6 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=middle><p class=p3><span class=s2>October 1, 2021</span></table></table><tr><td class=td7 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td8 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Dear *|FNAME|*,</b><b></b></span></h3><tr><td class=td8 valign=middle><p class=p5><span class=s2>It was nice meeting you.</span><p class=p5><span class=s2>This email is a short follow-up to the conversation that took place online yesterday.</span><span class=s1><br><br></span><span class=s2><b>Things we agreed on:</b><b></b></span><ul class=ul1><li class=li6><span class=s3></span><span class=s2>Both sides are to finish preparation for collaboration. Due date: October 1, 2021.</span><li class=li6><span class=s3></span><span class=s2>Both sides agreed on the payment conditions -- we will send them in a new email.</span><li class=li6><span class=s3></span><span class=s2>Invoices will be sent 5 businesses days before the billing period ends.</span><li class=li6><span class=s3></span><span class=s2>Online meetings will take place every second Friday of the month starting from June.</span></ul><p class=p5><span class=s2>All these questions and conditions are a subject for further discussion.</span><span class=s1><br><br></span><span class=s2>Dear *|FNAME|*, I hope our collaboration will be fruitful for both sides.</span><span class=s1><br><br></span><span class=s2>Sincerely,</span><span class=s1><br></span><span class=s2>Aaron Parker.</span><span class=s1><br></span><tr><td class=td4 valign=middle><p class=p7><span class=s1><img alt=89501626684388018.png src=file:///89501626684388018.png></span></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t6><tr><td class=td9 valign=middle><table cellpadding=0 cellspacing=0 class=t7><tr><td class=td10 valign=middle><table cellpadding=0 cellspacing=0 class=t8 width=115.0><tr><td class=td11 valign=middle><p class=p8><span class=s1><img alt=12581621865359778.png src=file:///12581621865359778.png></span></table></table><table cellpadding=0 cellspacing=0 class=t7><tr><td class=td12 valign=middle><table cellpadding=0 cellspacing=0 class=t9 width=425.0><tr><td class=td12 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Aaron Parker</b><b></b></span></h3><p class=p5><span class=s2>CEO of "Style Casual"</span><p class=p5><span class=s2>+0 (000) 123 456 789</span><p class=p5><span class=s4><a href=mailto:aaronparker@email.com>parker@email.com<span class=s5></span></a></span><tr><td class=td13 valign=middle><table cellpadding=0 cellspacing=0 class=t7><tr><td class=td14 valign=top><p class=p9><span class=s1><img alt=facebook-logo-black.png src=file:///facebook-logo-black.png></span><td class=td14 valign=top><p class=p9><span class=s1><img alt=x-logo-black.png src=file:///x-logo-black.png></span><td class=td14 valign=top><p class=p9><span class=s1><img alt=instagram-logo-black.png src=file:///instagram-logo-black.png></span><td class=td15 valign=top><p class=p9><span class=s1><img alt=youtube-logo-black.png src=file:///youtube-logo-black.png></span></table></table></table></table></table></table>';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      // Additional code for feedback to the user
    } catch (e) {
      print('Error occurred while sending email: $e');
      // Additional code for error handling
    }
  }*/


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {

                service?.add({
                  'firstName': 'firstName',
                  'lastName': 'lastName',
                });


                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  /*Email().sendEmail(
                      'fakebabadance@gmail.com',
                      'ovdq ptnz jbbq ejsw',
                      'fakebabadance@gmail.com',
                      '9 Island manages: Payment Reminder',
                      'aniruddhadas9@gmail.com',
                      'Payment Updates',
                      '<!doctypehtml><meta content="text/html; charset=utf-8"http-equiv=Content-Type><meta content=text/css http-equiv=Content-Style-Type><title></title><meta content="Cocoa HTML Writer"name=Generator><meta content=2575.4 name=CocoaVersion><style>p.p1{margin:0;text-align:center;font:12px Times;-webkit-text-stroke:#000}p.p2{margin:0;text-align:center;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p3{margin:0;font:14px Arial;color:#535353;-webkit-text-stroke:#535353}p.p5{margin:0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}p.p7{margin:0;font:14px Times;-webkit-text-stroke:#000}p.p8{margin:0;text-align:right;font:14px Times;-webkit-text-stroke:#000}p.p9{margin:0;text-align:center;font:14px Times;-webkit-text-stroke:#000}li.li6{margin:0 0 15px 0;font:14px Arial;color:#262626;-webkit-text-stroke:#262626}span.s1{font-kerning:none}span.s2{font-kerning:none;background-color:#f9f9f9}span.s3{background-color:#f9f9f9;-webkit-text-stroke:0 #000}span.s4{text-decoration:underline;font-kerning:none;background-color:#f9f9f9}span.s5{text-decoration:underline;font-kerning:none}table.t1{width:800px;background-color:#f9f9f9;border-collapse:collapse}table.t2{border-collapse:collapse;table-layout:fixed}table.t3{margin:0 100px 0 100px;border-collapse:collapse}table.t4{width:560px;border-collapse:collapse}table.t5{background-color:#fff;margin:0 100px 0 100px;border-style:solid;border-width:10px 0 10px 0;border-color:#494edb #6d6d6d #494edb #6d6d6d;border-collapse:collapse}table.t6{background-color:#fff;margin:0 100px 0 100px;border-collapse:collapse}table.t7{border-collapse:collapse}table.t8{width:115px;border-collapse:collapse}table.t9{width:425px;border-collapse:collapse}td.td1{width:800px}td.td2{width:560px;padding:10px 20px 10px 20px}td.td3{width:560px}td.td4{width:560px;padding:0 0 20px 0}td.td5{width:270px;padding:15px 5px 15px 5px}td.td6{width:560px;padding:30px 20px 0 20px}td.td7{width:560px;padding:20px 20px 0 20px}td.td8{width:560px;padding:5px 0 10px 0}td.td9{width:560px;padding:20px 20px 20px 20px}td.td10{width:115px}td.td11{width:115px;padding:5px 0 5px 0}td.td12{width:425px}td.td13{width:425px;padding:5px 0 5px 0}td.td14{width:24px;padding:0 10px 0 0}td.td15{width:24px}ul.ul1{list-style-type:disc}</style><table cellpadding=0 cellspacing=0 class=t1 width=800.0><tr><td class=td1 valign=top><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t3><tr><td class=td2 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td4 valign=middle><p class=p1><span class=s1><img alt=93351617889024778.png src=file:///93351617889024778.png></span><tr><td class=td3 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td5 valign=top><p class=p2><span class=s2>+91 7838874494</span><td class=td5 valign=top><p class=p2><span class=s2>fakebabadance@email.com</span></table></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t5><tr><td class=td6 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=middle><p class=p3><span class=s2>March 13, 2025</span></table></table><tr><td class=td7 valign=middle><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td3 valign=top><table cellpadding=0 cellspacing=0 class=t4 width=560.0><tr><td class=td8 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Dear Renter,</b><b></b></span></h3><tr><td class=td8 valign=middle><p class=p5><span class=s2>It was nice meeting you.</span><p class=p5><span class=s2>This email is a short follow-up to the conversation that took place online yesterday.</span> <span class=s1><br><br></span><span class=s2><b>Things we agreed on:</b><b></b></span><ul class=ul1><li class=li6><span class=s3></span> <span class=s2>Both sides are to finish preparation for collaboration. Due date: October 1, 2021.</span><li class=li6><span class=s3></span><span class=s2>Both sides agreed on the payment conditions -- we will send them in a new email.</span><li class=li6><span class=s3></span><span class=s2>Invoices will be sent 5 businesses days before the billing period ends.</span><li class=li6><span class=s3></span><span class=s2>Online meetings will take place every second Friday of the month starting from June.</span></ul><p class=p5><span class=s2>All these questions and conditions are a subject for further discussion.</span> <span class=s1><br><br></span><span class=s2>Dear Renter, I hope our collaboration will be fruitful for both sides.</span> <span class=s1><br><br></span><span class=s2>Sincerely,</span><span class=s1><br></span><span class=s2>Aniruddha Das</span><span class=s1><br></span></table></table></table></table><table cellpadding=0 cellspacing=0 class=t2><tr><td class=td1 valign=middle><table cellpadding=0 cellspacing=0 class=t6><tr><td class=td9 valign=middle><table cellpadding=0 cellspacing=0 class=t7><tr><td class=td12 valign=middle><table cellpadding=0 cellspacing=0 class=t9 width=425.0><tr><td class=td12 valign=middle><h3 style="margin:0;font:20px Arial;color:#494edb;-webkit-text-stroke:#494edb"><span class=s2><b>Aaron Parker</b><b></b></span></h3><p class=p5><span class=s2>CEO of "Style Casual"</span><p class=p5><span class=s2>+91 7838874494</span><p class=p5><span class=s4><a href=mailto:aaronparker@email.com>fakebabadance@email.com<span class=s5></span></a></span></table></table></table></table></table>'
                  );*/
                  // sendEmail();
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),

                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
