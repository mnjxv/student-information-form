import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController phoneField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  bool isVisible = false;

  @override
  void dispose() {
    emailField.dispose();
    phoneField.dispose();
    passwordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Student Information"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailField,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email Address",
                ),
                validator: (value) {
                  final text = value?.trim() ?? "";
                  if (text.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: phoneField,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Phone Number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number is required";
                  }
                  if (value.length != 11) {
                    return "Phone number must be exactly 11 digits";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordField,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  if (!value.contains(RegExp(r'[A-Z]'))) {
                    return "Must contain an uppercase letter";
                  }
                  if (!value.contains(RegExp(r'[a-z]'))) {
                    return "Must contain a lowercase letter";
                  }
                  if (!value.contains(RegExp(r'[0-9]'))) {
                    return "Must contain at least one number";
                  }
                  if (!value.contains(RegExp(r'[^a-zA-Z0-9]'))) {
                    return "Must contain a symbol";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text("Success"),
                          content: const Text("Submitted successfully"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
