import 'dart:math';

import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Models/User.dart';

import '../Models/Needy.dart';
import '../Models/NeedyMedia.dart';

class DataMapper {
  Helper helper = new Helper();

  String getSeverityClass(int severity) {
    if (severity > 0 && severity < 4) return 'Low';
    if (severity > 4 && severity < 7) return 'Medium';
    return 'High';
  }

  List<NeedyMedia> getNeediesMediaFromJson(String baseURL, List<dynamic> list) {
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
        getSeverityClass(element['severity']),
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
        info['profile']['image'] != null? url + info['profile']['image'] : 'N/A',
        info['profile']['cover'] != null? url + info['profile']['cover'] : 'N/A',
        helper.getAppropriateText(info['profile']['bio'].toString()));
  }
}
