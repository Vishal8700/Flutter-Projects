import 'dart:convert';
import 'dart:io'; // Import this for File class
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_place_app/models/place.dart'; // Import your models

class LocationInput extends StatefulWidget {
  const LocationInput(
      {super.key, required Null Function(dynamic location) onSelectLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Place? _selectedPlace; // Change to use Place class
  bool _isLoading = false; // Track loading state

  final Location location = Location();
  final String apiKey = '66a379374df46443849231agtf945f4'; // Your API key

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Set loading to true
    setState(() {
      _isLoading = true;
    });

    // Check if location services are enabled
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _isLoading = false; // Set loading to false if service is not enabled
        });
        return;
      }
    }

    // Check for location permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          _isLoading =
              false; // Set loading to false if permission is not granted
        });
        return;
      }
    }

    // Get the current location
    final LocationData _locationResult = await location.getLocation();

    // Get the address from the coordinates
    final address = await _getAddressFromLatLng(
        _locationResult.latitude, _locationResult.longitude);

    setState(() {
      _selectedPlace = Place(
        title: 'Current Location',
        image: File(''), // Placeholder for image file
        location: PlaceLocation(
          address: address,
          latitude: _locationResult.latitude!,
          longitude: _locationResult.longitude!,
        ),
      );
      _isLoading = false; // Set loading to false after fetching is complete
    });
  }

  Future<String> _getAddressFromLatLng(double? lat, double? lng) async {
    if (lat == null || lng == null) return 'Address not found';

    final url = Uri.parse(
        'https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? 'Address not found';
      } else {
        print('Failed to load address: ${response.statusCode}');
        return 'Address not found';
      }
    } catch (e) {
      print('Error fetching address: $e');
      return 'Address not found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: const Color.fromARGB(61, 0, 0, 0)),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: _isLoading
              ? const CircularProgressIndicator() // Show progress indicator while loading
              : Text(
                  _selectedPlace?.location.address ?? 'Enter a location',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.my_location),
              label: const Text('Device Location'),
              style: TextButton.styleFrom(
                iconColor: const Color.fromARGB(255, 255, 0, 0),
              ),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select Location from Map'),
              style: TextButton.styleFrom(
                iconColor: const Color.fromARGB(255, 47, 255, 0),
              ),
              onPressed: () {
                // Add your map location functionality here
              },
            ),
          ],
        ),
      ],
    );
  }
}
