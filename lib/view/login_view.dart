import 'package:flutter/material.dart';
import 'package:menotes/constants/routes.dart';
import 'package:menotes/services/auth/auth_exceptions.dart';
import 'package:menotes/services/auth/auth_service.dart';
import 'package:menotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 178, 141, 243),
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'email',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                // print('email: $email');
                // print('password: $password');

                try {
                  await AuthService.firebase().login(
                    email: email,
                    password: password,
                  );
                  // print(
                  //   "logged in as "$user.email,
                  // );

                  final user = AuthService.firebase().currentUser;

                  // print('user: $user');

                  // print(user?.isEmailVerified ?? false);

                  if (user?.isEmailVerified ?? false) {
                    //verified user
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } else {
                    //unverified user
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  await showErrorDialog(
                    context,
                    "No user found for that email.",
                  );
                } on WrongPasswordAuthException {
                  await showErrorDialog(
                    context,
                    "Wrong credentials provided for that user.",
                  );
                } on UserDisabledAuthException {
                  await showErrorDialog(
                    context,
                    "The user has been disabled.",
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Authentication Error",
                  );
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text('Register Here!')),
          ],
        ),
      ),
    );
  }
}
