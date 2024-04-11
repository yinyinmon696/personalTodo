import 'package:flutter/material.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly,
    this.onChanged,
    this.onTap,
    this.fillColor,
    super.key,
  });
  final TextEditingController? controller;
  final String? hintText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final bool? readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TextFormField(
        minLines: 1,
        maxLines: 20,
        readOnly: readOnly ?? false,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: fillColor ?? ColorsLight.grey,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          hintText: hintText ?? '',
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsLight.borderStoke,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(Sizes.p6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsLight.borderStoke,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(Sizes.p6),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsLight.red, width: 0.5),
            borderRadius: BorderRadius.circular(Sizes.p6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorsLight.red, width: 0.5),
            borderRadius: BorderRadius.circular(Sizes.p6),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }
}
