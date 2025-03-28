import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  Future<void> sendEmail(String email) async {
    final Uri mailUrl = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(mailUrl);
  }

  Future<void> sendEmailWithSubject(
    String email, 
    {String subject = "", String body = ""}
  ) async {
    final Uri mailUrl = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body
      }
    );
    await launchUrl(mailUrl);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  openWhatsApp(String phone) {
    return launchUrl(
      Uri.parse(
        //'https://wa.me/1234567890' //you use this url also
        'whatsapp://send?phone=$phone',
      ),
    );
  }
}