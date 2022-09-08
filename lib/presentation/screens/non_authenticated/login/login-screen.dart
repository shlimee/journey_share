import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/data/datasources/auth_remote_data_source.dart';
import 'package:journey_share/data/repositories/auth_repository_impl.dart';
import 'package:journey_share/domain/usecases/login.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';
import 'package:journey_share/presentation/screens/non_authenticated/register/register-screen.dart';
import 'package:journey_share/presentation/widgets/button_with_indicator.dart';

import '../../../../style/text.styles.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool fadeAnimation = false;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    userNameController.addListener(() {
      debugPrint('username:' + userNameController.text);
    });
    passwordController.addListener(() {
      debugPrint('password:' + passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fadeAnimation = true;
    });

    return Scaffold(
      bottomSheet: _bottomSheet(),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, appState) {
        AuthState state = BlocProvider.of<AuthBloc>(context).state;
        if (state is AuthenticatedState) {
          Navigator.of(context).pushNamedAndRemoveUntil('/feed', (_) => false);
        }
      }, builder: (context, appState) {
        return Column(
          children: [
            const SizedBox(height: 196),
            _title(),
            const SizedBox(
              height: 45,
            ),
            const Text('Please log in!'),
            Text(appState.toString()),
            const SizedBox(
              height: 25,
            ),
            AnimatedOpacity(
              opacity: fadeAnimation == true ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    _usernameField(),
                    const SizedBox(
                      height: 25,
                    ),
                    _passwordField(),
                    const SizedBox(
                      height: 25,
                    ),
                    _loginButton(context),
                    _registerRedirectButton(context),
                    _dontYouHaveAnAccount(),
                    if (appState is ErrorState)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${appState.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Align _dontYouHaveAnAccount() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(textAlign: TextAlign.right, "Don't have an account?"),
    );
  }

  TextButton _registerRedirectButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      child: const Text(
        'Register',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  ButtonWithIndicator _loginButton(BuildContext context) {
    return ButtonWithIndicator(
        onSubmit: () {
          BlocProvider.of<AuthBloc>(context).add(OnLoginAttempt(
              userName: userNameController.value.text,
              password: passwordController.value.text));
        },
        text: const Text('Log in'),
        icon: const Icon(Icons.login));
  }

  TextFormField _passwordField() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      controller: passwordController,
      autovalidateMode: AutovalidateMode.always,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.key),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        hintText: 'What is your password?',
        labelText: 'Password *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  TextFormField _usernameField() {
    return TextFormField(
      controller: userNameController,
      autovalidateMode: AutovalidateMode.always,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        hintText: 'What is your username?',
        labelText: 'Username *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Center _title() {
    return Center(
        child: Text(
      textAlign: TextAlign.center,
      'JourneyShare',
      style: TextStyles.title,
    ));
  }

  Row _bottomSheet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('made by ❤️ from Hungary'),
        SizedBox(
          height: 75,
        )
      ],
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
