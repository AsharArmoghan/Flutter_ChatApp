import 'package:flutter/material.dart';
import 'package:chat_app/Widgets/my_button.dart';

class ValidatedSigninForm extends StatefulWidget {
  const ValidatedSigninForm({
    super.key,
    required this.onValidSubmit,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final void Function(String email, String password, String username)
      onValidSubmit;
  final AutovalidateMode autovalidateMode;

  @override
  State<ValidatedSigninForm> createState() => _ValidatedSigninFormState();
}

class _ValidatedSigninFormState extends State<ValidatedSigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  final _usernameC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    _usernameC.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final re = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!re.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _submit() {
    final ok = _formKey.currentState!.validate();
    if (!ok) return;
    widget.onValidSubmit(
        _emailC.text.trim(), _passwordC.text, _usernameC.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 360,
              child: TextFormField(
                  controller: _usernameC,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    prefixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: Icon(
                        Icons.face,
                        color: colorScheme.primary,
                      ),
                    ),
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ))),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 360,
              child: TextFormField(
                controller: _emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.email,
                      color: colorScheme.primary,
                    ),
                  ),
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 360,
            child: TextFormField(
              controller: _passwordC,
              decoration: InputDecoration(
                labelText: 'Password',
                prefix: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Icon(
                    Icons.password,
                    color: colorScheme.primary,
                  ),
                ),
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              obscureText: true,
              validator: _validatePassword,
            ),
          ),
          const SizedBox(height: 15),
          MyButton(
            text: 'Sign in',
            onTap: _submit,
            backColor: Theme.of(context).colorScheme.primary,
            frontColor: Theme.of(context).colorScheme.onPrimary,
            fontSize: 22,
          )
        ],
      ),
    );
  }
}
