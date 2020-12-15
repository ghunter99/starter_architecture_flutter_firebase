import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_back_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_ok_dialog.dart';

class OnboardSignupPage extends StatefulWidget {
  @override
  _OnboardSignupPageState createState() => _OnboardSignupPageState();
}

class _OnboardSignupPageState extends State<OnboardSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _emailFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  String _firstNameValidator(String name) {
    // check length
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter first name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for hyphen, single quote, apostrophe or period characters
    final str1 = trimmedName
        .replaceAll('-', '')
        .replaceAll("'", '')
        .replaceAll('’', '')
        .replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  String _lastNameValidator(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter last name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for hyphen, single quote, apostrophe or period characters
    final str1 = trimmedName
        .replaceAll('-', '')
        .replaceAll("'", '')
        .replaceAll('’', '')
        .replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  void _onPressedBackButton(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFormSubmit() {
    // hide keyboard if neccesary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
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
      validator: _firstNameValidator,
      onChanged: (value) {
        _email = value;
        setState(() {});
      },
      onSaved: (str) => _email = str.trim(),
      onFieldSubmitted: (str) =>
          FocusScope.of(context).requestFocus(_lastNameFocusNode),
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
      focusNode: _lastNameFocusNode,
      onChanged: (value) {
        _email = value;
        setState(() {});
      },
      validator: _lastNameValidator,
      onSaved: (str) => _password = str.trim(),
      onFieldSubmitted: (_) => _onFormSubmit(),
    );
  }

  Widget _buildSignUpButton() {
    return StyledButton(
      color: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      borderColor: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        // await Navigator.push<bool>(
        //   context,
        //   platformPageRoute(
        //     context: context,
        //     builder: (_) {},
        //   ),
        // );
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Agree and Sign Up',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final List<Widget> list = [
      if (isCupertino(context)) SizedBox(height: 16),
      Text(
        'Sign Up with Email',
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
      _TermsParagraph(
        onPressed: () => StyledOkDialog.show(
          context,
          title: 'Not implemented yet',
        ),
      ),
      _PrivacyParagraph(
        onPressed: () => StyledOkDialog.show(
          context,
          title: 'Not implemented yet',
        ),
      ),
      const SizedBox(height: 16.0),
      _buildSignUpButton(),
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

class _TermsParagraph extends StatelessWidget {
  _TermsParagraph({@required this.onPressed});
  final VoidCallback onPressed;

  Widget _text(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.overline.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );
  }

  Widget _TermsText(BuildContext context) {
    return Text(
      'Terms of Service',
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
        _text(context, 'By signing up you are agreeing to our '),
        if (isCupertino(context))
          PlatformButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            cupertino: (_, __) => CupertinoButtonData(
              minSize: 30,
              //padding: EdgeInsets.zero,
            ),
            child: _TermsText(context),
          ),
        if (!isCupertino(context))
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _TermsText(context),
            ),
          ),
        _text(context, '.'),
      ],
    );
  }
}

class _PrivacyParagraph extends StatelessWidget {
  _PrivacyParagraph({
    @required this.onPressed,
  });
  final VoidCallback onPressed;

  Widget _text(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.overline.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );
  }

  Widget _PrivacyText(BuildContext context) {
    return Text(
      'Privacy Policy',
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
        _text(context, 'View our '),
        if (isCupertino(context))
          PlatformButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            cupertino: (_, __) => CupertinoButtonData(
              minSize: 30,
              //padding: EdgeInsets.zero,
            ),
            child: _PrivacyText(context),
          ),
        if (!isCupertino(context))
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _PrivacyText(context),
            ),
          ),
        _text(context, '.'),
      ],
    );
  }
}
