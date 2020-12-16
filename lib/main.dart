//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth_widget.dart';
import 'app/home/home_page.dart';
import 'app/onboarding/onboard_welcome_page.dart';
import 'app/onboarding/onboarding_page.dart';
import 'app/onboarding/onboarding_view_model.dart';
import 'app/top_level_providers.dart';
import 'app_options/app_options.dart';
import 'constants/app_constants.dart';
import 'routing/app_router.dart';
import 'services/shared_preferences_service.dart';
import 'themes/app_theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await initializeDateFormatting('en_AU', null);
  // Intl.defaultLocale = 'en_AU';
  GoogleFonts.config.allowRuntimeFetching = true;
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
    this.themeMode = ThemeMode.dark,
  }) : super(key: key);
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    return ModelBinding(
      initialModel: AppOptions(
        themeMode: themeMode,
        textScaleFactor: AppConstants.systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: null,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: false,
        userRole: UserRole.parent,
      ),
      child: Builder(builder: (context) {
        return MaterialApp(
          themeMode: AppOptions.of(context).themeMode,
          theme: AppThemeData.lightThemeData.copyWith(
            platform: AppOptions.of(context).platform,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: AuthWidget(
            nonSignedInBuilder: (_) => Consumer(
              builder: (context, watch, _) {
                final didCompleteOnboarding =
                    watch(onboardingViewModelProvider.state);
//                return didCompleteOnboarding ? SignInPage() : OnboardingPage();
                return didCompleteOnboarding
                    ? OnboardWelcomePage()
                    : OnboardingPage();
              },
            ),
            signedInBuilder: (_) => HomePage(),
          ),
          onGenerateRoute: (settings) =>
              AppRouter.onGenerateRoute(settings, firebaseAuth),
        );
      }),
    );
  }
}
