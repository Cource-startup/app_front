import 'package:app_front/handler/api_request_handler.dart';
import 'package:app_front/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:app_front/views/widgets/custom_avatar.dart';
import 'package:app_front/service/user/user_provider.dart';

class SettingsContent extends ConsumerStatefulWidget {
  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends ConsumerState<SettingsContent> {
  late TextEditingController loginController;
  late TextEditingController nameController;
  User? user; // Nullable to avoid LateInitializationError

  bool get isChanged {
    if (user == null) return false; // Ensure user is initialized
    return loginController.text != user!.login ||
        nameController.text != user!.userName ||
        user!.avatar != user!.avatar;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ref.watch(userProvider); // Initialize user
    loginController = TextEditingController(text: user!.login);
    nameController = TextEditingController(text: user!.userName);
  }

  Future<void> _pickNewAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref.read(userProvider.notifier).updateAvatar(pickedFile.path);
      setState(() {}); // Rebuild to check for changes
    } else {
      debugPrint("No image selected");
    }
  }

  void _saveSettings(WidgetRef ref) async {
    if (user == null) return;

    final apiRequestService = ApiRequestHandler(ref);
    var response = await apiRequestService.post(
      "/update_user/${user!.id}",
      {
        'login': loginController.text.isNotEmpty
            ? loginController.text
            : user!.login,
        'user_name': nameController.text.isNotEmpty
            ? nameController.text
            : user!.userName,
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something is wrong!')),
        );
      },
    );

    if (response?.statusCode == 200) {
      // Update user properties via the provider
      ref.read(userProvider.notifier).updateLogin(loginController.text);
      ref.read(userProvider.notifier).updateUserName(nameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings updated successfully')),
      );

      setState(() {
        user = ref.watch(userProvider); // Update local user instance
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = user; // Ensure user is initialized
    if (currentUser == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Change Avatar Section
            Text('Change Avatar',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _pickNewAvatar,
                child: CustomAvatar(
                  avatar: currentUser.avatar, // Use avatar from user provider
                  radius: 60.0,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Change Login Section
            Text('Change Login',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: loginController,
              onChanged: (value) => setState(() {}), // Rebuild on change
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Login',
                hintText: 'Enter new username',
              ),
            ),
            const SizedBox(height: 20),

            // Set Up Legal Name Section
            Text('Set Up Legal Name',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              onChanged: (value) => setState(() {}), // Rebuild on change
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Legal Name',
                hintText: 'Enter your full legal name',
              ),
            ),
            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: isChanged
                    ? () => _saveSettings(ref)
                    : null, // Enable only if changed
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
