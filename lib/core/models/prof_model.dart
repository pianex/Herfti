class ProfModel {
  final String uid;
  final String name;
  final String imagePath;
  final String phone;
  final String email;
  final String facebook;
  final String instagram;
  final String whatsapp;
  final String description;
  final int xp;
  final String services;
  final bool travel;
  final bool available;
  final int type;
  final String category;
  final String country;
  final String state;
  final String city;
  final int saves;
  final String timeAdded;
  final List<String> tokens;
  ProfModel({
    required this.uid,
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
    required this.facebook,
    required this.instagram,
    required this.whatsapp,
    required this.description,
    required this.xp,
    required this.services,
    required this.travel,
    required this.available,
    required this.country,
    required this.state,
    required this.city,
    required this.type,
    required this.category,
    required this.saves,
    required this.timeAdded,
    required this.tokens,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "imagePath": imagePath,
    "phone": phone,
    "email": email,
    "facebook": facebook,
    "instagram": instagram,
    "whatsapp": whatsapp,
    "description": description,
    "xp": xp,
    "services": services,
    "travel": travel,
    "available": available,
    "type": type,
    "category": category,
    "saves": saves,
    "timeAdded": timeAdded,
    "country": country,
    "state": state,
    "city": city,
    "tokens": tokens,
  };
}
