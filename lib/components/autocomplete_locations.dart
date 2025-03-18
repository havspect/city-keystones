import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationData {
  final String displayName;
  final double latitude;
  final double longitude;

  LocationData({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });
}

class AutocompleteLocations extends StatefulWidget {
  final void Function(LocationData) onLocationSelected;
  final String? initialValue;
  final String hintText;

  const AutocompleteLocations({
    super.key,
    required this.onLocationSelected,
    this.initialValue,
    this.hintText = 'Search for a location',
  });

  @override
  State<AutocompleteLocations> createState() => _AutocompleteLocationsState();
}

class _AutocompleteLocationsState extends State<AutocompleteLocations> {
  final TextEditingController _controller = TextEditingController();
  List<LocationData> _searchResults = [];
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Using Nominatim OpenStreetMap API to search for locations
  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5',
        ),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'CityKeystones/1.0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        
        setState(() {
          _searchResults = data
              .where((item) => 
                  item['lat'] != null && 
                  item['lon'] != null && 
                  item['display_name'] != null)
              .map((item) => LocationData(
                    displayName: item['display_name'],
                    latitude: double.parse(item['lat']),
                    longitude: double.parse(item['lon']),
                  ))
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _searchResults = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      debugPrint('Error searching for location: $e');
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      _searchLocation(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              _searchResults = [];
                            });
                          },
                        )
                      : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: _onSearchChanged,
          ),
        ),
        if (_searchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  title: Text(
                    result.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    'Lat: ${result.latitude.toStringAsFixed(4)}, Long: ${result.longitude.toStringAsFixed(4)}',
                  ),
                  onTap: () {
                    _controller.text = result.displayName;
                    widget.onLocationSelected(result);
                    setState(() {
                      _searchResults = [];
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
