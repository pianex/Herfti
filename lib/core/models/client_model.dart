import 'package:project_a/core/models/user_model.dart';

class ClientModel extends UserModel {
  final String facebook;
  final String instagram;
  final String whatsapp;
  final List<String> savedProfs;
  final List<String> likedPosts;
  ClientModel({
    required super.uid,
    required super.name,
    required super.imagePath,
    required super.phone,
    required super.email,
    required this.facebook,
    required this.instagram,
    required this.whatsapp,
    required super.description,
    required super.country,
    required super.state,
    required super.city,
    required super.timeAdded,
    required super.tokens,
    required this.savedProfs,
    required this.likedPosts,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "imagePath": imagePath,
      "phone": phone,
      "email": email,
      "facebook": facebook,
      "instagram": instagram,
      "whatsapp": whatsapp,
      "description": description,
      "country": country,
      "state": state,
      "city": city,
      "timeAdded": timeAdded,
      "tokens": tokens,
      "savedProfs": savedProfs,
      "likedPosts": likedPosts,
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      uid: json["uid"],
      name: json["name"],
      imagePath: json["imagePath"],
      phone: json["phone"],
      email: json["email"],
      facebook: json["facebook"] ?? "",
      instagram: json["instagram"] ?? "",
      whatsapp: json["whatsapp"] ?? "",
      description: json["description"],
      country: json["country"],
      state: json["state"],
      city: json["city"],
      timeAdded: json["timeAdded"],
      tokens: List<String>.from(json["tokens"]),
      savedProfs: List<String>.from(json["savedProfs"]),
      likedPosts: List<String>.from(json["likedPosts"]),
    );
  }
}
