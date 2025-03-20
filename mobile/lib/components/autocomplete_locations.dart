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
  bool _isLoading = false;
  List<LocationData> _options = [];
  Timer? _debounce;
  String _lastQuery = '';

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
    if (query.isEmpty || query == _lastQuery) {
      return;
    }

    _lastQuery = query;
    
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        _isLoading = true;
        _options = [];
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
          
          print(data); // Debug print
          
          final results = data
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
              
          // Only update if this is still the most recent query
          if (query == _lastQuery) {
            setState(() {
              _options = results;
              _isLoading = false;
            });
          }
        }
      } catch (e) {
        debugPrint('Error searching for location: $e');
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RawAutocomplete<LocationData>(
            initialValue: TextEditingValue(text: widget.initialValue ?? ''),
            optionsBuilder: (TextEditingValue textEditingValue) {
              _searchLocation(textEditingValue.text);
              return _options;
            },
            displayStringForOption: (LocationData option) => option.displayName,
            fieldViewBuilder: (
              BuildContext context,
              TextEditingController controller,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted,
            ) {
              // Store the controller reference to update it later if needed
              _controller.text = controller.text;
              
              return TextField(
                controller: controller,
                focusNode: focusNode,
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
                      : controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                                setState(() {
                                  _options = [];
                                });
                              },
                            )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  // This ensures the dropdown shows when typing
                  if (value.isNotEmpty) {
                    focusNode.requestFocus();
                  }
                },
              );
            },
            optionsViewBuilder: (
              BuildContext context, 
              AutocompleteOnSelected<LocationData> onSelected, 
              Iterable<LocationData> options,
            ) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    width: MediaQuery.of(context).size.width - 16, // Padding adjustment
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: options.isEmpty && _isLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : options.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text('No locations found'),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  final LocationData result = options.elementAt(index);
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
                                      onSelected(result);
                                    },
                                  );
                                },
                              ),
                  ),
                ),
              );
            },
            onSelected: (LocationData selection) {
              widget.onLocationSelected(selection);
            },
          ),
        ),
      ],
    );
  }
}
