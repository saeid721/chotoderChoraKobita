import 'package:flutter/material.dart';

sizedBoxH(double? h){
  return SizedBox(height: h);
}

sizedBoxW(double? w){
  return SizedBox(width: w);
}

size(BuildContext context){
  return MediaQuery.sizeOf(context);
}
