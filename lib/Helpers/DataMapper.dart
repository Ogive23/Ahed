import 'dart:math';

import '../Models/Needy.dart';
import '../Models/NeedyMedia.dart';

class DataMapper {
  String getSeverityClass(int severity) {
    if (severity > 0 && severity < 4) return 'Low';
    if (severity > 4 && severity < 7) return 'Medium';
    return 'High';
  }

  List<NeedyMedia> getNeediesMediaFromJson(String baseURL,List<dynamic> list) {
    List<NeedyMedia> returnedNeediesMedia = [];
    list.forEach((element) {
      print(element);
      print(element['id'].toString());
      print(element['path']);
      returnedNeediesMedia
          .add(new NeedyMedia(element['id'].toString(), baseURL + element['path']));
    });
    return returnedNeediesMedia;
  }

  //ToDo:Remove
  String getRandomCharity(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'Resala';
      case 1:
        return 'Gamiet El-Br';
      case 2:
        return 'El Jalila';
      case 3:
        return 'Khalaf Ahmad Al Habtoor';
      case 4:
        return 'Magdi Yacoub';
    }
  }

  //ToDo:Remove
  String getRandomCharityImage(int randomNumber) {
    print(randomNumber);
    switch (randomNumber) {
      case 0:
        return 'assets/images/bSOfYXcD_400x400.png';
      case 1:
        return 'assets/images/dar-al-ber-society.jpg';
      case 2:
        return 'assets/images/1519881695999.png';
      case 3:
        return 'assets/images/khalaf-al-habtoor.jpg';
      case 4:
        return 'assets/images/1519887944403.png';
    }
  }

  List<Needy> getNeediesFromJson(String baseURL, List<dynamic> list) {
    int random = Random().nextInt(4);
    List<Needy> returnedNeedies = [];
    list.forEach((element) {
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
          //ToDo:Remove
          getRandomCharity(random),
          //ToDo:Remove
          getRandomCharityImage(random)));
    });
    return returnedNeedies;
  }
}
