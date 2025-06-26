import 'package:feed/controller/airport/airport_api_controller.dart';
import 'package:feed/models/airport_model.dart';
import 'package:flutter/material.dart';

class SearchableAirportDropdown extends StatefulWidget {
  final String label;
  final Airport? selectedAirport;
  final Function(Airport?) onChanged;
  final bool showPopularAirports;

  const SearchableAirportDropdown({
    super.key,
    required this.label,
    required this.selectedAirport,
    required this.onChanged,
    this.showPopularAirports = true,
  });

  @override
  State<SearchableAirportDropdown> createState() =>
      _SearchableAirportDropdownState();
}

class _SearchableAirportDropdownState extends State<SearchableAirportDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Airport> _airports = [];
  List<Airport> _popularAirports = [];
  bool _isLoading = false;
  bool _showDropdown = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPopularAirports();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _showDropdown = true;
      });
    }
  }

  Future<void> _loadPopularAirports() async {
    if (!widget.showPopularAirports) return;

    try {
      final popular = await AirportController.instance.getPopularAirports();
      setState(() {
        _popularAirports = popular;
        if (_airports.isEmpty) {
          _airports = popular;
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load popular airports';
      });
    }
  }

  Future<void> _searchAirports(String query) async {
    if (query.isEmpty) {
      setState(() {
        _airports = _popularAirports;
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await AirportController.instance.searchAirportsGeneral(
        query,
      );
      setState(() {
        _airports = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Search failed: ${e.toString()}';
        _airports = [];
      });
    }
  }

  void _selectAirport(Airport airport) {
    setState(() {
      _searchController.text = airport.displayName;
      _showDropdown = false;
    });
    _focusNode.unfocus();
    widget.onChanged(airport);
  }

  void _clearSelection() {
    setState(() {
      _searchController.clear();
      _showDropdown = false;
      _airports = _popularAirports;
    });
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.selectedAirport?.displayName ?? widget.label,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: _clearSelection,
                    ),
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            onChanged: (value) {
              setState(() {
                _showDropdown = true;
              });
              _searchAirports(value);
            },
            onTap: () {
              setState(() {
                _showDropdown = true;
              });
              if (_searchController.text.isEmpty) {
                _searchAirports('');
              }
            },
          ),
        ),

        if (_showDropdown) ...[
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _buildDropdownContent(),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdownContent() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 14),
        ),
      );
    }

    if (_airports.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No airports found',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _airports.length,
      itemBuilder: (context, index) {
        final airport = _airports[index];
        final isSelected = widget.selectedAirport?.iata == airport.iata;

        return InkWell(
          onTap: () => _selectAirport(airport),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black87 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        airport.displayName,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (airport.city.isNotEmpty && airport.country.isNotEmpty)
                        Text(
                          '${airport.city}, ${airport.country}',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white70
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check, color: Colors.white, size: 18),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
