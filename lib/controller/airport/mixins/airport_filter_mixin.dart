import 'package:feed/controller/airport/mixins/airport_utility_mixin.dart';
import 'package:feed/models/airport_model.dart';
import 'airport_data_loader_mixin.dart';

mixin AirportFiltersMixin on AirportDataLoaderMixin, AirportUtilitiesMixin {
  Future<List<Airport>> getAirportsByCountry(
    String countryCode, {
    int maxResults = 100,
  }) async {
    try {
      final allAirports = await loadAllAirports();

      final results = allAirports
          .where(
            (airport) =>
                airport.country.toLowerCase().contains(
                  countryCode.toLowerCase(),
                ) ||
                matchesCountryCode(airport.country, countryCode),
          )
          .toList();

      return results.take(maxResults).toList();
    } catch (e) {
      throw Exception('Error fetching airports by country: $e');
    }
  }

  Future<List<Airport>> getAirportsByCity(
    String city, {
    int maxResults = 50,
  }) async {
    try {
      final allAirports = await loadAllAirports();

      final results = allAirports
          .where(
            (airport) =>
                airport.city.toLowerCase().contains(city.toLowerCase()),
          )
          .toList();

      return results.take(maxResults).toList();
    } catch (e) {
      throw Exception('Error fetching airports by city: $e');
    }
  }

  /// Get airports by region/state
  Future<List<Airport>> getAirportsByRegion(
    String region, {
    int maxResults = 50,
  }) async {
    try {
      final allAirports = await loadAllAirports();

      final results = allAirports
          .where(
            (airport) =>
                airport.region.toLowerCase().contains(region.toLowerCase()),
          )
          .toList();

      return results.take(maxResults).toList();
    } catch (e) {
      throw Exception('Error fetching airports by region: $e');
    }
  }

  /// Get popular airports (major international airports)
  Future<List<Airport>> getPopularAirports() async {
    final popularIataCodes = [
      'JFK',
      'LAX',
      'LHR',
      'CDG',
      'DXB',
      'NRT',
      'SIN',
      'FRA',
      'AMS',
      'MAD',
      'FCO',
      'BCN',
      'MUC',
      'ZUR',
      'VIE',
      'BRU',
      'CPH',
      'ARN',
      'OSL',
      'HEL',
      'IST',
      'DOH',
      'SVO',
      'PEK',
      'PVG',
      'HKG',
      'ICN',
      'BOM',
      'DEL',
      'SYD',
      'MEL',
      'YYZ',
      'YVR',
      'ORD',
      'ATL',
      'DFW',
      'DEN',
      'SFO',
      'SEA',
      'LAS',
      'MIA',
      'BOS',
      'EWR',
      'IAD',
      'PHX',
      'CLT',
      'MCO',
      'LGA',
    ];

    try {
      final allAirports = await loadAllAirports();

      List<Airport> popularAirports = [];

      for (final iataCode in popularIataCodes) {
        final airport = allAirports.firstWhere(
          (airport) => airport.iata.toUpperCase() == iataCode,
          orElse: () => Airport(
            icao: '',
            iata: '',
            name: '',
            city: '',
            region: '',
            country: '',
            elevationFt: '',
            latitude: '',
            longitude: '',
            timezone: '',
          ),
        );

        if (airport.iata.isNotEmpty) {
          popularAirports.add(airport);
        }
      }

      return popularAirports;
    } catch (e) {
      throw Exception('Error fetching popular airports: $e');
    }
  }
}
