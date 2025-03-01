// ignore_for_file: unused_field

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:islamic_dunia/assets_helper/app_images.dart';

class QiblaCompassScreen extends StatefulWidget {
  @override
  _QiblaCompassScreenState createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  double? _direction;
  double? _qiblaDirection;
  late Position _currentPosition;
  bool _isLoading = true;
  String _latitude = '23.707310';
  String _longitude = '90.415482';

  // Function to get current location (latitude and longitude)
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
      _isLoading = false;
    });

    // Calculate Qibla direction from current location
    _calculateQiblaDirection();
  }

  // Calculate the Qibla direction based on current location
  void _calculateQiblaDirection() {
    // Qibla direction calculation (Formula to calculate Qibla)
    // Ref: https://en.wikipedia.org/wiki/Qibla#Calculation_of_the_Qibla_direction
    double latitude = _currentPosition.latitude;
    double longitude = _currentPosition.longitude;

    // Qibla coordinates (Kaaba in Mecca)
    double qiblaLatitude = 21.4225;
    double qiblaLongitude = 39.8262;

    double deltaLongitude = qiblaLongitude - longitude;
    double radiansLatitude = latitude * (3.14159265359 / 180);
    double radiansQiblaLatitude = qiblaLatitude * (3.14159265359 / 180);
    double radiansDeltaLongitude = deltaLongitude * (3.14159265359 / 180);

    double y = sin(radiansDeltaLongitude) * cos(radiansQiblaLatitude);
    double x = cos(radiansLatitude) * sin(radiansQiblaLatitude) -
        sin(radiansLatitude) *
            cos(radiansQiblaLatitude) *
            cos(radiansDeltaLongitude);

    double qibla = (atan2(y, x) * (180 / 3.14159265359) + 360) % 360;
    setState(() {
      _qiblaDirection = qibla;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    FlutterCompass.events?.listen((event) {
      setState(() {
        _direction = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qibla Compass'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _direction != null
                      ? Transform.rotate(
                          angle: (_direction! - _qiblaDirection!) *
                              (3.14159265359 / 180),
                          child: Image.asset(
                            AppImages.qibla,
                            width: 200,
                            height: 200,
                          ),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Current Direction: ${_direction?.toStringAsFixed(2)}°',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Qibla Direction: ${_qiblaDirection?.toStringAsFixed(2)}°',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
      ),
    );
  }
}
