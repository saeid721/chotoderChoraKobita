import 'package:flutter/material.dart';

import 'colors.dart';
import 'input_decoration.dart';

class GlobalTextFormField extends StatefulWidget {
  final bool? enabled;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? titleText;
  final String? labelText;
  final String? hintText;
  final TextStyle? titleStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final InputDecoration? decoration;
  final Widget? prefixIcon; // Existing prefixIcon
  final Widget? dynamicPrefixIcon; // New dynamicPrefixIcon property
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? sufixIcon;
  final bool? filled;
  final Color? fillColor;
  final bool? obscureText;
  final String? obscuringCharacter;
  final bool isPasswordField;
  final bool? isRequired;
  final int? maxLine;
  final bool autofocus;
  final bool autocurrent;
  final bool? isDense;
  final Function? onChanged;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? Function(String?)? validator;

  const GlobalTextFormField({
    super.key,
    this.enabled,
    this.readOnly,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.titleText,
    this.labelText,
    this.hintText,
    this.titleStyle,
    this.labelTextStyle,
    this.hintTextStyle,
    this.decoration,
    this.prefixIcon,
    this.dynamicPrefixIcon, // Add this line
    this.prefixIconColor,
    this.suffixIconColor,
    this.contentPadding,
    this.sufixIcon,
    this.fillColor,
    this.filled = false,
    this.obscureText,
    this.obscuringCharacter,
    this.maxLine,
    this.validator,
    this.onChanged,
    this.floatingLabelBehavior,
    this.isPasswordField = false,
    this.isRequired = false,
    this.autofocus = false,
    this.autocurrent = false,
    this.isDense = false,
  });

  @override
  State<GlobalTextFormField> createState() => _GlobalTextFormFieldState();
}

class _GlobalTextFormFieldState extends State<GlobalTextFormField> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.isPasswordField) isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired == false
            ? widget.titleText == null
            ? const SizedBox.shrink()
            : Text(
          widget.titleText ?? "",
          style: widget.titleStyle ?? const TextStyle(
            color: ColorRes.textColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Rubik',
          ),
        )
            : SizedBox(
          child: Row(
            children: [
              widget.titleText == null
                  ? const SizedBox.shrink()
                  : Text(
                widget.titleText ?? "",
                style: widget.titleStyle ?? const TextStyle(
                  color: ColorRes.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                ),
              ),
              const SizedBox(width: 2,),
              const Text(
                "*",
                style: TextStyle(
                  color: ColorRes.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ],
          ),
        ),
        widget.titleText != null ? const SizedBox(height: 5) : const SizedBox.shrink(),
        TextFormField(
          autofocus: widget.autofocus,
          autocorrect: widget.autocurrent,
          enabled: widget.enabled,
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLine ?? 1,
          initialValue: widget.initialValue,
          obscureText: widget.isPasswordField && isVisible,
          obscuringCharacter: widget.obscuringCharacter ?? '*',
          style: const TextStyle(
            color: ColorRes.textColor,
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'Rubik',
          ),
          decoration: widget.decoration?.copyWith(
            contentPadding: widget.contentPadding,
            isDense: widget.isDense,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ?? const TextStyle(
              fontSize: 12,
              color: ColorRes.textColor,
              fontWeight: FontWeight.w400,
              fontFamily: 'Rubik',
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelTextStyle,
            prefixIcon: widget.dynamicPrefixIcon ?? widget.prefixIcon, // Use dynamicPrefixIcon
            filled: widget.filled,
            fillColor: widget.fillColor,
          ) ??
              inputDecoration.copyWith(
                contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                isDense: widget.isDense,
                hintText: widget.hintText,
                hintStyle: widget.hintTextStyle ?? const TextStyle(
                  fontSize: 12,
                  color: ColorRes.textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rubik',
                ),
                labelText: widget.labelText,
                labelStyle: widget.labelTextStyle,
                prefixIcon: widget.dynamicPrefixIcon ?? widget.prefixIcon, // Use dynamicPrefixIcon
                filled: widget.filled,
                fillColor: widget.fillColor,
              ),
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          validator: widget.validator ?? (val) {
            if (val!.isEmpty) {
              return widget.labelText != null ? "${widget.labelText} is required!" : "This field is required!";
            }
            return null;
          },
        ),
      ],
    );
  }
}
