import 'dart:math';

import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:ahed/Models/User.dart';

import '../Models/Needy.dart';
import '../Models/NeedyMedia.dart';

class DataMapper {
  Helper helper = new Helper();

  List<NeedyMedia> getNeediesMediaFromJson(String baseURL, List<dynamic> list) {
    print('here');
    List<NeedyMedia> returnedNeediesMedia = [];
    list.forEach((element) {
      returnedNeediesMedia.add(
          new NeedyMedia(element['id'].toString(), baseURL + element['path']));
    });
    return returnedNeediesMedia;
  }

  List<Needy> getNeediesFromJson(String baseURL, List<dynamic> list) {
    List<Needy> returnedNeedies = [];
    list.forEach((element) {
      print(element['createdBy']['image']);
      returnedNeedies.add(Needy(
        element['id'].toString(),
        element['name'].toString(),
        double.parse(element['age'].toString()),
        int.parse(element['severity'].toString()),
        element['type'],
        element['details'],
        double.parse(element['need'].toString()),
        double.parse(element['collected'].toString()),
        element['address'],
        element['satisfied'] == 1 ? true : false,
        element['approved'] == 1 ? true : false,
        DateTime.parse(element['created_at']),
        this.getNeediesMediaFromJson(baseURL, element['medias_before']),
        this.getNeediesMediaFromJson(baseURL, element['medias_after']),
        element['url'],
        element['createdBy']['id'].toString(),
        element['createdBy']['name'].toString(),
        element['createdBy']['image'] != null
            ? baseURL + element['createdBy']['image']
            : 'N/A',
        element['createdBy']['email_verified_at'] != null ? true : false,
      ));
    });
    return returnedNeedies;
  }

  User getUserFromJson(String url, Map<String, dynamic> info) {
    return User(
        helper.getAppropriateText(info['user']['id']),
        helper.getAppropriateText(info['user']['name'].toString()),
        helper.getAppropriateText(info['user']['user_name'].toString()),
        helper.getAppropriateText(info['user']['email'].toString()),
        helper.getAppropriateText(info['user']['gender'].toString()),
        helper.getAppropriateText(info['user']['phone_number'].toString()),
        helper.getAppropriateText(info['user']['address'].toString()),
        info['user']['email_verified_at'] != null ? true : false,
        info['token'],
        info['profile']['image'] != null
            ? url + info['profile']['image']
            : 'N/A',
        info['profile']['cover'] != null
            ? url + info['profile']['cover']
            : 'N/A',
        helper.getAppropriateText(info['profile']['bio'].toString()));
  }

  List<OnlineTransaction> getOnlineTransactionsFromJson(List<dynamic> data) {
    List<OnlineTransaction> returnedOnlineTransactions = [];
    data.forEach((onlineTransaction) {
      returnedOnlineTransactions.add(OnlineTransaction(
          onlineTransaction['id'].toString(),
          onlineTransaction['giver'].toString(),
          onlineTransaction['needy'].toString(),
          double.parse(onlineTransaction['amount'].toString()),
          DateTime.parse(onlineTransaction['created_at']),
          'OnlineTransaction',
          double.parse(onlineTransaction['remaining'].toString())));
    });
    return returnedOnlineTransactions;
  }

  List<OfflineTransaction> getOfflineTransactionsFromJson(List<dynamic> data) {
    List<OfflineTransaction> returnedOfflineTransactions = [];
    data.forEach((offlineTransaction) {
      returnedOfflineTransactions.add(OfflineTransaction(
          offlineTransaction['id'].toString(),
          offlineTransaction['giver'].toString(),
          offlineTransaction['needy'].toString(),
          double.parse(offlineTransaction['amount'].toString()),
          DateTime.parse(offlineTransaction['created_at']),
          'OfflineTransaction',
          offlineTransaction['preferredSection'].toString(),
          offlineTransaction['address'].toString(),
          offlineTransaction['phoneNumber'].toString(),
          DateTime.parse(offlineTransaction['startCollectDate']),
          DateTime.parse(offlineTransaction['endCollectDate']),
          offlineTransaction['selectedDate'] != null
              ? DateTime.parse(offlineTransaction['selectedDate'])
              : null,
          offlineTransaction['collected'] == 1 ? true : false));
    });
    return returnedOfflineTransactions;
  }

  getNeedyFromJson(String baseURL,Map<String,dynamic> json) {
    print(json);
    return Needy(
        json['id'].toString(),
        json['name'].toString(),
        double.parse(json['age'].toString()),
        int.parse(json['severity'].toString()),
        json['type'],
        json['details'],
        double.parse(json['need'].toString()),
        double.parse(json['collected'].toString()),
        json['address'],
        json['satisfied'] == 1 ? true : false,
        json['approved'] == 1 ? true : false,
        DateTime.parse(json['created_at']),
        this.getNeediesMediaFromJson(baseURL, json['medias_before']),
        this.getNeediesMediaFromJson(baseURL, json['medias_after']),
        json['url'],
        json['createdBy']['id'].toString(),
        json['createdBy']['name'].toString(),
        json['createdBy']['image'] != null
            ? baseURL + json['createdBy']['image']
            : 'N/A',
        json['createdBy']['email_verified_at'] != null ? true : false);
  }
}
