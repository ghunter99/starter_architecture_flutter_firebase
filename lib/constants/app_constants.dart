class AppConstants {
  // height of the app header
  static const double appHeaderHeight = 64;

  // The font size delta for headline4 font.
  static const double desktopDisplay1FontDelta = 16;

  // The width of the settingsDesktop.
  static const double desktopSettingsWidth = 520;

  // Sentinel value for the system text scale factor option.
  static const double systemTextScaleFactorOption = -1;

  // The splash page animation duration.
  static const splashPageAnimationDurationInMilliseconds = 300;

  // The desktop top padding for a page's first header (e.g. Gallery, Settings)
  static const firstHeaderDesktopTopPadding = 5.0;

  // firebase project URL
  static const String firebaseProjectURL =
//      'https://go-swim-club.firebaseio.com';
      'https://go-swim-club.firebaseapp.com/';

  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String discard = 'Discard';
  static const String save = 'Save';
  static const String areYouSure = 'Are you sure?';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Sign In Page
  static const String signIn = 'Sign in';
  static const String signInWithEmailPassword =
      'Sign in with email and password';
  static const String signInWithEmailLink = 'Sign in with email link';
  static const String goAnonymous = 'Go anonymous';
  static const String or = 'or';

  // Email & Password page
  static const String signInFailed = 'Sign in failed';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password8CharactersLabel = 'Password (8+ characters)';
  static const String passwordLabel = 'Password';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidEmailEmpty = 'Email can\'t be empty';
  static const String invalidPasswordTooShort = 'Password is too short';
  static const String invalidPasswordEmpty = 'Password can\'t be empty';

  // Email link page
  static const String submitEmailAddressLink =
      'Submit your email address to receive an activation link.';
  static const String checkYourEmail = 'Check your email';
  static String activationLinkSent(String email) =>
      'We have sent an activation link to $email';
  static const String errorSendingEmail = 'Error sending email';
  static const String sendActivationLink = 'Send activation link';
  static const String activationLinkError = 'Email activation error';
  static const String submitEmailAgain =
      'Please enter your email address again to receive a new activation link.';
  static const String userAlreadySignedIn =
      'Received an activation link but you are already signed in.';
  static const String isNotSignInWithEmailLinkMessage =
      'Invalid activation link';

  // Save edit changes on cancel
  static const String cancelAreYouSure = 'Your changes have not been saved';

  // Delete swimmer
  static const String deleteSwimmerAreYouSure = 'Delete swimmer?';
  static const String delete = 'Delete';

  // Home page
  static const String homePage = 'Home Page';

  // Jobs page
  static const String jobs = 'Jobs';

  // Entries page
  static const String entries = 'Entries';

  // Account page
  static const String account = 'Account';
  static const String accountPage = 'Account Page';

  static const firstSwimLane = 1;
  static const lastSwimLane = 10;
}

extension CapitalizeExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeFirstOfEach =>
      split(' ').map((str) => str.capitalize).join(' ');
}

/// User role
enum UserRole {
  /// Parent/guardian enables user to:
  /// - create swimmer accounts
  /// - edit only those swimmer account created by parent
  parent,

  /// Race starter role enables user to:
  /// - start races
  /// - edit meets and meet events
  /// - create swimmer accounts
  /// - edit all swimmer accounts
  raceStarter,

  /// Race administrator role enables user to:
  /// - create meets
  /// - edit meets and meet events
  /// - create swimmer accounts
  /// - edit all swimmer accounts
  administrator,
}

extension AppUserRoleExtension on String {
  // returns null if key is not found
  UserRole toUserRole() => {
        'parent': UserRole.parent,
        'raceStarter': UserRole.raceStarter,
        'raceAdministrator': UserRole.administrator,
      }[this];
}

/// Meets, events in meets, & heats in events all have a completion status
enum CompletionStatus {
  notStarted,
  inProgress,
  inProgressFinished,
  completed,
}

extension CompletionStatusExtension on String {
  // return null if key is not found
  CompletionStatus toCompletionStatus() => {
        'notStarted': CompletionStatus.notStarted,
        'inProgress': CompletionStatus.inProgress,
        'inProgressFinished': CompletionStatus.inProgressFinished,
        'completed': CompletionStatus.completed,
      }[this];
}
