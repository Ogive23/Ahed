import 'dart:io';

import 'package:ahed/ApiCallers/TokenApiCaller.dart';
import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
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
  String url = "http://192.168.1.6:8000";

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
      if (responseToJson['Err_Flag']) return responseToJson;
      //ToDo:move this "/storage/" to backend and make it full link
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values": dataMapper.getUserFromJson(url, responseToJson['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك.");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما.');
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
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك.");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما.');
    }
    // }
  }

  Future<Map<String, dynamic>> getOnlineTransactions(String userId) async {
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
      print(url + "/api/ahed/onlinetransactions?userId=$userId");
      var response = await http
          .get(Uri.parse(url + "/api/ahed/onlinetransactions?userId=$userId"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values":
            dataMapper.getOnlineTransactionsFromJson(responseToJson['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك.");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما.');
    }
    // }
  }
  Future<Map<String, dynamic>> getOfflineTransactions(String userId) async {
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
      print(url + "/api/ahed/offlinetransactions?userId=$userId");
      var response = await http
          .get(Uri.parse(url + "/api/ahed/offlinetransactions?userId=$userId"),
          headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values":
        dataMapper.getOfflineTransactionsFromJson(responseToJson['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك.");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما.');
    }
    // }
  }
}
