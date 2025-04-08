import 'package:flutter/material.dart';
import 'package:taskmanager/core/resources/app_colors.dart';
import 'package:taskmanager/core/resources/text_theme.dart';
import 'package:taskmanager/core/utils/utils.dart';

void showTopSnackBar(
  OverlayState overlay,
  BuildContext context,
  String message,
  Color backgroundColor,
  IconData iconData,
) {
  late OverlayEntry overlayEntry;

  // AnimationController for fade animation
  final AnimationController controller = AnimationController(
    vsync: Navigator.of(context),
    duration: const Duration(
      milliseconds: 300,
    ), // Animation duration for fade in/out
  );

  // Create an opacity animation (fade in/out)
  final Animation<double> opacityAnimation = Tween<double>(
    begin: 0.0, // Start with fully transparent
    end: 1.0, // End with fully visible
  ).animate(controller);

  overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top:
              Utils().height *
              0.05, // Adjust this to position snackbar further from top
          left: 16,
          right: 16,
          child: CustomSnackBar(
            opacityAnimation: opacityAnimation,
            message: message,
            backgroundColor: backgroundColor,
            icon: iconData,
          ),
        ),
  );

  // Insert the entry into the overlay
  overlay?.insert(overlayEntry);

  // Start the fade-in animation
  controller.forward();

  // Remove the entry after a few seconds with fade-out animation
  Future.delayed(const Duration(seconds: 3), () {
    controller.reverse(); // Start fade-out animation
    Future.delayed(const Duration(milliseconds: 300), () {
      overlayEntry
          .remove(); // Remove the overlay after the fade-out animation completes
    });
  });
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.opacityAnimation,
    required this.backgroundColor,
    required this.message,
    required this.icon,
  });

  final Animation<double> opacityAnimation;
  final Color backgroundColor;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Make background transparent
      child: FadeTransition(
        // Add fade transition
        opacity: opacityAnimation,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTextTheme.subTitleText.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.none,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
