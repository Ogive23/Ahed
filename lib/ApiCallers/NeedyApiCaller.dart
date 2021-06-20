import 'package:ahed/ApiCallers/TokenApiCaller.dart';
import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Session/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NeedyApiCaller {
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();
  TokenApiCaller tokenApiCaller = new TokenApiCaller();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference urls = FirebaseFirestore.instance.collection('URLs');
  String url = "http://192.168.1.2:8000";
  getAllUrgent() async {
    // QuerySnapshot snapshot = await urls.get();
    // for(int index = 0; index < snapshot.size; index++){
    //   String url = snapshot.docs[index]['url'];
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } catch (e) {
      print(e);
      return e;
    }
    // }
  }
  getAll() async {
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
      try {
        var response = await http.get(Uri.parse(url+"/api/ahed/needies"), headers: headers).catchError((error) {
          return responseHandler.errorPrinter("networkError");
        }).timeout(Duration(seconds: 120));
        print(response.body);
        //ToDo:move this "/storage/" to backend and make it full link
        return {"Err_Flag": false, "Values": dataMapper.getNeediesFromJson(url+"/storage/", jsonDecode(response.body)['data']['data'])};
      } on TimeoutException {
        return responseHandler.timeOutPrinter();
      } catch (e) {
        print(e);
        return responseHandler.errorPrinter("networkError");
      }
    // }
  }
  create() async {
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
      try {
        var response = await http.get(Uri.parse(url+"/api/ahed/needies"), headers: headers).catchError((error) {
          return responseHandler.errorPrinter("networkError");
        }).timeout(Duration(seconds: 120));
        print(response.body);
        //ToDo:move this "/storage/" to backend and make it full link
        return {"Err_Flag": false, "Values": dataMapper.getNeediesFromJson(url+"/storage/", jsonDecode(response.body)['data']['data'])};
      } on TimeoutException {
        return responseHandler.timeOutPrinter();
      } catch (e) {
        print(e);
        return responseHandler.errorPrinter("networkError");
      }
    // }
  }
}