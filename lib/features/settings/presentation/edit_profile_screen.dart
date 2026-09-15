import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Profile',
        showLeadingIcon: true,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
    );
  }
}
