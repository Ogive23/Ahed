import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:intl/intl.dart';

class TransactionApiCaller {
  String url = "http://192.168.1.4:8000";
  ResponseHandler responseHandler = new ResponseHandler();
  SessionManager sessionManager = new SessionManager();
  DataMapper dataMapper = new DataMapper();

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

  Future<Map<String, dynamic>> addOnlineTransactions(
      String userId, String needyId, int amount) async {
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
    var body = {'giver': userId, 'needy': needyId, 'amount': amount};
    try {
      print(url + "/api/ahed/onlinetransactions");
      var response = await http
          .post(Uri.parse(url + "/api/ahed/onlinetransactions"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
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

  Future<Map<String, dynamic>> addOfflineTransactions(
      String? userId,
      String needyId,
      String preferredSection,
      String phoneNumber,
      int amount,
      String address,
      DateTime startCollectDate,
      DateTime endCollectDate) async {
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
      'needy': needyId,
      'preferredSection': preferredSection,
      'amount': amount,
      'address': address,
      'phoneNumber': phoneNumber,
      'startCollectDate':
          DateFormat('y-MM-dd HH:mm:ss').format(startCollectDate),
      'endCollectDate': DateFormat('y-MM-dd HH:mm:ss').format(endCollectDate)
    };
    if (userId != null) {
      body.addAll({'giver': userId});
    }
    print(body);
    try {
      print(url + "/api/ahed/offlinetransactions");
      var response = await http
          .post(Uri.parse(url + "/api/ahed/offlinetransactions"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      return responseToJson;
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

  Future<Map<String, dynamic>> updateOfflineTransactions(
      String userId,
      String transactionId,
      String needyId,
      String preferredSection,
      double amount,
      String address,
      DateTime startCollectDate,
      DateTime endCollectDate) async {
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
      '_method': 'put',
      'userId': userId,
      'needy': needyId,
      'preferredSection': preferredSection,
      'amount': amount,
      'address': address,
      'startCollectDate':
          DateFormat('y-MM-dd HH:mm:ss').format(startCollectDate),
      'endCollectDate': DateFormat('y-MM-dd HH:mm:ss').format(endCollectDate)
    };
    try {
      print(url + "/api/ahed/offlinetransactions/$transactionId");
      var response = await http
          .post(Uri.parse(url + "/api/ahed/offlinetransactions/$transactionId"),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
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

  Future<Map<String, dynamic>> deleteOfflineTransactions(
      String userId, String transactionId, DateTime endCollectDate) async {
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
      'userId': userId,
    };
    try {
      print(url + "/api/ahed/offlinetransactions/$transactionId");
      var response = await http
          .delete(
              Uri.parse(url + "/api/ahed/offlinetransactions/$transactionId"),
              headers: headers,
              body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
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
