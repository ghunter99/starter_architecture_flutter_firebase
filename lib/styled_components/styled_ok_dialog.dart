import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pedantic/pedantic.dart';

import '../constants/app_constants.dart';

class StyledOkDialog extends StatelessWidget {
  const StyledOkDialog({
    Key key,
    @required this.title,
    this.content,
  })  : assert(title != null),
        super(key: key);
  final String title;
  final String content;

  static Future<void> show(
    BuildContext context, {
    @required String title,
    String content,
  }) async {
    unawaited(showPlatformDialog<void>(
      context: context,
      builder: (_) => StyledOkDialog(
        title: title,
        content: content,
      ),
    ));
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
          onPressed: () => Navigator.pop(context),
          child: PlatformText(AppConstants.ok),
        ),
      ],
    );
  }
}
