class UserModel {
  String name;
  String email;
  String image;
  String uid;
  List<String> favorite;

  UserModel(
      {required this.name,
      required this.email,
      required this.image,
      required this.favorite,
      required this.uid});
}
