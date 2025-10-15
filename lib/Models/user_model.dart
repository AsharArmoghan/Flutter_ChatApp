class UserModel {
  final String id;
  final String email;
  final String name;
  final dynamic userProfile;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.userProfile});
}
