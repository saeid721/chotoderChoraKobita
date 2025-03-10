import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TwitterScreen extends StatefulWidget {
  const TwitterScreen({super.key});

  @override
  State<TwitterScreen> createState() => _TwitterScreenState();
}

class _TwitterScreenState extends State<TwitterScreen> {
  @override
  void initState() {
    super.initState();
    // Adding a small delay before launching Instagram
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), _launchInstagram);
    });
  }

  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse('https://x.com/stitbd');

    if (await canLaunchUrl(url)) {
      // Launch Instagram externally
      await launchUrl(url, mode: LaunchMode.externalApplication);

      // Add delay before popping the screen
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted) {
            Navigator.pop(context); // Close the current screen
          }
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Twitter.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}