import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class StyledBackButton extends StatelessWidget {
  const StyledBackButton({
    this.icon,
    @required this.onPressed,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon ?? Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return PlatformButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      cupertino: (_, __) => CupertinoButtonData(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 4),
      ),
      child: Icon(
        icon ?? Icons.arrow_back_ios,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
