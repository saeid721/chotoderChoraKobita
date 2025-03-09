import 'package:flutter/material.dart';

import 'colors.dart';

InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: ColorRes.secondaryColor.withOpacity(0.2),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
);

InputDecoration inputDropDecoration = InputDecoration(
  filled: true,
  fillColor: ColorRes.white,
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 1, color: ColorRes.borderColor)),
);

InputDecoration nonInputField = const InputDecoration(
  border: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

InputDecoration searchDecoration = InputDecoration(
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
);

InputDecoration borderDecoration = InputDecoration(
  isDense: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: ColorRes.borderColor, width: 1)),
);

InputDecoration dateInputDecoration = InputDecoration(
  fillColor: ColorRes.white,
  filled: true,
  isDense: true,
  iconColor: ColorRes.secondaryColor,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  // labelStyle: const TextStyle(
  //   color: ColorRes.black,
  // ),
  // floatingLabelStyle: const TextStyle(color: ColorRes.blue),
  border: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.secondaryColor,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.red,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.red,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.secondaryColor,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.secondaryColor,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: ColorRes.secondaryColor,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  suffixIconColor: ColorRes.secondaryColor,
);
