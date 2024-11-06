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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      image: json['image'],
      name: json['name'],
      uid: json['uid'],
      favorite:
          json['favorite'] == null ? [] : List<String>.from(json['favorite']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'name': name,
      'uid': uid,
    };
  }
}
