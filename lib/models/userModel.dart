class UserModel {
  String? email;
  String? name;
  String? phone;
  String? age;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.age,
    this.uId,
    this.image,
    this.cover,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    age = json['age'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'age': age,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
