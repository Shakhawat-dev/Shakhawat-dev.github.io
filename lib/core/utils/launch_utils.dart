import 'package:url_launcher/url_launcher.dart';

/// Small wrapper around url_launcher so widgets don't each repeat the
/// Uri-building / mode boilerplate.
class LaunchUtils {
  const LaunchUtils._();

  static Future<void> openUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  static Future<void> sendEmail(String email, {String subject = ''}) async {
    if (email.isEmpty) return;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: subject.isEmpty ? null : 'subject=${Uri.encodeComponent(subject)}',
    );
    await launchUrl(uri);
  }

  static Future<void> call(String phone) async {
    if (phone.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }
}
