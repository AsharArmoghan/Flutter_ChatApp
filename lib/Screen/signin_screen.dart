import 'package:chat_app/Widgets/my_button.dart';
import 'package:chat_app/Widgets/signin_form_with_validation.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _submitting = false;

  Future<void> _handlingSignin(
      String email, String password, String username) async {
    setState(() {
      _submitting = !_submitting;
    });
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signed in")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sign In Failed:')));
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
        backgroundColor: themeStyle.colorScheme.surface,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.message,
                  size: 80,
                  color: themeStyle.colorScheme.primaryContainer,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Welcome to Chatbox",
                style: themeStyle.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text("Sign In", style: themeStyle.textTheme.headlineMedium),
              const SizedBox(height: 10),
              SizedBox(
                width: 370,
                height: 300,
                child: ValidatedSigninForm(onValidSubmit: _handlingSignin),
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: () => Navigator.pop(context),
                text: 'Go to Log in',
                backColor: themeStyle.colorScheme.secondaryContainer,
                fontSize: 17,
                frontColor: themeStyle.colorScheme.onSecondaryContainer,
              )
            ],
          ),
        ));
  }
}
