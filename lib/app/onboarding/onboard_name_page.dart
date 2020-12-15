import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:starter_architecture_flutter_firebase/styled_components/styled_button.dart';

class OnboardNamePage extends StatefulWidget {
  @override
  _OnboardNamePageState createState() => _OnboardNamePageState();
}

class _OnboardNamePageState extends State<OnboardNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  String _firstName;
  String _lastName;

  @override
  void initState() {
    super.initState();
    _firstName = '';
    _lastName = '';
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _firstNameFocusNode.dispose();
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
      // leading: StyledBackButton(
      //   onPressed: () => _onPressedBackButton(context),
      // ),
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

  Widget _buildFirstNameTextFormField() {
    return TextFormField(
      autofocus: true,
      initialValue: _firstName,
      keyboardType: TextInputType.text,
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
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
        labelText: 'First Name',
        contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
      ),
      focusNode: _firstNameFocusNode,
      validator: _firstNameValidator,
      onChanged: (value) {
        _firstName = value;
        setState(() {});
      },
      onSaved: (str) => _firstName = str.trim(),
      onFieldSubmitted: (str) =>
          FocusScope.of(context).requestFocus(_lastNameFocusNode),
    );
  }

  Widget _buildLastNameTextFormField() {
    return TextFormField(
      autofocus: false,
      initialValue: _lastName,
      keyboardType: TextInputType.text,
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
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
        labelText: 'Last Name',
        contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
      ),
      focusNode: _lastNameFocusNode,
      onChanged: (value) {
        _firstName = value;
        setState(() {});
      },
      validator: _lastNameValidator,
      onSaved: (str) => _lastName = str.trim(),
      onFieldSubmitted: (_) => _onFormSubmit(),
    );
  }

  Widget _buildLetsGoButton() {
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
                'Lets\'s Go',
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
        'Create Your Profile',
        style: Theme.of(context).textTheme.headline3.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 32.0),
      _buildFirstNameTextFormField(),
      const SizedBox(height: 32.0),
      _buildLastNameTextFormField(),
      const SizedBox(height: 32.0),
      _buildLetsGoButton(),
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
