mixin AirportUtilitiesMixin {
  /// Helper method to match country codes with country names
  bool matchesCountryCode(String countryName, String code) {
    final countryLower = countryName.toLowerCase();
    final codeLower = code.toLowerCase();

    // Common country code mappings
    final countryCodeMap = {
      'us': ['united states', 'usa', 'america'],
      'uk': ['united kingdom', 'great britain', 'britain'],
      'ca': ['canada'],
      'au': ['australia'],
      'de': ['germany', 'deutschland'],
      'fr': ['france'],
      'it': ['italy'],
      'es': ['spain', 'españa'],
      'jp': ['japan'],
      'cn': ['china'],
      'in': ['india'],
      'br': ['brazil'],
      'mx': ['mexico'],
      'ru': ['russia', 'russian federation'],
      'kr': ['south korea', 'korea'],
      'nl': ['netherlands', 'holland'],
      'be': ['belgium'],
      'ch': ['switzerland'],
      'at': ['austria'],
      'se': ['sweden'],
      'no': ['norway'],
      'dk': ['denmark'],
      'fi': ['finland'],
      'pl': ['poland'],
      'cz': ['czech republic', 'czechia'],
      'sk': ['slovakia'],
      'hu': ['hungary'],
      'ro': ['romania'],
      'bg': ['bulgaria'],
      'hr': ['croatia'],
      'si': ['slovenia'],
      'lt': ['lithuania'],
      'lv': ['latvia'],
      'ee': ['estonia'],
      'ie': ['ireland'],
      'pt': ['portugal'],
      'gr': ['greece'],
      'tr': ['turkey'],
      'il': ['israel'],
      'ae': ['united arab emirates', 'uae'],
      'sa': ['saudi arabia'],
      'eg': ['egypt'],
      'za': ['south africa'],
      'ng': ['nigeria'],
      'ke': ['kenya'],
      'ma': ['morocco'],
      'th': ['thailand'],
      'sg': ['singapore'],
      'my': ['malaysia'],
      'id': ['indonesia'],
      'ph': ['philippines'],
      'vn': ['vietnam'],
      'nz': ['new zealand'],
      'ar': ['argentina'],
      'cl': ['chile'],
      'pe': ['peru'],
      'co': ['colombia'],
      've': ['venezuela'],
      'ec': ['ecuador'],
      'uy': ['uruguay'],
      'py': ['paraguay'],
      'bo': ['bolivia'],
    };

    // Check if the code matches any country mappings
    if (countryCodeMap.containsKey(codeLower)) {
      final countryNames = countryCodeMap[codeLower]!;
      return countryNames.any((name) => countryLower.contains(name));
    }

    // Fallback: check if country name starts with the code
    return countryLower.startsWith(codeLower);
  }
}
