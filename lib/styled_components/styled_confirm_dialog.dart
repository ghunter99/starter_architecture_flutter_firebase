import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constants/app_constants.dart';

class StyledConfirmDialog extends StatelessWidget {
  const StyledConfirmDialog({
    Key key,
    @required this.title,
    this.content,
    String okCaption,
    String cancelCaption,
  })  : assert(title != null),
        okCaption = okCaption ?? AppConstants.ok,
        cancelCaption = cancelCaption ?? AppConstants.cancel,
        super(key: key);
  final String title;
  final String content;
  final String okCaption;
  final String cancelCaption;

  static Future<bool> show(
    BuildContext context, {
    @required String title,
    String content,
    String okCaption,
    String cancelCaption,
  }) async {
    return await showPlatformDialog<bool>(
          context: context,
          builder: (_) => StyledConfirmDialog(
            title: title,
            content: content,
            okCaption: okCaption,
            cancelCaption: cancelCaption,
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      title: Text(title),
      content: content == null ? null : Text(content),
      actions: <Widget>[
        PlatformDialogAction(
          material: (_, __) => MaterialDialogActionData(),
          cupertino: (_, __) => CupertinoDialogActionData(
              textStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  )),
          onPressed: () => Navigator.pop(context, false),
          child: PlatformText(cancelCaption),
        ),
        PlatformDialogAction(
          material: (_, __) => MaterialDialogActionData(),
          cupertino: (_, __) => CupertinoDialogActionData(
              textStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  )),
          onPressed: () => Navigator.pop(context, true),
          child: PlatformText(okCaption),
        ),
      ],
    );
  }
}
