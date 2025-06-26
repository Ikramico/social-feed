import 'dart:convert';
import 'package:feed/models/airport_model.dart';
import 'package:http/http.dart' as http;

mixin AirportDataLoaderMixin {
  // URL to the GitHub Gist containing the airport JSON data
  static const String _jsonUrl =
      'https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json';

  static List<Airport>? _allAirports;
  static DateTime? _lastFetchTime;
  static const int _cacheExpiryMinutes = 60; // Cache for 1 hour

  /// Load all airports from the JSON file
  Future<List<Airport>> loadAllAirports() async {
    // Check if we have cached data and it's still valid
    if (_allAirports != null && _lastFetchTime != null) {
      final now = DateTime.now();
      if (now.difference(_lastFetchTime!).inMinutes < _cacheExpiryMinutes) {
        return _allAirports!;
      }
    }

    try {
      print('Fetching airports from JSON...'); // Debug print

      final response = await http.get(Uri.parse(_jsonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _allAirports = jsonData
            .map((json) => Airport.fromJson(json))
            .where((airport) => airport.iata.isNotEmpty)
            .toList();

        _lastFetchTime = DateTime.now();

        print('Loaded ${_allAirports!.length} airports'); // Debug print
        return _allAirports!;
      } else {
        throw Exception('Failed to load airports JSON: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading airports: $e'); // Debug print
      throw Exception('Error loading airports: $e');
    }
  }

  /// Get all airports (for debugging or full dataset access)
  Future<List<Airport>> getAllAirports() async {
    return await loadAllAirports();
  }

  /// Clear the cached airport data
  void clearCache() {
    _allAirports = null;
    _lastFetchTime = null;
  }
}
