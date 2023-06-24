import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ahed/ApiCallers/TokenApiCaller.dart';
import 'package:http/http.dart' as http;

import 'package:ahed/Helpers/DataMapper.dart';
import 'package:ahed/Helpers/ResponseHandler.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:intl/intl.dart';

class TransactionApiCaller {
  String url = 'http://192.168.1.2:8000';
  ResponseHandler responseHandler = ResponseHandler();
  SessionManager sessionManager = SessionManager();
  DataMapper dataMapper = DataMapper();
  TokenApiCaller tokenApiCaller = TokenApiCaller();

  Future<Map<String, dynamic>> getOnlineTransactions(
      String language, String userId) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    try {
      print('$url/api/ahed/onlinetransactions?userId=$userId');
      var response = await http
          .get(Uri.parse('$url/api/ahed/onlinetransactions?userId=$userId'),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      return {
        'Err_Flag': responseToJson['Err_Flag'],
        'Values':
            dataMapper.getOnlineTransactionsFromJson(url, responseToJson['data'])
      };
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
    // }
  }

  Future<Map<String, dynamic>> getOfflineTransactions(
      String language, String userId) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    try {
      print('$url/api/ahed/offlinetransactions?userId=$userId');
      var response = await http
          .get(Uri.parse('$url/api/ahed/offlinetransactions?userId=$userId'),
              headers: headers)
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      if (responseToJson['Err_Flag']) return responseToJson;
      print(responseToJson);
      return {
        'Err_Flag': responseToJson['Err_Flag'],
        'Values':
            dataMapper.getOfflineTransactionsFromJson(url, responseToJson['data'])
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

  Future<Map<String, dynamic>> addOnlineTransaction(
      String language,
      String? userId,
      String needyId,
      int amount,
      String cardNumber,
      String expiryDate,
      String cvv) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    var body = {
      'giver': userId,
      'needy': needyId,
      'amount': amount,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv
    };
    try {
      print('$url/api/ahed/onlinetransactions');
      var response = await http
          .post(Uri.parse('$url/api/ahed/onlinetransactions'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> addOfflineTransaction(
      String language,
      String? userId,
      String needyId,
      String preferredSection,
      String phoneNumber,
      int amount,
      String address,
      DateTime startCollectDate,
      DateTime endCollectDate) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
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
      print('$url/api/ahed/offlinetransactions');
      var response = await http
          .post(Uri.parse('$url/api/ahed/offlinetransactions'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      print(responseToJson);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> updateOfflineTransaction(
      String language,
      String? userId,
      String transactionId,
      String needyId,
      String preferredSection,
      String mobileNumber,
      int amount,
      String address,
      DateTime startCollectDate,
      DateTime endCollectDate) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    var body = {
      '_method': 'put',
      'userId': userId,
      'needy': needyId,
      'preferredSection': preferredSection,
      'phoneNumber': mobileNumber,
      'amount': amount,
      'address': address,
      'startCollectDate':
          DateFormat('y-MM-dd HH:mm:ss').format(startCollectDate),
      'endCollectDate': DateFormat('y-MM-dd HH:mm:ss').format(endCollectDate)
    };
    try {
      print('$url/api/ahed/offlinetransactions/$transactionId');
      var response = await http
          .post(Uri.parse('$url/api/ahed/offlinetransactions/$transactionId'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
    } on TimeoutException {
      return responseHandler.timeOutPrinter();
    } on SocketException {
      return responseHandler.errorPrinter('برجاء التأكد من خدمة الإنترنت لديك');
    } catch (e) {
      print('e = $e');
      return responseHandler.errorPrinter('حدث خطأ ما');
    }
  }

  Future<Map<String, dynamic>> deleteOfflineTransactions(
      String language, String userId, String transactionId) async {
    if (sessionManager.accessTokenExpired()) {
      await tokenApiCaller.refreshAccessToken();
    }
    var headers = {
      'Content-Type': 'application/json',
      'Content-Language': language,
      'Authorization': 'Bearer ${sessionManager.accessToken}',
    };
    var body = {
      'userId': userId,
    };
    try {
      print('$url/api/ahed/offlinetransactions/$transactionId');
      var response = await http
          .delete(Uri.parse('$url/api/ahed/offlinetransactions/$transactionId'),
              headers: headers, body: jsonEncode(body))
          .catchError((error) {
        throw error;
      }).timeout(const Duration(seconds: 120));
      var responseToJson = jsonDecode(response.body);
      return responseToJson;
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
