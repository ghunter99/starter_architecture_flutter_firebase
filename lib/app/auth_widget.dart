import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/empty_content.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key key,
    @required this.signedInWithProfileBuilder,
    @required this.signedInWithoutProfileBuilder,
    @required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder signedInWithProfileBuilder;
  final WidgetBuilder signedInWithoutProfileBuilder;
  final WidgetBuilder nonSignedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) {
        if (user == null) {
          return nonSignedInBuilder(context);
        }
        final userStream = watch(userProfileStreamProvider);
        return userStream.when(
          data: (userProfile) {
            if (userProfile != null) {
              if (userProfile.isComplete) {
                return signedInWithProfileBuilder(context);
              }
            }
            return signedInWithoutProfileBuilder(context);
          },
          loading: () => PlatformScaffold(
            body: Center(
              child: PlatformCircularProgressIndicator(),
            ),
          ),
          error: (_, __) => PlatformScaffold(
            body: EmptyContent(
              title: 'Something went wrong',
              message: 'Can\'t load data right now.',
            ),
          ),
        );
      },
      loading: () => PlatformScaffold(
        body: Center(
          child: PlatformCircularProgressIndicator(),
        ),
      ),
      error: (_, __) => PlatformScaffold(
        body: EmptyContent(
          title: 'Something went wrong',
          message: 'Can\'t load data right now.',
        ),
      ),
    );
  }
}
