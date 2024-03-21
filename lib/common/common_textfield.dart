import 'package:flutter/material.dart';

import '../const/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const CommonTextField({
    required this.controller,
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 19),
      ),
      const SizedBox(
        height: 10,
      ),
      TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.primaryColor,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      )
    ]);
  }
}
