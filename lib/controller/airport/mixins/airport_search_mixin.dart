import 'package:feed/controller/airport/mixins/airport_utility_mixin.dart';
import 'package:feed/models/airport_model.dart';
import 'airport_data_loader_mixin.dart';

mixin AirportSearchMixin on AirportDataLoaderMixin, AirportUtilitiesMixin {
  Future<List<Airport>> searchAirports({
    String? name,
    String? city,
    String? country,
    String? countryCode,
    String? iata,
    String? icao,
    int offset = 0,
    int limit = 50,
  }) async {
    try {
      final allAirports = await loadAllAirports();

      List<Airport> filteredAirports = allAirports.where((airport) {
        // Apply filters
        if (name != null && name.isNotEmpty) {
          if (!airport.name.toLowerCase().contains(name.toLowerCase())) {
            return false;
          }
        }

        if (city != null && city.isNotEmpty) {
          if (!airport.city.toLowerCase().contains(city.toLowerCase())) {
            return false;
          }
        }

        if (country != null && country.isNotEmpty) {
          if (!airport.country.toLowerCase().contains(country.toLowerCase())) {
            return false;
          }
        }

        if (countryCode != null && countryCode.isNotEmpty) {
          // Check if country name matches the code (like "US" for "United States")
          if (!matchesCountryCode(airport.country, countryCode)) {
            return false;
          }
        }

        if (iata != null && iata.isNotEmpty) {
          if (airport.iata.toLowerCase() != iata.toLowerCase()) {
            return false;
          }
        }

        if (icao != null && icao.isNotEmpty) {
          if (airport.icao.toLowerCase() != icao.toLowerCase()) {
            return false;
          }
        }

        return true;
      }).toList();

      // Apply offset and limit
      final startIndex = offset;
      final endIndex = (startIndex + limit).clamp(0, filteredAirports.length);

      if (startIndex >= filteredAirports.length) {
        return [];
      }

      return filteredAirports.sublist(startIndex, endIndex);
    } catch (e) {
      print('Error in searchAirports: $e'); // Debug print
      throw Exception('Error searching airports: $e');
    }
  }

  Future<List<Airport>> searchAirportsGeneral(
    String query, {
    int maxResults = 50,
  }) async {
    if (query.isEmpty) return [];

    try {
      // Check if it's a 2-letter country code (like US, UK, CA)
      if (RegExp(r'^[A-Z]{2}$').hasMatch(query.toUpperCase())) {
        final results = await searchAirports(countryCode: query.toUpperCase());
        if (results.isNotEmpty) return results.take(maxResults).toList();
      }

      // Check if it's a 3-letter IATA code
      if (RegExp(r'^[A-Z]{3}$').hasMatch(query.toUpperCase())) {
        final results = await searchAirports(iata: query.toUpperCase());
        if (results.isNotEmpty) return results;
      }

      // Check if it's a 4-letter ICAO code
      if (RegExp(r'^[A-Z]{4}$').hasMatch(query.toUpperCase())) {
        final results = await searchAirports(icao: query.toUpperCase());
        if (results.isNotEmpty) return results;
      }

      final allAirports = await loadAllAirports();

      // Search across multiple fields
      List<Airport> results = allAirports.where((airport) {
        final queryLower = query.toLowerCase();
        return airport.city.toLowerCase().contains(queryLower) ||
            airport.name.toLowerCase().contains(queryLower) ||
            airport.country.toLowerCase().contains(queryLower) ||
            airport.iata.toLowerCase().contains(queryLower) ||
            airport.icao.toLowerCase().contains(queryLower) ||
            matchesCountryCode(airport.country, query);
      }).toList();

      // Sort results by relevance (exact matches first, then starts with, then contains)
      results.sort((a, b) {
        final queryLower = query.toLowerCase();

        // Exact IATA match gets highest priority
        if (a.iata.toLowerCase() == queryLower) return -1;
        if (b.iata.toLowerCase() == queryLower) return 1;

        // Exact city match gets second priority
        if (a.city.toLowerCase() == queryLower) return -1;
        if (b.city.toLowerCase() == queryLower) return 1;

        // Airport name exact match
        if (a.name.toLowerCase() == queryLower) return -1;
        if (b.name.toLowerCase() == queryLower) return 1;

        // City starts with query
        if (a.city.toLowerCase().startsWith(queryLower) &&
            !b.city.toLowerCase().startsWith(queryLower))
          return -1;
        if (b.city.toLowerCase().startsWith(queryLower) &&
            !a.city.toLowerCase().startsWith(queryLower))
          return 1;

        // Airport name starts with query
        if (a.name.toLowerCase().startsWith(queryLower) &&
            !b.name.toLowerCase().startsWith(queryLower))
          return -1;
        if (b.name.toLowerCase().startsWith(queryLower) &&
            !a.name.toLowerCase().startsWith(queryLower))
          return 1;

        // Country starts with query
        if (a.country.toLowerCase().startsWith(queryLower) &&
            !b.country.toLowerCase().startsWith(queryLower))
          return -1;
        if (b.country.toLowerCase().startsWith(queryLower) &&
            !a.country.toLowerCase().startsWith(queryLower))
          return 1;

        // Prioritize results where city contains the query over other fields
        final aCityContains = a.city.toLowerCase().contains(queryLower);
        final bCityContains = b.city.toLowerCase().contains(queryLower);
        if (aCityContains && !bCityContains) return -1;
        if (bCityContains && !aCityContains) return 1;

        return 0;
      });

      return results.take(maxResults).toList();
    } catch (e) {
      throw Exception('Error in general search: $e');
    }
  }

  /// Search airports by city name with enhanced matching
  Future<List<Airport>> searchAirportsByCity(
    String cityName, {
    int maxResults = 50,
    bool exactMatch = false,
  }) async {
    try {
      final allAirports = await loadAllAirports();

      List<Airport> results;

      if (exactMatch) {
        results = allAirports
            .where(
              (airport) => airport.city.toLowerCase() == cityName.toLowerCase(),
            )
            .toList();
      } else {
        results = allAirports
            .where(
              (airport) =>
                  airport.city.toLowerCase().contains(cityName.toLowerCase()),
            )
            .toList();

        // Sort by relevance for partial matches
        results.sort((a, b) {
          final queryLower = cityName.toLowerCase();

          // Exact match first
          if (a.city.toLowerCase() == queryLower) return -1;
          if (b.city.toLowerCase() == queryLower) return 1;

          // Starts with query
          if (a.city.toLowerCase().startsWith(queryLower) &&
              !b.city.toLowerCase().startsWith(queryLower))
            return -1;
          if (b.city.toLowerCase().startsWith(queryLower) &&
              !a.city.toLowerCase().startsWith(queryLower))
            return 1;

          return 0;
        });
      }

      return results.take(maxResults).toList();
    } catch (e) {
      throw Exception('Error searching airports by city: $e');
    }
  }
}
