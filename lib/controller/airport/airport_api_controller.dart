import 'package:feed/controller/airport/mixins/airport_data_loader_mixin.dart';
import 'package:feed/controller/airport/mixins/airport_filter_mixin.dart';
import 'package:feed/controller/airport/mixins/airport_search_mixin.dart';
import 'package:feed/controller/airport/mixins/airport_utility_mixin.dart';
import 'package:feed/models/airport_model.dart';

class AirportController
    with
        AirportDataLoaderMixin,
        AirportUtilitiesMixin,
        AirportSearchMixin,
        AirportFiltersMixin {
  // Singleton instance
    static AirportController? _instance;
  
  AirportController._();
  
  static AirportController get instance {
    _instance ??= AirportController._();
    return _instance!;
  }}