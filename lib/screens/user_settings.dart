import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabitok/providers/user_provider.dart';
import 'package:sabitok/screens/onboarding_screen.dart';
import 'package:sabitok/widgets/custom_button.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(userProvider.user.username),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: CustomButton(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, OnboardingScreen.routeName);
              },
              text: ('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}
