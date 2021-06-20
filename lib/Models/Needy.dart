import 'NeedyMedia.dart';

class Needy {
  String id;
  String name;
  double age;
  int severity;
  String severityClass;
  String type;
  String details;
  double need;
  double collected;
  String address;
  bool satisfied;
  bool approved;
  DateTime createdOn;
  List<NeedyMedia> imagesBefore;
  List<NeedyMedia> imagesAfter;
  String url;
  String createdById;
  String createdByName;
  String createdByImage;
  bool createdByVerified;

  Needy(
      this.id,
      this.name,
      this.age,
      this.severity,
      this.severityClass,
      this.type,
      this.details,
      this.need,
      this.collected,
      this.address,
      this.satisfied,
      this.approved,
      this.createdOn,
      this.imagesBefore,
      this.imagesAfter,
      this.url,
      this.createdById,
      this.createdByName,
      this.createdByImage,
      this.createdByVerified);
}
