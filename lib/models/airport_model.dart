class Airport {
  final String icao;
  final String iata;
  final String name;
  final String city;
  final String region;
  final String country;
  final String elevationFt;
  final String latitude;
  final String longitude;
  final String timezone;
  final String phone;
  final String email;
  final String url;
  final String runwayLength;
  final String directFlights;
  final String carriers;
  final String woeid;
  final String type;

  Airport({
    required this.icao,
    required this.iata,
    required this.name,
    required this.city,
    required this.region,
    required this.country,
    required this.elevationFt,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    this.phone = '',
    this.email = '',
    this.url = '',
    this.runwayLength = '',
    this.directFlights = '',
    this.carriers = '',
    this.woeid = '',
    this.type = '',
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      icao: json['icao'] ?? '',
      iata: json['code'] ?? '', // Note: using 'code' field from new JSON
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      region: json['state'] ?? '', // Note: using 'state' field from new JSON
      country: json['country'] ?? '',
      elevationFt: json['elev'] ?? '', // Note: using 'elev' field from new JSON
      latitude: json['lat'] ?? '', // Note: using 'lat' field from new JSON
      longitude: json['lon'] ?? '', // Note: using 'lon' field from new JSON
      timezone: json['tz'] ?? '', // Note: using 'tz' field from new JSON
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      url: json['url'] ?? '',
      runwayLength: json['runway_length'] ?? '',
      directFlights: json['direct_flights'] ?? '',
      carriers: json['carriers'] ?? '',
      woeid: json['woeid'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icao': icao,
      'code': iata, // Using 'code' to match new JSON format
      'name': name,
      'city': city,
      'state': region, // Using 'state' to match new JSON format
      'country': country,
      'elev': elevationFt, // Using 'elev' to match new JSON format
      'lat': latitude, // Using 'lat' to match new JSON format
      'lon': longitude, // Using 'lon' to match new JSON format
      'tz': timezone, // Using 'tz' to match new JSON format
      'phone': phone,
      'email': email,
      'url': url,
      'runway_length': runwayLength,
      'direct_flights': directFlights,
      'carriers': carriers,
      'woeid': woeid,
      'type': type,
    };
  }

  String get displayName => '$iata - $name';

  String get fullDisplayName => '$iata - $name, $city, $country';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Airport &&
          runtimeType == other.runtimeType &&
          iata == other.iata;

  @override
  int get hashCode => iata.hashCode;

  @override
  String toString() => displayName;
}
