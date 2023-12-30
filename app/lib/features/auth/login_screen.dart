import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../logic/stores/auth_store.dart';
import '../../utils/palette.dart';
import '../../utils/routes/app_router.gr.dart';
import '../../utils/typography.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/login.png'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 32),
                  const Text(
                    "Login In or Sign Up",
                    style: Typo.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  // Input Field with Border radius 16 outline border
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Input Field with Border radius 16 outline border
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        // Handle login logic
                        if (await context.read<AuthStore>().signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )) {
                          if (context.mounted) context.router.replace(const MainScaffoldRoute());
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid credentials'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 36,
                          ),
                        ),
                      ),
                      const Text('or Login with'),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: const Divider(
                            color: Colors.grey,
                            height: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9FE),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/google.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          // Handle login logic
                          // if (await context.read<AuthStore>().signInWithApple()) {
                          if (context.mounted) context.router.replace(const MainScaffoldRoute());
                          // } else {
                          //   if (context.mounted) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Invalid credentials'),
                          //       ),
                          //     );
                          //   }
                          // }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9FE),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/apple.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Apple',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          // Handle login logic
                          // if (await context.read<AuthStore>().signInWithApple()) {
                          if (context.mounted) context.router.replace(const MainScaffoldRoute());
                          // } else {
                          //   if (context.mounted) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Invalid credentials'),
                          //       ),
                          //     );
                          //   }
                          // }
                        },
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Account?'),
                      TextButton(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Palette.primary,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          // Navigate to registration screen
                        },
                      ),
                    ],
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
