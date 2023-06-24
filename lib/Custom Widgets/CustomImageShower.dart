import 'package:ahed/Session/session_manager.dart';
import 'package:flutter/material.dart';

class CustomImageShower extends StatelessWidget {
  final String? url;
  final SessionManager sessionManager = SessionManager();
  CustomImageShower({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.white,
        child: url != null
            ? Image.network(
                url!,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/user.png'),
              )
            : Image.asset(
                'assets/images/user.png',
              ),
      ),
    );
  }
}
