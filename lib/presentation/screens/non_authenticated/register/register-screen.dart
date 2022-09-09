import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/injection_container.dart';
import 'package:journey_share/presentation/bloc/auth/auth.bloc.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';
import 'package:journey_share/style/text.styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => sl<AuthBloc>(),
        ),
      ],
      child: Scaffold(
        bottomSheet: _bottomSheet(),
        body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, appState) {},
            builder: (context, appState) {
              return Column(
                children: [
                  const SizedBox(height: 196),
                  _title(),
                  const SizedBox(
                    height: 45,
                  ),
                  const Text('Please register!'),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        _emailField(),
                        const SizedBox(
                          height: 25,
                        ),
                        _userNameField(),
                        const SizedBox(
                          height: 25,
                        ),
                        _passwordField(),
                        const SizedBox(
                          height: 25,
                        ),
                        _registerButton(context),
                        _loginRedirectButton(context),
                        if (appState is ErrorState &&
                            appState.errorMessage != null)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${appState.errorMessage}',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  TextButton _loginRedirectButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(40)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  OutlinedButton _registerButton(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(
            40), // fromHeight use double.infinity as width and 40 is the height
      ),
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(OnRegisterAttempt(
            email: emailController.value.text,
            userName: userNameController.value.text,
            password: passwordController.value.text));
      },
      child: const Text('Register'),
    );
  }

  TextFormField _passwordField() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      enableSuggestions: false,
      controller: passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        if (value == null || value.length < 6) return 'Password is too short!';
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  TextFormField _userNameField() {
    return TextFormField(
      controller: userNameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
        if (value == null || value.length < 6) return 'Username is too short!';
      },
    );
  }

  TextFormField _emailField() {
    return TextFormField(
      controller: emailController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        hintText: 'What is your email?',
        labelText: 'Email *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        if (value == null || value.length < 6) return 'Username is too short!';
        return (value != null && !value.contains('@'))
            ? 'Enter a valid email!'
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
}
