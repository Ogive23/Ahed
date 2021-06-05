class User{
  String id;
  String name;
  String username;
  String email;
  String gender;
  String phoneNumber;
  String address;
  String image;
  bool verified;
  User(this.id,this.name,this.username,this.email,this.gender,this.phoneNumber,this.address,this.image,this.verified);

  List<String> toList() {
    return [this.id,this.name,this.username,this.email,this.gender,this.phoneNumber,this.address,this.image,this.verified.toString()];
  }
}