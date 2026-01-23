abstract class UserModel {
  final String uid;
  final String name;
  final String imagePath;
  final String phone;
  final String email;
  final String description;
  final String country;
  final String state;
  final String city;
  final String timeAdded;
  final List<String> tokens;
  UserModel({
    required this.uid,
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
    required this.description,
    required this.country,
    required this.state,
    required this.city,
    required this.timeAdded,
    required this.tokens,
  });
}
