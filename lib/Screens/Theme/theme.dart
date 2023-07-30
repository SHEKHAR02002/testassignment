import 'package:flutter/material.dart';

BoxDecoration shadowdecoration = BoxDecoration(
  color: Colors.white,
  // border: Border.all(width: 1, color: Colors.grey),
  borderRadius: BorderRadius.circular(5),
  boxShadow: const [
    BoxShadow(
        color: Color(
          0x3f000000,
        ), //New
        blurRadius: 1.0,
        offset: Offset(0, 0))
  ],
);
