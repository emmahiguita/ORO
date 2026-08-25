import 'dart:io';

Future<bool> checkinternet() async {
  try {
    final results = await InternetAddress.lookup('google.com')
        .timeout(const Duration(milliseconds: 1200));
    return results.isNotEmpty && results[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}
