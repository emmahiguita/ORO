import 'dart:io';

Future<bool> checkinternet() async {
  try {
    var results = await InternetAddress.lookup('google.com');
    if (results.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
