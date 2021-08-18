import 'package:ahed/Session/session_manager.dart';
import 'package:flutter/material.dart';

class CustomImageShower extends StatelessWidget {
  final url;
  final SessionManager sessionManager = new SessionManager();
  CustomImageShower({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: sessionManager.user!.profileImage != 'N/A'
            ? Image.network(this.url)
            : Image.asset(
          'assets/images/user.png',
        ),
      ),
    );
  }
}