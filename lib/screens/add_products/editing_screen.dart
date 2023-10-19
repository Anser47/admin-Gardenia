import 'package:flutter/material.dart';

class ScreenEditing extends StatelessWidget {
  const ScreenEditing({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('kop'),
        ],
      ),
    );
  }
}
