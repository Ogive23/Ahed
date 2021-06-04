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
  List<String> imagesBefore;
  List<String> imagesAfter;
  String url;
  String createdBy;
  String createdByImage;

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
      this.createdBy,
      this.createdByImage);
}
