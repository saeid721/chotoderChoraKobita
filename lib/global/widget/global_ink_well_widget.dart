import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class GlobalInkWellWidget extends StatelessWidget {
  const GlobalInkWellWidget({
    super.key,
    required this.onTap,
    required this.title, required Row child,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        width: Get.width,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorRes.primaryColor,
          ),
        ),
      ),
    );
  }
}
