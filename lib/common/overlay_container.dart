import 'package:flutter/material.dart';

class OverlayContaier extends StatelessWidget {
  final String? text;
  const OverlayContaier({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -15,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.38),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
