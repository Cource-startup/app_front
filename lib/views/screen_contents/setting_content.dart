import 'package:app_front/service/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SettingsContent extends ConsumerStatefulWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends ConsumerState<SettingsContent> {
  late TextEditingController loginController;
  late TextEditingController nameController;
  File? _selectedAvatar; // To hold the new avatar image

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    loginController = TextEditingController(text: user.login);
    nameController = TextEditingController(text: user.userName);

    loginController.addListener(_onTextChanged);
    nameController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
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
        nameController.text != user.userName ||
        _selectedAvatar != null; // Check for avatar change
  }

  /// Pick a new avatar using ImagePicker
  Future<void> _pickNewAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.path);
      });
    } else {
      debugPrint("No image selected");
    }
  }

  Future<void> _saveSettings() async {
    final notifier = ref.read(userProvider.notifier);

    try {
      final updatedFields = {
        'login': loginController.text,
        'user_name': nameController.text,
      };

      // Handle avatar updates
      if (_selectedAvatar != null) {
        await notifier.updateAvatar(_selectedAvatar!);
      }

      await notifier.updateFields(updatedFields);

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
            // Change Avatar Section
            const Text(
              'Change Avatar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _pickNewAvatar,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: _selectedAvatar != null
                      ? FileImage(_selectedAvatar!)
                      : NetworkImage(user.avatar) as ImageProvider,
                  child: _selectedAvatar == null
                      ? const Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

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
