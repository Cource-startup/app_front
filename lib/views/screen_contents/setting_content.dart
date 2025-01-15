import 'package:app_front/service/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsContent extends ConsumerStatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends ConsumerState<SettingsContent> {
  late TextEditingController loginController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers when the widget is created
    final user = ref.read(userProvider);
    loginController = TextEditingController(text: user.login);
    nameController = TextEditingController(text: user.userName);

    // Add listeners to rebuild the widget when the text changes
    loginController.addListener(_onTextChanged);
    nameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Dispose the controllers to prevent memory leaks
    loginController.dispose();
    nameController.dispose();
    super.dispose();
  }

  /// Rebuild the widget when text changes
  void _onTextChanged() {
    setState(() {});
  }

  /// Check if any settings have changed
  bool get isChanged {
    final user = ref.read(userProvider);
    return loginController.text != user.login ||
        nameController.text != user.userName;
  }

  /// Save the updated settings
  void _saveSettings() async {
  final notifier = ref.read(userProvider.notifier);

  try {
    await notifier.updateFields({
      'login': loginController.text,
      'userName': nameController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved successfully')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save settings: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Change Login Section
            const Text(
              'Change Login',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Login',
                hintText: 'Enter new username',
              ),
            ),
            const SizedBox(height: 20),

            // Change Name Section
            const Text(
              'Change Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'Enter your full name',
              ),
            ),
            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: isChanged ? _saveSettings : null,
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
