import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:repository/repository.dart';
import 'package:retry/retry.dart';

abstract class BaseClient {
  final Client _client;
  final String _host;
  final String? _authorization;

  BaseClient(String host, {Client? client, String? authorization})
      : _client = client ?? Client(),
        _host = host, _authorization = authorization;

  Uri _getParsedUrl(String path) {
    return Uri.parse('$_host$path');
  }

  BaseRequest _copyRequest(BaseRequest request) {
    BaseRequest requestCopy;

    if (request is Request) {
      requestCopy = Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is MultipartRequest) {
      requestCopy = MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is StreamedRequest) {
      throw Exception('copying streamed requests is not supported');
    } else {
      throw Exception('request type is unknown, cannot copy');
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return requestCopy;
  }

  dynamic _call(String method, String path, {Map<String, Object>? data}) async {
    dynamic responseJson;
    try {
      var request = Request(method, _getParsedUrl(path));
      final token = _authorization ?? Repository().accessToken;
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      if (data != null) {
        request.body = jsonEncode(data);
      }
      responseJson = await retry(
        () async {
          final response = await _client
              .send(request)
              .timeout(const Duration(seconds: 30))
              .then(Response.fromStream);
          return _returnResponse(response);
        },
        retryIf: (e) async {
          if (e is UnauthorisedException) {
            request = _copyRequest(request) as Request;
            return true;
          }
          return false;
        },
      );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        if (responseJson['result'] == false) {
          throw AppException(responseJson);
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      case 501:
        throw ServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            '''Error occurred while Communication with Server with StatusCode : ${response.statusCode}''');
    }
  }

  dynamic get(String path) async {
    return await _call('GET', path);
  }

  dynamic post(String path, [dynamic data]) async {
    return await _call('POST', path, data: data);
  }

  dynamic put(String path, [dynamic data]) async {
    return await _call('PUT', path, data: data);
  }

  dynamic delete(String path, [dynamic data]) async {
    return await _call('DELETE', path, data: data);
  }
}
