class ProfModel {
  final String uid;
  final String name;
  final String imagePath;
  final String phone;
  final String email;
  final String description;
  final int type;
  final String country;
  final String state;
  final String city;
  final int saves;
  final String timeAdded;
  ProfModel({
    required this.uid,
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
    required this.description,
    required this.country,
    required this.state,
    required this.city,
    required this.type,
    required this.saves,
    required this.timeAdded,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "imagePath": imagePath,
    "phone": phone,
    "description": description,
    "type": type,
    "saves": saves,
    "timeAdded": timeAdded,
    "country": country,
    "state": state,
    "city": city,
  };
}
