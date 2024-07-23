import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_radar/flutter_radar.dart';

import 'dart:math' as Math;

import '../Pages/leave_request.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
    Radar.initialize('prj_test_pk_e67e4a44a44c5636b136203b02c6bf156c7860fb');
  }

  Future<void> requestPermissions() async {
    try {
      String? status = await Radar.getPermissionsStatus();
      if (status == 'DENIED' || status == 'NOT_DETERMINED') {
        await Radar.requestPermissions(true);
      }
      print('Permissions status: $status');
    } catch (e) {
      print('Error requesting permissions: $e');
    }
  }

  void setUser(String userId) {
    Radar.setUserId(userId);
  }

  Future<void> login() async {
    try {
      var response = await Radar.trackOnce();
      debugPrint('response = ${response}');
      var location = response?['location'];
      var user = response?['user'];
      var geofences = user != null ? user['geofences'] : null;
      var status = response?['status'];
      var confidence = response?['location']['confidence'];
      var accuracy = response?['location']['accuracy'];

      debugPrint('Location: $location');
      debugPrint('User: $user');
      debugPrint('Geofences: $geofences');
      debugPrint('Confidence: $confidence');
      debugPrint('Accuracy: $accuracy');

      if (geofences != null && geofences.isNotEmpty) {
        for (var geofence in geofences) {
          debugPrint('Geofence ID: ${geofence['externalId']}');
          debugPrint('$status');
          if (geofence['externalId'] == 'office-geofence' || geofence['externalId']== 'office-bay') {
            // Corrected geofence check to use externalId
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LeaveRequestPage()),
            );
            print('Check-in successful, User = $user');
            return;
          }
        }
      }
      print('You are too far from the office to check in, status = $user');
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000; // distance in meters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: login,
          child: Text('Check In '),
        ),
      ),
    );
  }
}
