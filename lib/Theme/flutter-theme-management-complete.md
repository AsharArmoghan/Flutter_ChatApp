# Complete Flutter Theme Management System with Examples

## Global Theme Management with Provider

### 1. Theme Provider Setup

First, add the required dependencies to your `pubspec.yaml`:

```yaml
dependencies:
     flutter:
          sdk: flutter
     provider: ^6.1.1
     shared_preferences: ^2.2.2
```

### 2. Theme Provider Class

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeStyle { apple, samsung, messenger }
enum AppThemeMode { system, light, dark }

class ThemeProvider extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  static const String _themeStyleKey = 'theme_style';

  AppThemeMode _themeMode = AppThemeMode.system;
  ThemeStyle _themeStyle = ThemeStyle.apple;
  bool _isInitialized = false;

  AppThemeMode get themeMode => _themeMode;
  ThemeStyle get themeStyle => _themeStyle;
  bool get isInitialized => _isInitialized;

  // Initialize theme from storage
  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    final themeModeString = prefs.getString(_themeModeKey) ?? 'system';
    _themeMode = AppThemeMode.values.firstWhere(
      (mode) => mode.toString().split('.').last == themeModeString,
      orElse: () => AppThemeMode.system,
    );

    // Load theme style
    final themeStyleString = prefs.getString(_themeStyleKey) ?? 'apple';
    _themeStyle = ThemeStyle.values.firstWhere(
      (style) => style.toString().split('.').last == themeStyleString,
      orElse: () => ThemeStyle.apple,
    );

    _isInitialized = true;
    notifyListeners();
  }

  // Change theme mode (light/dark/system)
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString().split('.').last);
    notifyListeners();
  }

  // Change theme style (apple/samsung/messenger)
  Future<void> setThemeStyle(ThemeStyle style) async {
    if (_themeStyle == style) return;

    _themeStyle = style;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeStyleKey, style.toString().split('.').last);
    notifyListeners();
  }

  // Get light theme based on selected style
  ThemeData get lightTheme {
    switch (_themeStyle) {
      case ThemeStyle.samsung:
        return samsungOneUILightTheme;
      case ThemeStyle.messenger:
        return facebookMessengerLightTheme;
      default:
        return appleIOSLightTheme;
    }
  }

  // Get dark theme based on selected style
  ThemeData get darkTheme {
    switch (_themeStyle) {
      case ThemeStyle.samsung:
        return samsungOneUIDarkTheme;
      case ThemeStyle.messenger:
        return facebookMessengerDarkTheme;
      default:
        return appleIOSDarkTheme;
    }
  }
}
```

### 3. Main App Setup

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..initializeTheme(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Show loading screen while initializing
        if (!themeProvider.isInitialized) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return MaterialApp(
          title: 'Chat App Theme Demo',
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: _convertThemeMode(themeProvider.themeMode),
          home: const ChatHomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  // Convert custom AppThemeMode to Flutter's AppThemeMode
  AppThemeMode _convertThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return AppThemeMode.light;
      case AppThemeMode.dark:
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }
}
```

## Component Examples Using Theme Colors

### 1. Chat Message Cards

