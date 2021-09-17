import 'dart:io';

import 'package:ahed/ApiCallers/TokenApiCaller.dart';
import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserApiCaller {
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference urls = FirebaseFirestore.instance.collection('URLs');
  String url = "http://192.168.1.5:8000";

  Future<Map<String, dynamic>> login(String email, String password) async {
    // if (sessionManager.accessTokenExpired()) {
    //   await tokenApiCaller.refreshAccessToken(sessionManager.user.id,sessionManager.oauthToken);
    // }
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer ${sessionManager.oauthToken}',
    };
    var body = {"email": email, "password": password};
    try {
      var response = await http
          .post(Uri.parse(url + "/api/login"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        print(error);
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      if (responseToJson['Err_Flag']) return responseToJson;
      //ToDo:move this "/storage/" to backend and make it full link
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "User": dataMapper.getUserFromJson(url, responseToJson['data']),
        "AccessToken": responseToJson['data']['token'],
        "ExpiryDate": responseToJson['data']['expiryDate'],
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> getAchievements(String? id) async {
    // QuerySnapshot snapshot = await urls.get();
    // for(int index = 0; index < snapshot.size; index++){
    //   String url = snapshot.docs[index]['url'];
    // if (sessionManager.accessTokenExpired()) {
    //   await tokenApiCaller.refreshAccessToken(sessionManager.user.id,sessionManager.oauthToken);
    // }
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer ${sessionManager.oauthToken}',
    };
    try {
      print(url + "/api/ahed/ahedachievement/$id");
      var response = await http
          .get(Uri.parse(url + "/api/ahed/ahedachievement/$id"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values": responseToJson['data']
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  Future<Map<String, dynamic>> changeProfilePicture(
      String userId, File image) async {
    // QuerySnapshot snapshot = await urls.get();
    // for(int index = 0; index < snapshot.size; index++){
    //   String url = snapshot.docs[index]['url'];
    // if (sessionManager.accessTokenExpired()) {
    //   await tokenApiCaller.refreshAccessToken(sessionManager.user.id,sessionManager.oauthToken);
    // }
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer ${sessionManager.oauthToken}',
    };
    FormData formData = new FormData.fromMap({
      '_method': 'patch',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(url + "/api/profile/$userId/picture",
              data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioError catch (e) {
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
      return responseHandler.errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }
  Future<Map<String, dynamic>> changeCoverPicture(
      String userId, File image) async {
    // QuerySnapshot snapshot = await urls.get();
    // for(int index = 0; index < snapshot.size; index++){
    //   String url = snapshot.docs[index]['url'];
    // if (sessionManager.accessTokenExpired()) {
    //   await tokenApiCaller.refreshAccessToken(sessionManager.user.id,sessionManager.oauthToken);
    // }
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer ${sessionManager.oauthToken}',
    };
    FormData formData = new FormData.fromMap({
      '_method': 'patch',
      'userId': userId,
      'image': await MultipartFile.fromFile(image.path),
    });
    try {
      var response = await Dio()
          .post(url + "/api/profile/$userId/cover",
          data: formData, options: Options(headers: headers))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      var responseToJson = jsonDecode(response.toString());
      return responseToJson;
    } on DioError catch (e) {
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
      return responseHandler.errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  changeUserInformation(String userId,String bio, String address, String phoneNumber) async {
    // QuerySnapshot snapshot = await urls.get();
    // for(int index = 0; index < snapshot.size; index++){
    //   String url = snapshot.docs[index]['url'];
    // if (sessionManager.accessTokenExpired()) {
    //   await tokenApiCaller.refreshAccessToken(sessionManager.user.id,sessionManager.oauthToken);
    // }
    var headers = {
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer ${sessionManager.oauthToken}',
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
          .post(Uri.parse(url + "/api/profile/$userId/information"),
          headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(response);
      return jsonDecode(response.body);
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }
}
