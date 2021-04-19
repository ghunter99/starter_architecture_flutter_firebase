import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_back_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_confirm_dialog.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_ok_dialog.dart';
import 'package:starter_architecture_flutter_firebase/util.dart';
import 'package:string_validators/string_validators.dart';

import '../top_level_providers.dart';

class OnboardLogInPage extends StatefulWidget {
  @override
  _OnboardLogInPageState createState() => _OnboardLogInPageState();
}

class _OnboardLogInPageState extends State<OnboardLogInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isLoading;
  String _email;
  String _password;
  bool _hasPressedForgotPassword;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _email = '';
    _password = '';
    _hasPressedForgotPassword = false;
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onPressedBackButton(BuildContext context) {
    // hide keyboard if necessary
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
  }

  void _onFormSubmit() async {
    if (_isLoading || _hasPressedForgotPassword) {
      return;
    }
    // hide keyboard if necessary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    UserCredential userCredential;
    setState(() => _isLoading = true);
    try {
      final firebaseAuth = context.read(firebaseAuthProvider);
      userCredential = await firebaseAuth.signInWithCredential(
          EmailAuthProvider.credential(email: _email, password: _password));
    } on PlatformException catch (e) {
      await showPlatformDialog<void>(
        context: context,
        builder: (_) => StyledOkDialog(
          title: 'Failed to log in',
          content: util.stripFirebaseHeaderFromMessage(e.message),
        ),
      );
      setState(() => _isLoading = false);
      return;
    } on Exception catch (e) {
      await showPlatformDialog<void>(
        context: context,
        builder: (_) => StyledOkDialog(
          title: 'Failed to log in',
          content: util.stripFirebaseHeaderFromMessage('$e'),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }
    setState(() => _isLoading = false);
    print('user credentials: $userCredential');
    Navigator.pop(context);
  }

  void _onPressedForgotPassword() async {
    if (_isLoading || _hasPressedForgotPassword) {
      return;
    }
    setState(() => _hasPressedForgotPassword = true);
    // hide keyboard if necessary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      _hasPressedForgotPassword = false;
      return;
    }
    form.save();
    final confirm = await showPlatformDialog<bool>(
      context: context,
      builder: (_) => StyledConfirmDialog(
        title: 'Reset Password',
        content: 'This will send you an email to reset your password',
      ),
    );
    if (!confirm) {
      setState(() => _hasPressedForgotPassword = false);
      return;
    }
    try {
      final firebaseAuth = context.read(firebaseAuthProvider);
      await firebaseAuth.sendPasswordResetEmail(email: _email);
    } on PlatformException catch (e) {
      await showPlatformDialog<void>(
        context: context,
        builder: (_) => StyledOkDialog(
          title: 'Failed to send reset password email',
          content: util.stripFirebaseHeaderFromMessage(e.message),
        ),
      );
      setState(() => _hasPressedForgotPassword = false);
      return;
    } on Exception catch (e) {
      await showPlatformDialog<void>(
        context: context,
        builder: (_) => StyledOkDialog(
          title: 'Reset password failed',
          content: util.stripFirebaseHeaderFromMessage('$e'),
        ),
      );
      setState(() => _hasPressedForgotPassword = false);
      return;
    }
    setState(() => _hasPressedForgotPassword = false);
    await showPlatformDialog<void>(
      context: context,
      builder: (_) => StyledOkDialog(
        title: 'Email Sent',
        content:
            'Please check your email for instructions to reset your password',
      ),
    );
    Navigator.pop(context);
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      leading: StyledBackButton(
        onPressed: () => _onPressedBackButton(context),
      ),
      cupertino: (_, __) => CupertinoNavigationBarData(
        padding: const EdgeInsetsDirectional.only(start: 0),
        backgroundColor: Colors.transparent,
        border: const Border(),
        transitionBetweenRoutes: false,
      ),
      material: (_, __) => MaterialAppBarData(
        centerTitle: true,
        elevation: 0,
      ),
    );
  }

  Widget _buildEmailTextFormField() {
    return TextFormField(
      autofocus: true,
      initialValue: _email,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        errorMaxLines: 2,
        errorStyle: Theme.of(context).textTheme.overline.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        labelText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
      ),
      focusNode: _emailFocusNode,
      inputFormatters: <TextInputFormatter>[
        ValidatorInputFormatter(editingValidator: EmailEditingRegexValidator()),
      ],
      validator: util.emailValidator,
      onChanged: (value) {
        _email = value;
        setState(() {});
      },
      onSaved: (str) => _email = str.trim(),
      onFieldSubmitted: (str) =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
    );
  }

  Widget _buildPasswordTextFormField() {
    return TextFormField(
      autofocus: false,
      initialValue: _password,
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        errorMaxLines: 2,
        errorStyle: Theme.of(context).textTheme.overline.copyWith(
              color: Theme.of(context).colorScheme.onError,
            ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        labelText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
      ),
      focusNode: _passwordFocusNode,
      onChanged: (value) {
        _password = value;
        setState(() {});
      },
//      validator: _hasPressedForgotPassword ? null : util.passwordValidator,
      validator: (str) {
        // Don't check password if user has pressed forgot password button
        if (_hasPressedForgotPassword) {
          return null;
        }
        return util.passwordValidator(str);
      },
      onSaved: (str) => _password = str.trim(),
      onFieldSubmitted: (_) => _onFormSubmit(),
    );
  }

  Widget _buildLogInButton() {
    return StyledButton(
      color: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      borderColor: Theme.of(context).colorScheme.primary,
      onPressed: _onFormSubmit,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Log In',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (_isLoading)
            SizedBox(
              height: 20,
              width: 20,
              child: PlatformCircularProgressIndicator(
                material: (_, __) => MaterialProgressIndicatorData(
                  backgroundColor: Colors.white,
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildBody() {
    final List<Widget> list = [
      if (isCupertino(context)) SizedBox(height: 16),
      Text(
        'Log In',
        style: Theme.of(context).textTheme.headline3.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 32.0),
      _buildEmailTextFormField(),
      const SizedBox(height: 32.0),
      _buildPasswordTextFormField(),
      const SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: _ForgotPasswordButton(
          onPressed: _onPressedForgotPassword,
        ),
      ),
      const SizedBox(height: 16.0),
      _buildLogInButton(),
    ];

    // wrap in a form
    final form = Form(
      key: _formKey,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: list,
      ),
    );
    return form;
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
            child: Material(
              color: Theme.of(context).colorScheme.background,
              child: PlatformScaffold(
                // iosContentPadding: true,
                // iosContentBottomPadding: true,
                appBar: _buildAppBar(context),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: _buildBody(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  _ForgotPasswordButton({
    @required this.onPressed,
  });
  final VoidCallback onPressed;

  Widget _ForgotPasswordText(BuildContext context) {
    return Text(
      'Forgot Password',
      style: Theme.of(context).textTheme.overline.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onBackground,
            decoration: TextDecoration.underline,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 0,
      children: [
        if (isCupertino(context))
          PlatformButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            cupertino: (_, __) => CupertinoButtonData(
              minSize: 30,
              //padding: EdgeInsets.zero,
            ),
            child: _ForgotPasswordText(context),
          ),
        if (!isCupertino(context))
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _ForgotPasswordText(context),
            ),
          ),
      ],
    );
  }
}
