import 'package:flutter/material.dart';
import 'package:menotes/constants/routes.dart';
import 'package:menotes/services/auth/auth_exceptions.dart';
import 'package:menotes/services/auth/auth_service.dart';
import 'package:menotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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

                try {
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(
                    verifyEmailRoute,
                  );
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    "weak passowrd",
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                    context,
                    "email already in use",
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    "invalid email",
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    "Failed to register",
                  );
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                child: const Text('Already have an account? Login'))
          ],
        ),
      ),
    );
  }
}
