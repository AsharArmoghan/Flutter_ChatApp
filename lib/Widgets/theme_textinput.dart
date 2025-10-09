import 'package:flutter/material.dart';

class ThemeAwareTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onSend;
  final IconData? prefixIcon;
  final TextInputType? textType;
  final String? Function(String?)? validator;

  const ThemeAwareTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.onSend,
      this.prefixIcon,
      this.textType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(),
            width: 1,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: colorScheme.onSurfaceVariant,
                )
              : null,
          suffixIcon: IconButton(
            onPressed: onSend,
            icon: Icon(
              Icons.send,
              color: colorScheme.primary,
            ),
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
      ),
    );
  }
}
