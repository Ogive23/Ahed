import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:http/http.dart' as http;

class TokenApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  String url = 'http://192.168.1.2:8000';
  Future<Map<String, dynamic>> refreshAccessToken() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sessionManager.accessToken}',
      };
      print(headers);
      print('here');
      print('$url/api/token/refresh');
      var response = await http
          .post(Uri.parse('$url/api/token/refresh'), headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      sessionManager.refreshSessionToken(responseToJson['data']['accessToken'], responseToJson['data']['expiryDate']);
      return {
        'Err_Flag': responseToJson['Err_Flag'],
        'Values': responseToJson['data']
      };
    } on TimeoutException {
      throw TimeoutException('Server Timeout!');
    } on SocketException {
      throw const SocketException('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      rethrow;
    }
  }
}
