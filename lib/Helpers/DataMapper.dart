import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/OfflineTransaction.dart';
import 'package:ahed/Models/OnlineTransaction.dart';
import 'package:ahed/Models/User.dart';

import '../Models/Needy.dart';
import '../Models/NeedyMedia.dart';

class DataMapper {
  Helper helper = Helper();

  List<NeedyMedia> getNeediesMediaFromJson(String baseURL, List<dynamic> list) {
    print('here');
    List<NeedyMedia> returnedNeediesMedia = [];
    for (var element in list) {
      returnedNeediesMedia
          .add(NeedyMedia(element['id'].toString(), baseURL + element['path']));
    }
    return returnedNeediesMedia;
  }

  List<Needy> getNeediesFromJson(String baseURL, List<dynamic> list) {
    List<Needy> returnedNeedies = [];
    for (var element in list) {
      print(element['created_by']['profile']['image']);
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
        getNeediesMediaFromJson(baseURL, element['medias_before']),
        getNeediesMediaFromJson(baseURL, element['medias_after']),
        element['url'],
        element['created_by']['id'].toString(),
        element['created_by']['name'].toString(),
        element['created_by']['profile']['image'],
        element['created_by']['email_verified_at'] != null ? true : false,
      ));
    }
    return returnedNeedies;
  }

  User getUserFromJson(Map<String, dynamic> info) {
    return User(
        info['user']['id'].toString(),
        info['user']['name'].toString(),
        info['user']['user_name'].toString(),
        info['user']['email'].toString(),
        info['user']['gender'].toString(),
        info['user']['phone_number'].toString(),
        info['user']['address']?.toString(),
        info['user']['email_verified_at'] != null ? true : false,
        info['profile']['image'],
        info['profile']['cover'],
        info['profile']['bio']?.toString());
  }

  List<OnlineTransaction> getOnlineTransactionsFromJson(
      String url, List<dynamic> data) {
    List<OnlineTransaction> returnedOnlineTransactions = [];
    for (var onlineTransaction in data) {
      returnedOnlineTransactions.add(OnlineTransaction(
          onlineTransaction['id'].toString(),
          onlineTransaction['giver'].toString(),
          getNeedyFromJson(url, onlineTransaction['needy']),
          double.parse(onlineTransaction['amount'].toString()),
          DateTime.parse(onlineTransaction['created_at']),
          'OnlineTransaction',
          double.parse(onlineTransaction['remaining'].toString())));
    }
    return returnedOnlineTransactions;
  }

  List<OfflineTransaction> getOfflineTransactionsFromJson(
      String url, List<dynamic> data) {
    List<OfflineTransaction> returnedOfflineTransactions = [];
    for (var offlineTransaction in data) {
      returnedOfflineTransactions.add(OfflineTransaction(
          offlineTransaction['id'].toString(),
          offlineTransaction['giver'].toString(),
          getNeedyFromJson(url, offlineTransaction['needy']),
          double.parse(offlineTransaction['amount'].toString()),
          DateTime.parse(offlineTransaction['created_at']),
          'OfflineTransaction',
          offlineTransaction['preferred_section'].toString(),
          offlineTransaction['address'].toString(),
          offlineTransaction['phone_number'].toString(),
          DateTime.parse(offlineTransaction['start_collect_date']),
          DateTime.parse(offlineTransaction['end_collect_date']),
          offlineTransaction['selected_date'] != null
              ? DateTime.parse(offlineTransaction['selected_date'])
              : null,
          offlineTransaction['collected']));
    }
    return returnedOfflineTransactions;
  }

  getNeedyFromJson(String baseURL, Map<String, dynamic> json) {
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
        json['satisfied'],
        json['approved'],
        DateTime.parse(json['created_at']),
        getNeediesMediaFromJson(baseURL, json['medias_before']),
        getNeediesMediaFromJson(baseURL, json['medias_after']),
        json['url'],
        json['createdBy'] != null ? json['createdBy']['id'].toString() : null,
        json['createdBy'] != null ? json['createdBy']['name'].toString() : null,
        json['createdBy'] != null ? json['createdBy']['image'] : null,
        json['createdBy'] != null
            ? json['createdBy']['email_verified_at']
            : null
        );
  }
}
