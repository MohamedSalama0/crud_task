import 'package:crud_task/utils/colors/app_color.dart';
import 'package:crud_task/utils/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextFormFieldWithTitle extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onSaved;
  final TextInputType? type;
  final String fieldTitle;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final String? initialValue;
  final String hintText;
  final Color? backgroundColor;
  final double height;
  final double? boorderRadius;
  final bool isPasswordVisible;
  final FormFieldValidator<String>? validate;

  final Widget? suffix;
  final Widget? prefixIcon;
  final VoidCallback? suffixPressed;
  final bool isClickable;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final int lines;
  final int? maxLength;
  final double? fontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? enabledBorderColor;
  final FocusNode? focusNode;
  const DefaultTextFormFieldWithTitle({
    super.key,
    required this.controller,
    this.type,
    this.validate,
    this.onSaved,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLength,
    this.enabledBorderColor,
    this.textAlign,
    this.focusNode,
    this.boorderRadius,
    this.textColor,
    this.backgroundColor,
    this.hintText = '',
    this.initialValue,
    this.prefixIcon,
    this.height = 1,
    this.isClickable = true,
    this.isPasswordVisible = false,
    this.lines = 1,
    this.onChange,
    this.hintTextColor,
    this.onTap,
    this.fontSize,
    this.suffix,
    this.suffixPressed,
    required this.fieldTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: sizedW(context) * 0.02, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: const TextStyle(color: kBlack),
          ),
          SizedBox(height: 5.h),
          SizedBox(
            height: 30.h,
            child: TextFormField(
              focusNode: focusNode,
              
              textAlignVertical: TextAlignVertical.bottom,
              initialValue: initialValue,
              controller: controller,
              onFieldSubmitted: (value) {
                if (onSaved != null) {
                  onSaved!(value);
                }
              },
              inputFormatters: inputFormatters,
              keyboardType: type,

              readOnly: readOnly,
              
              enabled: isClickable,
              maxLength: maxLength,
              onChanged: onChange,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: onTap,
              maxLines: lines,
              validator: validate ??
                  (v) {
                    return null;
                  },
              style: TextStyle(
                  color: textColor ?? kDarkBlue,
                  fontSize: fontSize ?? 15,
                  height: height),
              
              decoration: InputDecoration(
                alignLabelWithHint: true,
                counterText: '',
                prefixIcon: prefixIcon,
                hintText: hintText,
              
                hintStyle: const TextStyle(
                  color: kGrey,
                  fontSize: 15,
                ),
                // filled: true,
                fillColor: backgroundColor ?? kTextFieldBackColor,
                focusedErrorBorder: const OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? kGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
                errorStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 119, 119),
                  fontWeight: FontWeight.w700,
                ),
                errorBorder: const OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
