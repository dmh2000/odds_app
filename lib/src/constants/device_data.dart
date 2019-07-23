import 'package:flutter/material.dart';

abstract class DeviceData {
  TextStyle get buttonTextStyle;

  TextStyle get homeTextStyle;

  TextStyle get activeTextStyle;

  TextStyle get inactiveTextStyle;

  TextStyle get atTextStyle;

  TextStyle get timeTextStyle;

  TextStyle get gameTextStyle;

  TextStyle get matchupTextStyle;

  TextStyle get statusTextStyle;

  String imageScale(String img);

  double get boxMargin;

  DeviceData();

  factory DeviceData.instance(double width) {
    if (width < 600.0) {
      return SmallDevice();
    } else {
      return LargeDevice();
    }
  }
}

class LargeDevice extends DeviceData {
  @override
  TextStyle get buttonTextStyle => TextStyle(
        fontSize: 30.0,
      );

  @override
  TextStyle get homeTextStyle => TextStyle(
        fontSize: 30.0,
      );

  @override
  TextStyle get activeTextStyle => TextStyle(
        fontSize: 30.0,
      );

  TextStyle get inactiveTextStyle => TextStyle(
        fontSize: 30.0,
        color: Colors.grey,
      );

  @override
  TextStyle get atTextStyle => TextStyle(
        fontSize: 25.0,
      );

  @override
  TextStyle get timeTextStyle => TextStyle(
        fontSize: 20.0,
      );

  @override
  TextStyle get gameTextStyle => TextStyle(
        fontSize: 30.0,
      );

  @override
  TextStyle get matchupTextStyle => TextStyle(
        fontSize: 30.0,
      );

  @override
  TextStyle get statusTextStyle => TextStyle(
        fontSize: 25.0,
      );

  @override
  String imageScale(String img) => 'assets/large/$img';

  @override
  double get boxMargin => 20.0;
}

class SmallDevice extends DeviceData {
  @override
  TextStyle get buttonTextStyle => TextStyle(
        fontSize: 20.0,
      );

  @override
  TextStyle get homeTextStyle => TextStyle(fontSize: 20.0);

  @override
  TextStyle get activeTextStyle => TextStyle(fontSize: 20.0);

  @override
  TextStyle get inactiveTextStyle => TextStyle(
        fontSize: 20.0,
        color: Colors.grey,
      );

  @override
  TextStyle get atTextStyle => TextStyle(
        fontSize: 15.0,
      );

  @override
  TextStyle get timeTextStyle => TextStyle(
        fontSize: 20.0,
      );

  @override
  TextStyle get gameTextStyle => TextStyle(
        fontSize: 20.0,
      );

  @override
  TextStyle get matchupTextStyle => TextStyle(
        fontSize: 20.0,
      );

  @override
  TextStyle get statusTextStyle => TextStyle(
        fontSize: 15.0,
      );

  @override
  String imageScale(String img) {
    return 'assets/small/$img';
  }

  @override
  double get boxMargin => 10.0;
}

void setDeviceType(double width) {
  deviceData = DeviceData.instance(width);
}

// global singleton
DeviceData deviceData;
