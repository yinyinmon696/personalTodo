import 'package:flutter/material.dart';
import 'package:personaltodoapp/theme/colors.dart';
import 'package:personaltodoapp/utils/constants.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width,
    this.height,
    super.key,
  });
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorsLight.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.p4),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator(color: ColorsLight.white)
            else
              Text(
                text,
                style: const TextStyle(color: ColorsLight.white, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
