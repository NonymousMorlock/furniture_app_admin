import 'package:benaiah_admin_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoProductsFound extends StatelessWidget {
  const NoProductsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(MediaRes.emptyStore));
  }
}
