
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Email {
  Future<void> sendEmail(String username, String password, String fromEmail,
      String fromName, String toEmail, String subject, String body) async {
    final smtpServer = gmail(username, password);
    // final smtpServer = gmail('fakebabadance@gmail.com', 'ovdq ptnz jbbq ejsw');
    // final smtpServer = gmail('aniruddhadas9@gmail.com', 'Asaxcom8*123gagan');
    // final smtpServer = SmtpServer('smtp.gmail.com', username: 'aniruddhadas9@gmail.com', password: 'Asaxcom8*123gagan');
    // final smtpServer = gmailSaslXoauth2('fakebabadance@gmail.com', 'ovdq ptnz jbbq ejsw');

    final message = Message()
      ..from = Address(fromEmail, fromName)
      ..recipients.add(toEmail)
      ..subject = subject
      ..html = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent----: ${sendReport.toString()}');
      // Additional code for feedback to the user
    } catch (e) {
      print('Error occurred while sending email: $e');
      // Additional code for error handling
    }
  }
}
