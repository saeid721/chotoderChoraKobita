
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widget/global_text.dart';
import '../global/widget/colors.dart';
import '../global/widget/global_sizedbox.dart';

class AppExitDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function() onTap;

  const AppExitDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorRes.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      content: SizedBox(
        width: Get.width,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedBoxH(20),
                GlobalText(
                  str: message,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  color: ColorRes.grey,
                ),
                sizedBoxH(30),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: GlobalButtonWidget(
                        str: 'না',
                        height: 40,
                        radius: 8,
                        textSize: 14,
                        textColor: ColorRes.red,
                        buttomColor: Colors.transparent,
                        borderColor: ColorRes.red,
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    sizedBoxW(15),
                    Expanded(
                      child: GlobalButtonWidget(
                        str: 'হ্যাঁ',
                        height: 40,
                        radius: 8,
                        textSize: 14,
                        buttomColor: ColorRes.primaryColor,
                        onTap: onTap,
                      ),
                    ),
                    sizedBoxW(10),
                  ],
                ),

                sizedBoxW(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


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
      padding: EdgeInsets.symmetric(horizontal: widget.horizontal ?? 0, vertical: widget.vertical ?? 0),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: widget.elevation ?? 0,
          padding: EdgeInsets.zero,
          foregroundColor: widget.foregroundColor,
          shadowColor: Colors.transparent,
          backgroundColor: widget.buttomColor ?? ColorRes.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              side: BorderSide(
                  width: 1,
                  color: widget.borderColor ?? Colors.transparent
              )
          ),
          maximumSize: Size(widget.width ?? size(context).width, widget.height),
          minimumSize: Size(widget.width ?? size(context).width, widget.height),
        ),
        child: Center(
          child: widget.forwardIc == false
              ? GlobalText(
            str: widget.str,
            color: widget.textColor ?? ColorRes.white,
            fontSize: widget.textSize ?? 16,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            height: 0.10,
            fontFamily: 'Rubik',
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalText(
                str: widget.str,
                color: widget.textColor ?? ColorRes.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                height: 0.10,
                fontFamily: 'Rubik',
              ),
              sizedBoxW(15),
              const Icon(Icons.arrow_forward, color: ColorRes.white, size: 18,)
            ],
          ),
        ),
      ),
    );
  }
}
