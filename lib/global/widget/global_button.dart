import 'package:flutter/material.dart';

import 'colors.dart';
import 'global_sizedbox.dart';
import 'global_text.dart';

class GlobalButtonWidget extends StatefulWidget {
  final double height;
  final double? width;
  final double? radius;
  final double? horizontal;
  final double? vertical;
  final String str;
  final Function() onTap;
  final double? elevation;
  final Color? buttomColor;
  final Color? textColor;
  final double? textSize;
  final Color? borderColor;
  final Color? foregroundColor;
  final bool? forwardIc;

  const GlobalButtonWidget({
    super.key,
    this.height = 57,
    this.width,
    this.horizontal,
    this.vertical,
    required this.str,
    this.radius,
    required this.onTap,
    this.elevation,
    this.buttomColor,
    this.textColor,
    this.textSize,
    this.borderColor,
    this.foregroundColor,
    this.forwardIc = false,
  });

  @override
  State<GlobalButtonWidget> createState() => _GlobalButtonWidgetState();
}

class _GlobalButtonWidgetState extends State<GlobalButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontal ?? 0, vertical: widget.vertical ?? 0),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: widget.elevation ?? 0,
          padding: EdgeInsets.zero,
          foregroundColor: widget.foregroundColor,
          shadowColor: Colors.transparent,
          backgroundColor: widget.buttomColor ?? ColorRes.secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 8),
              side: BorderSide(
                  width: 1, color: widget.borderColor ?? Colors.transparent)),
          maximumSize: Size(widget.width ?? size(context).width, widget.height),
          minimumSize: Size(widget.width ?? size(context).width, widget.height),
        ),
        child: Center(
          child: widget.forwardIc == false
              ? GlobalText(
                  str: widget.str,
                  color: widget.textColor ?? ColorRes.white,
                  fontSize: widget.textSize ?? 14,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  height: 0.10,
                  fontFamily: 'Rubik',
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlobalText(
                      str: widget.str,
                      color: widget.textColor ?? ColorRes.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      height: 0.10,
                      fontFamily: 'Rubik',
                    ),
                    const SizedBox(height: 15),
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorRes.white,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
