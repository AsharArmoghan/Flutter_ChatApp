import 'package:chat_app/Widgets/login_form_validation.dart';
import 'package:chat_app/Widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _submitting = false;

  Future<void> _handlingLogin(String email, String password) async {
    setState(() {
      _submitting = !_submitting;
    });
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signed in")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Failed:')));
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context);
    return Scaffold(
        backgroundColor: themeStyle.scaffoldBackgroundColor,
        primary: true,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.message,
                  size: 80,
                  color: themeStyle.colorScheme.primaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Welcome Back, you've been missed!",
                style: themeStyle.textTheme.headlineSmall,
              ),

              const SizedBox(height: 20),
              Text(
                "LogIn",
                style: themeStyle.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 370,
                height: 250,
                child: ValidatedForm(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onValidSubmit: _handlingLogin),
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: () => Navigator.pushNamed(context, '/signin'),
                text: 'Go to Sign in',
                backColor: themeStyle.colorScheme.secondaryContainer,
                fontSize: 20,
                frontColor: Theme.of(context).colorScheme.onSecondaryContainer,
              )
            ],
          ),
        ));
  }
}
