import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    Key key,
    this.title,
    this.child,
    this.color,
    this.textColor,
    this.borderColor,
    this.fontSize = 17.0,
    this.isTrailingAction = false,
    this.isStretched = true,
    @required this.onPressed,
  })  : assert(
            (title != null || child != null) &&
                !(title != null && child != null),
            'Title or child must have a value (but not both)'),
//        assert(onPressed != null, 'onPressed can not be null'),
        super(key: key);
  final String title;
  final Widget child;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final bool isTrailingAction;
  final bool isStretched;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Widget button = PlatformButton(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: color ?? Colors.transparent,
      onPressed: onPressed,
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: StadiumBorder(
            side: BorderSide(
          color:
              borderColor ?? textColor ?? Theme.of(context).colorScheme.primary,
          width: 1.5,
        )),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isTrailingAction || !isStretched
            ? CrossAxisAlignment.start
            : (CrossAxisAlignment.stretch),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 2),
            child: title != null
                ? Text(
                    title,
                    textAlign: TextAlign.center,
                    style: isTrailingAction
                        ? Theme.of(context).textTheme.button.copyWith(
                              color: textColor ??
                                  Theme.of(context).colorScheme.primary,
                              fontSize: fontSize,
                            )
                        : Theme.of(context).textTheme.subtitle1.copyWith(
                              color: textColor ??
                                  Theme.of(context).colorScheme.primary,
                              fontSize: fontSize,
                            ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : child,
          ),
        ],
      ),
    );
    final wrapWithStadiumBorder = isCupertino(context);
    if (wrapWithStadiumBorder) {
      button = Container(
        decoration: BoxDecoration(
          border: color == null || color == Colors.transparent
              ? Border.all(
                  color: borderColor ??
                      textColor ??
                      Theme.of(context).colorScheme.primary,
                  style: BorderStyle.solid,
                  width: 1.5,
                )
              : null,
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: button,
      );
    }
    return Padding(
      padding: isTrailingAction
          ? (isMaterial(context)
              ? const EdgeInsets.all(8)
              : const EdgeInsets.only(top: 6, right: 8))
          : EdgeInsets.zero,
      child: button,
    );
  }
}
