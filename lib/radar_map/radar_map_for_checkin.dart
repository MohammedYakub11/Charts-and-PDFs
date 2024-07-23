import 'dart:math';
import 'package:flutter_radar/flutter_radar.dart';

class RadarService {
  static const String publishableKey = 'prj_test_pk_e67e4a44a44c5636b136203b02c6bf156c7860fb';


  static void initialize() {
    Radar.initialize(publishableKey);
    print(publishableKey);
  }



}
