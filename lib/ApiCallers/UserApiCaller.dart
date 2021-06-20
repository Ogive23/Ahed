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
  String url = "http://192.168.1.2:8000";

  Future<Map<String, dynamic>>login(String email, String password) async {
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
    var body = {"email": email, "password": password};
    try {
      var response = await http
          .post(Uri.parse(url + "/api/login"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        print(error);
        throw responseHandler.errorPrinter("Kindly check your internet connection then try again.");
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      //ToDo:move this "/storage/" to backend and make it full link
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values": dataMapper.getUserFromJson(url,responseToJson['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } catch (e) {
      print('e $e');
      return e;
    }
    // }
  }

  Future<Map<String, dynamic>> getAchievements(String id) async {
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
          .get(Uri.parse(url + "/api/ahed/ahedachievement/$id"),
              headers: headers)
          .catchError((error) {
        throw responseHandler.errorPrinter("networkError");
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        "Err_Flag": responseToJson['Err_Flag'],
        "Values": responseToJson['data']
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } catch (e) {
      print('e $e');
      return responseHandler.errorPrinter(
          "Kindly check your internet connection then try again.");
    }
    // }
  }
}
