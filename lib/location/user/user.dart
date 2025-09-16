class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      lat: (data['lat'] ?? 0).toDouble(),
      lng: (data['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class User {
  final String id;
  final String name;
  final Location location;

  User({
    required this.id,
    required this.name,
    required this.location,
  });

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      name: data['name'] ?? '',
      location: Location.fromMap(data['location'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location.toMap(),
    };
  }
}
