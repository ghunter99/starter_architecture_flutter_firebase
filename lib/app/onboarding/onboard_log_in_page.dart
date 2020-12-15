import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_back_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_button.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_ok_dialog.dart';

class OnboardLogInPage extends StatefulWidget {
  @override
  _OnboardLogInPageState createState() => _OnboardLogInPageState();
}

class _OnboardLogInPageState extends State<OnboardLogInPage> {
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

  Widget _buildLogInButton() {
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
                'Log In',
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
      _ForgotPasswordButton(
        onPressed: () => StyledOkDialog.show(
          context,
          title: 'Not implemented yet',
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
