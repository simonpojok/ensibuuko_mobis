import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginErrorScreen extends StatelessWidget {
  static const String path = 'login-error-screen';

  const LoginErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'Unknown',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                      fontSize: 24,
                    ),
              ),
              const SizedBox(height: 5),
              Container(
                width: width + 2,
                height: width / 1.5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.warning,
                  color: Colors.yellow,
                  size: 120,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Try Again'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
