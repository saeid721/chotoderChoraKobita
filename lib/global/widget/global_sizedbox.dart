import 'package:flutter/material.dart';

sizeBoxH(double? h){
  return SizedBox(height: h);
}

sizeBoxW(double? w){
  return SizedBox(width: w);
}

size(BuildContext context){
  return MediaQuery.sizeOf(context);
}
