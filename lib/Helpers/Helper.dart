class Helper{
  bool notNull(dynamic object){
    return object != null && object != 'null';
  }

  String getAppropriateText(dynamic object) {
    return notNull(object) ? object.toString() : 'N/A';
  }
}