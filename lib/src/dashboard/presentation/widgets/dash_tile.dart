import 'package:badges/badges.dart';
import 'package:benaiah_admin_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';

class DashTile extends StatelessWidget {
  const DashTile({
    required this.tileMedia,
    required this.tileTitle,
    required this.tileDescription,
    required this.backgroundImage,
    this.onTap,
    super.key,
  });

  final String tileMedia;
  final String tileTitle;
  final String tileDescription;
  final String backgroundImage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        badgeContent: Lottie.asset(
          tileMedia,
          height: context.width * .05,
          width: context.width * .05,
        ),
        position:
            BadgePosition.topStart(top: -((context.width * .05) / 2), start: 0),
        badgeStyle: const BadgeStyle(badgeColor: Colors.transparent),
        child: Container(
          height: 500,
          width: 500,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.05),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tileTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tileDescription,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