```dart
class ChatMessageCard extends StatelessWidget {
  final String message;
  final bool isSent;
  final String timestamp;

  const ChatMessageCard({
    super.key,
    required this.message,
    required this.isSent,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Card(
          // Using theme colors for message bubbles
          color: isSent
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSent
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSent
                      ? colorScheme.onPrimary.withOpacity(0.7)
                      : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 2. User Profile Card

```dart
class UserProfileCard extends StatelessWidget {
  final String name;
  final String status;
  final String avatarUrl;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.status,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surface,
      elevation: 2,
      shadowColor: colorScheme.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. Custom Text Input Field

```dart
class ThemeAwareTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onSend;
  final IconData? prefixIcon;

  const ThemeAwareTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onSend,
    this.prefixIcon,
  });

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
            color: colorScheme.outline.withOpacity(0.2),
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
              color: colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
```

### 4. Custom App Bar

```dart
class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSettingsTap;

  const ChatAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: colorScheme.surfaceTint,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onSettingsTap,
          icon: Icon(
            Icons.settings,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
```

### 5. Theme Selection Dialog

```dart
class ThemeSelectionDialog extends StatelessWidget {
  const ThemeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      title: Text(
        'Choose Theme',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Theme Mode Selection
          Text(
            'Brightness',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...AppThemeMode.values.map((mode) => RadioListTile<AppThemeMode>(
            value: mode,
            groupValue: themeProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                themeProvider.setThemeMode(value);
              }
            },
            title: Text(
              mode.toString().split('.').last.toUpperCase(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            activeColor: colorScheme.primary,
          )),

          const Divider(),

          // Theme Style Selection
          Text(
            'Style',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...ThemeStyle.values.map((style) => RadioListTile<ThemeStyle>(
            value: style,
            groupValue: themeProvider.themeStyle,
            onChanged: (value) {
              if (value != null) {
                themeProvider.setThemeStyle(value);
              }
            },
            title: Text(
              _getStyleDisplayName(style),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              _getStyleDescription(style),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            activeColor: colorScheme.primary,
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(color: colorScheme.primary),
          ),
        ),
      ],
    );
  }

  String _getStyleDisplayName(ThemeStyle style) {
    switch (style) {
      case ThemeStyle.apple:
        return 'Apple iOS';
      case ThemeStyle.samsung:
        return 'Samsung One UI';
      case ThemeStyle.messenger:
        return 'Facebook Messenger';
    }
  }

  String _getStyleDescription(ThemeStyle style) {
    switch (style) {
      case ThemeStyle.apple:
        return 'Clean and minimalist design';
      case ThemeStyle.samsung:
        return 'Modern Material Design';
      case ThemeStyle.messenger:
        return 'Colorful and vibrant theme';
    }
  }
}
```

## Complete Home Screen Example

```dart
class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Hey! How's the new theme looking?",
      isSent: false,
      timestamp: "2:30 PM",
    ),
    ChatMessage(
      message: "It looks amazing! I love how it adapts to different styles.",
      isSent: true,
      timestamp: "2:31 PM",
    ),
    ChatMessage(
      message: "The Apple theme is so clean and the Samsung one is vibrant!",
      isSent: true,
      timestamp: "2:32 PM",
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            message: _messageController.text,
            isSent: true,
            timestamp: "${DateTime.now().hour}:${DateTime.now().minute}",
          ),
        );
      });
      _messageController.clear();
    }
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => const ThemeSelectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: ChatAppBar(
        title: "Chat Demo",
        subtitle: "Theme Management Example",
        onSettingsTap: _showThemeDialog,
      ),
      body: Column(
        children: [
          // User Profile Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: UserProfileCard(
              name: "John Doe",
              status: "Online",
              avatarUrl: "https://via.placeholder.com/150",
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatMessageCard(
                  message: message.message,
                  isSent: message.isSent,
                  timestamp: message.timestamp,
                );
              },
            ),
          ),

          // Message Input
          ThemeAwareTextField(
            controller: _messageController,
            hintText: "Type a message...",
            prefixIcon: Icons.emoji_emotions_outlined,
            onSend: _sendMessage,
          ),
        ],
      ),

      // Floating Action Button for quick theme switch
      floatingActionButton: FloatingActionButton(
        onPressed: _showThemeDialog,
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: const Icon(Icons.palette),
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isSent;
  final String timestamp;

  ChatMessage({
    required this.message,
    required this.isSent,
    required this.timestamp,
  });
}
```

## Bottom Navigation Example

```dart
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChatHomeScreen(),
    const ContactsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary.withOpacity(0.1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: Icon(
              Icons.chat_bubble,
              color: colorScheme.primary,
            ),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.people_outline,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: Icon(
              Icons.people,
              color: colorScheme.primary,
            ),
            label: 'Contacts',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: Icon(
              Icons.settings,
              color: colorScheme.primary,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
```

## Quick Theme Toggle Widget

```dart
class QuickThemeToggle extends StatelessWidget {
  const QuickThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          // Theme Mode Toggle
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: AppThemeMode.values.map((mode) {
                final isSelected = themeProvider.themeMode == mode;
                return GestureDetector(
                  onTap: () => themeProvider.setThemeMode(mode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                        ? colorScheme.primary
                        : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      mode.toString().split('.').last,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                        fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Container(
            width: 1,
            height: 32,
            color: colorScheme.outline.withOpacity(0.3),
          ),

          // Theme Style Selector
          PopupMenuButton<ThemeStyle>(
            initialValue: themeProvider.themeStyle,
            onSelected: (style) => themeProvider.setThemeStyle(style),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.palette,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getStyleShortName(themeProvider.themeStyle),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => ThemeStyle.values.map((style) {
              return PopupMenuItem<ThemeStyle>(
                value: style,
                child: Text(_getStyleDisplayName(style)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getStyleShortName(ThemeStyle style) {
    switch (style) {
      case ThemeStyle.apple:
        return 'iOS';
      case ThemeStyle.samsung:
        return 'One UI';
      case ThemeStyle.messenger:
        return 'Messenger';
    }
  }

  String _getStyleDisplayName(ThemeStyle style) {
    switch (style) {
      case ThemeStyle.apple:
        return 'Apple iOS Style';
      case ThemeStyle.samsung:
        return 'Samsung One UI Style';
      case ThemeStyle.messenger:
        return 'Facebook Messenger Style';
    }
  }
}
```

## Usage Summary

### Key Features:

1. **Global Theme Management**: Uses Provider for state management with SharedPreferences persistence
2. **Multiple Theme Styles**: Apple iOS, Samsung One UI, and Facebook Messenger themes
3. **Dynamic Switching**: Change themes at runtime without app restart
4. **Component Examples**: Real-world usage of theme colors in cards, buttons, text fields, and navigation
5. **Persistent Storage**: Theme preferences saved across app sessions

### Implementation Benefits:

-    **Consistent Theming**: All components automatically use theme colors
-    **Easy Maintenance**: Centralized theme management
-    **User Experience**: Smooth theme transitions with immediate visual feedback
-    **Platform Native Feel**: Each theme style matches platform conventions
-    **Accessibility**: Proper contrast ratios maintained across all themes

This complete system provides everything needed to implement professional-grade theme management in Flutter chat applications with multiple style options and persistent user preferences.
