import 'package:flutter/material.dart';

class CapturaInfo extends StatelessWidget {
  const CapturaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1e4e62), Color(0xFF2b958f)],
              begin: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
