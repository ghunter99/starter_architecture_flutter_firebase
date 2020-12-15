import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboard_log_in_page.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboard_sign_up_page.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboarding_view_model.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_button.dart';

class OnboardWelcomePage extends StatelessWidget {
  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    await onboardingViewModel.completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // For Android use:
        // [light] for dark status bar text, [dark] for white status bar text
        statusBarIconBrightness:
            Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        // For iOS:
        // [light] for light status bar text, [dark] for dark status bar text
        statusBarBrightness: Theme.of(context).colorScheme.brightness,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          SafeArea(
            child: PlatformScaffold(
              body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(),
                    Text(
                      'Swim  Club',
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StyledButton(
                          color: Theme.of(context).colorScheme.primary,
                          textColor: Colors.white,
                          borderColor: Theme.of(context).colorScheme.primary,
                          onPressed: () async {
                            await Navigator.push<bool>(
                              context,
                              platformPageRoute(
                                context: context,
                                builder: (_) => OnboardSignupPage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 8),
                                width: 50,
                                child: Icon(Icons.email_outlined,
                                    color: Colors.white, size: 20),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Sign Up with Email',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(width: 50),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        _LoginButton(
                          onPressed: () async {
                            await Navigator.push<bool>(
                              context,
                              platformPageRoute(
                                context: context,
                                builder: (_) => OnboardLogInPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  _LoginButton({@required this.onPressed});
  final VoidCallback onPressed;

  Widget _logInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already a member?',
            style: Theme.of(context).textTheme.overline.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          SizedBox(width: 8),
          Text(
            'Log in',
            style: Theme.of(context).textTheme.overline.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCupertino(context)) {
      return PlatformButton(
        onPressed: onPressed,
        child: _logInText(context),
      );
    }
    return InkWell(
      onTap: onPressed,
      child: _logInText(context),
    );
  }
}
