import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../page/page0.dart';

String token = '';
Widget CuPage = const Page0();
int CuPageLV = 0;
int UserLV = 0;

class PageLevel {
  static int page01 = 1;
  static int page02 = 1;
  static int page03 = 4;
  static int page04 = 1;
  static int page05 = 1;
  static int page06 = 1;
  static int page07 = 1;
  static int page08 = 1;
  static int page09 = 1;
  static int page10 = 1;
}

class dataset {
  dataset({
    this.id = 0,
    this.f01 = '',
    this.f02 = '',
    this.f03 = '',
    this.f04 = '',
    this.f05 = '',
    this.f06 = '',
    this.f07 = '',
    this.f08 = '',
    this.f09 = '',
    this.f10 = '',
    this.f11 = '',
    this.f12 = '',
    this.f13 = '',
    this.f14 = '',
    this.f15 = '',
    this.f16 = '',
    this.f17 = '',
    this.f18 = '',
    this.f19 = '',
    this.f20 = '',
    this.f21 = '',
    this.f22 = '',
    this.f23 = '',
    this.f24 = '',
    this.f25 = '',
    this.f26 = '',
    this.f27 = '',
    this.f28 = '',
    this.f29 = '',
    this.f30 = '',
  });
  int id;
  String f01;
  String f02;
  String f03;
  String f04;
  String f05;
  String f06;
  String f07;
  String f08;
  String f09;
  String f10;
  String f11;
  String f12;
  String f13;
  String f14;
  String f15;
  String f16;
  String f17;
  String f18;
  String f19;
  String f20;
  String f21;
  String f22;
  String f23;
  String f24;
  String f25;
  String f26;
  String f27;
  String f28;
  String f29;
  String f30;

  bool selected = false;
}

List<dataset> ZeroDataset = [];

class mapdataset {
  mapdataset({
    required this.set01,
    required this.set02,
    required this.set03,
    required this.set04,
    required this.set05,
  });
  final List<dataset> set01;
  final List<dataset> set02;
  final List<dataset> set03;
  final List<dataset> set04;
  final List<dataset> set05;

  bool selected = false;
}

mapdataset zeromapdataset =
    mapdataset(set01: [], set02: [], set03: [], set04: [], set05: []);
