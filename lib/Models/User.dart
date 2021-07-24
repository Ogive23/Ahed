class User {
  String id;
  String name;
  String username;
  String email;
  String gender;
  String phoneNumber;
  String address;
  bool verified;
  String accessToken;
  String? profileImage;
  String? profileCover;
  String? profileBio;

  User(
      this.id,
      this.name,
      this.username,
      this.email,
      this.gender,
      this.phoneNumber,
      this.address,
      this.verified,
      this.accessToken,
      this.profileImage,
      this.profileCover,
      this.profileBio);

  List<String> toList() {
    return [
      this.id,
      this.name,
      this.username,
      this.email,
      this.gender,
      this.phoneNumber,
      this.address,
      this.verified.toString(),
      this.accessToken.toString(),
      this.profileImage!,
      this.profileCover!,
      this.profileBio!
    ];
  }
}
