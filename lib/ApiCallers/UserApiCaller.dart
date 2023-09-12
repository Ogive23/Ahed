import 'dart:io';

import 'package:ahed/ApiCallers/TokenApiCaller.dart';
import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/session_manager.dart';

class UserApiCaller {
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  TokenApiCaller tokenApiCaller = TokenApiCaller();
  String url = 'http://192.168.1.7:8000';

  Future<Map<String, dynamic>> login(String language, String email, String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
    };
    var body = {
      'email': email,
      'password': password,
      'accessType': 'Application',
      'appType': 'Ahed'
    };
    try {
      var response = await http
          .post(Uri.parse('$url/api/login'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        'Err_Flag': responseToJson['Err_Flag'],
        'User': dataMapper.getUserFromJson(responseToJson['data']),
        'AccessToken': responseToJson['data']['token'],
        'ExpiryDate': responseToJson['data']['expiryDate'],
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> getAchievements(String language) async {
    try {
      if (sessionManager.accessTokenExpired()) {
        await tokenApiCaller.refreshAccessToken();
      }
      var headers = {
        'Content-Type': 'application/json',
        'Content-Language': language,
        'Authorization': 'Bearer ${sessionManager.accessToken}',
      };
      print('$url/api/ahed/ahedachievement/');
      var response = await http
          .get(Uri.parse('$url/api/ahed/ahedachievement/'), headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        'Err_Flag': responseToJson['Err_Flag'],
        'Values': responseToJson['data']
      };
    } on TimeoutException {
      print('x');
      return responseHandler.timeOutPrinter();
    } on SocketException {
      print('y');
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> changeProfilePicture(String language,
      String userId, File image) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    FormData formData = FormData.fromMap({
      '_method': 'patch',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post('$url/api/profile/$userId/picture',
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      }
      if (e.response!.statusCode == 403) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else if (e.response!.statusCode == 404) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else {
        return responseHandler.errorPrinter('حدث خطأ ما.');
      }
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> changeCoverPicture(String language,
      String userId, File image) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    FormData formData = FormData.fromMap({
      '_method': 'patch',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post('$url/api/profile/$userId/cover',
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      }
      if (e.response!.statusCode == 403) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else if (e.response!.statusCode == 404) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else {
        return responseHandler.errorPrinter('حدث خطأ ما.');
      }
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  changeUserInformation(String language,
      String userId, String bio, String address, String phoneNumber) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    var body = {
      '_method': 'patch',
      'userId': userId,
      'bio': bio,
      'address': address,
      'phoneNumber': phoneNumber,
    };
    try {
      var response = await http
          .post(Uri.parse('$url/api/profile/$userId/information'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      print(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }
}
