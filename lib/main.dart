import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Temporary account storage
class AuthStore {
  static final Map<String, String> users = {};
}

// ================= MAIN APP =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: Login(),
    );
  }
}

// ================= LOGIN PAGE =================

class Login extends StatelessWidget {
  Login({super.key});

  final user = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue.shade50,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(25),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 70,
                    color: Colors.blue,
                  ),

                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    controller: user,
                    decoration: const InputDecoration(
                      labelText: 'Email or Mobile Number',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String username =
                            user.text.trim().toLowerCase();
                        String password = pass.text;

                        if (AuthStore.users.containsKey(username) &&
                            AuthStore.users[username] == password) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Invalid Email/Mobile or Password!',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('LOGIN'),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create New Account? Register',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= REGISTRATION PAGE =================

class Register extends StatelessWidget {
  Register({super.key});

  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: mobile,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String fullName = name.text.trim();
                  String userEmail =
                      email.text.trim().toLowerCase();
                  String userMobile = mobile.text.trim();
                  String password = pass.text;

                  bool validEmail = RegExp(
                    r'^[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(userEmail);

                  bool validMobile = RegExp(
                    r'^(01[3-9]\d{8}|\+8801[3-9]\d{8})$',
                  ).hasMatch(userMobile);

                  if (fullName.isNotEmpty &&
                      validEmail &&
                      validMobile &&
                      password.length >= 6) {

                    if (AuthStore.users.containsKey(userEmail) ||
                        AuthStore.users.containsKey(userMobile)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Account already exists!'),
                        ),
                      );
                      return;
                    }

                    // Save account information
                    AuthStore.users[userEmail] = password;
                    AuthStore.users[userMobile] = password;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration Successful!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Return to login page
                    Navigator.pop(context);

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter valid details!',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('REGISTER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}