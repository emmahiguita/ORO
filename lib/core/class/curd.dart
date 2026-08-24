import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/functions/checkinternet.dart';
import 'package:oro/core/services/offline_data_provider.dart';
import 'package:oro/core/services/services.dart';

class Curd {
  static const _timeout = Duration(seconds: 4);

  Map<String, String> _headers({bool json = false}) {
    final headers = <String, String>{};
    if (json) headers['Content-Type'] = 'application/json';
    if (Get.isRegistered<Services>()) {
      final token = Get.find<Services>().authToken;
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<Either<StatusRequest, Map>> postData(
    String linkurl,
    Map data,
  ) async {
    if (OfflineDataProvider.isOfflineMode) {
      return Right(OfflineDataProvider.getMockResponse(linkurl, data));
    }
    try {
      if (!await checkinternet()) {
        return Right(OfflineDataProvider.getMockResponse(linkurl, data));
      }
      final response = await http
          .post(
            Uri.parse(linkurl),
            body: data.map((key, value) => MapEntry('$key', '$value')),
            headers: _headers(),
          )
          .timeout(_timeout);
      if (response.statusCode == 401) {
        _expireSession();
        return const Left(StatusRequest.failure);
      }
      if (response.statusCode != 200 && response.statusCode != 201) {
        return Right(OfflineDataProvider.getMockResponse(linkurl, data));
      }
      final decoded = jsonDecode(response.body);
      if (decoded is! Map) {
        return Right(OfflineDataProvider.getMockResponse(linkurl, data));
      }
      return Right(Map<String, dynamic>.from(decoded));
    } on SocketException {
      return Right(OfflineDataProvider.getMockResponse(linkurl, data));
    } on FormatException {
      return Right(OfflineDataProvider.getMockResponse(linkurl, data));
    } catch (_) {
      return Right(OfflineDataProvider.getMockResponse(linkurl, data));
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithImageOne(
    dynamic url,
    Map data,
    File? image, [
    String? namerequest,
  ]) async {
    return _multipart(
      url: '$url',
      data: data,
      files: image == null ? const [] : [(namerequest ?? 'files', image)],
    );
  }

  Future<Either<StatusRequest, Map>> addRequestWithTwoImages(
    dynamic url,
    Map data,
    File? image1,
    File? image2, [
    String? namerequest1,
    String? namerequest2,
  ]) async {
    final files = <(String, File)>[];
    if (image1 != null) files.add((namerequest1 ?? 'pfp', image1));
    if (image2 != null) files.add((namerequest2 ?? 'banner', image2));
    return _multipart(url: '$url', data: data, files: files);
  }

  Future<Either<StatusRequest, Map>> _multipart({
    required String url,
    required Map data,
    required List<(String, File)> files,
  }) async {
    if (OfflineDataProvider.isOfflineMode) {
      return Right(OfflineDataProvider.getMockResponse(url, data));
    }
    try {
      if (!await checkinternet()) {
        return Right(OfflineDataProvider.getMockResponse(url, data));
      }
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(_headers());
      for (final entry in data.entries) {
        request.fields['${entry.key}'] = '${entry.value}';
      }
      for (final (field, file) in files) {
        request.files.add(await http.MultipartFile.fromPath(
          field,
          file.path,
          filename: basename(file.path),
        ));
      }
      final streamed = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamed);
      if (response.statusCode == 401) {
        _expireSession();
        return const Left(StatusRequest.failure);
      }
      if (response.statusCode != 200 && response.statusCode != 201) {
        return Right(OfflineDataProvider.getMockResponse(url, data));
      }
      final decoded = jsonDecode(response.body);
      if (decoded is! Map) {
        return Right(OfflineDataProvider.getMockResponse(url, data));
      }
      return Right(Map<String, dynamic>.from(decoded));
    } on SocketException {
      return Right(OfflineDataProvider.getMockResponse(url, data));
    } on FormatException {
      return Right(OfflineDataProvider.getMockResponse(url, data));
    } catch (_) {
      return Right(OfflineDataProvider.getMockResponse(url, data));
    }
  }

  void _expireSession() {
    if (!Get.isRegistered<Services>()) return;
    final service = Get.find<Services>();
    service.sharedPreferences.setString('step', '1');
    service.clearAuthToken();
    Future.microtask(() {
      if (Get.currentRoute != Approutes.login) {
        Get.offAllNamed(Approutes.login);
      }
    });
  }
}
