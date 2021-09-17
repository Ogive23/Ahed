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
import 'package:dio/dio.dart';

class NeedyApiCaller {
  String url = "http://192.168.1.5:8000";
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference urls = FirebaseFirestore.instance.collection('URLs');
  getAllUrgent(int pageNumber) async {
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
      print(url + "/api/ahed/urgentneedies?page=$pageNumber");
      var response = await http
          .get(Uri.parse(url + "/api/ahed/urgentneedies?page=$pageNumber"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(url);
      print(response.body);
      return {
        "Err_Flag": false,
        "Values": dataMapper.getNeediesFromJson(
            url, jsonDecode(response.body)['data']['data']),
        "total": jsonDecode(response.body)['data']['total'],
        "lastPage": jsonDecode(response.body)['data']['last_page']
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  getAll(int pageNumber) async {
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
      var response = await http
          .get(Uri.parse(url + "/api/ahed/needies?page=$pageNumber"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      return {
        "Err_Flag": false,
        "Values": dataMapper.getNeediesFromJson(
            url, jsonDecode(response.body)['data']['data']),
        "total": jsonDecode(response.body)['data']['total'],
        "lastPage": jsonDecode(response.body)['data']['last_page']
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  getAllBookmarked(List<String> bookmarkedIDs) async {
    print('bookmarkedIDs $bookmarkedIDs');
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
    print('url = $url');
    String params = '';
    for (int index = 0; index < bookmarkedIDs.length; index++)
      params += 'ids[${index.toString()}]=${bookmarkedIDs[index].toString()}&';
    print(url + '/api/ahed/neediesWithIDs?' + params);
    try {
      var response = await http
          .get(Uri.parse(url + "/api/ahed/neediesWithIDs?$params"),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      print(jsonDecode(response.body)['data']);
      return {
        "Err_Flag": false,
        "Values": dataMapper.getNeediesFromJson(
            url, jsonDecode(response.body)['data']),
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  create(String userId, String name, int age, int severity, String type,
      String details, int need, String address, List<File> images) async {
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
      'name': name,
      'age': age,
      'severity': severity,
      'type': type,
      'details': details,
      'need': need,
      'address': address,
      'createdBy': userId,
      for (int index = 0; index < images.length; index++)
        "images[$index]": await MultipartFile.fromFile(images[index].path),
    });
    // for (int index = 0; index < images.length; index++)
    //   body.addAll({'images[$index]': '${images[index].path}'});
    print('url = $url');
    print(formData.files);
    try {
      var response = await Dio()
          .post(url + "/api/ahed/needies",
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
      }
      else if (e.response!.statusCode == 404) {
        print(e.response);
        var responseToJson = jsonDecode(e.response.toString());
        return responseToJson;
      } else {
        return responseHandler.errorPrinter('حدث خطأ ما.');
      }
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  getById(String id) async {
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
      var response = await http
          .get(Uri.parse(url + "/api/ahed/needies/$id"), headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      return {
        "Err_Flag": false,
        "Value":
            dataMapper.getNeedyFromJson(url, jsonDecode(response.body)['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler
          .errorPrinter("برجاء التأكد من خدمة الإنترنت لديك");
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }
}
