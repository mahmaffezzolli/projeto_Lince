import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../storages/user_database.dart';
import 'home_screen.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class PasswordVisibilityProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundo,
      ),
      home: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Positioned.fill(
              bottom: 90,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(246, 244, 235, 1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50),
                  ),
                ),
                child: const Inputs(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Inputs extends StatelessWidget {
  const Inputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 70,
                color: Color.fromRGBO(145, 200, 228, 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: usernameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90),
                      ),
                      icon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 90, 90, 90),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 90, 90, 90),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 90, 90, 90),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  PasswordField(passwordController: passwordController),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final storeController = StoreController();
                          final user = await storeController.getUser(
                            usernameController.text,
                            passwordController.text,
                          );

                          if (user != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Erro de Login"),
                                  content: const Text("Você não é cadastrado."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Fechar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        backgroundColor: const Color.fromRGBO(145, 200, 228, 1),
                      ),
                      child: const Text("Logar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordField({Key? key, required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordVisibilityProvider =
        Provider.of<PasswordVisibilityProvider>(context);

    return TextFormField(
      controller: passwordController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Senha',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 90, 90, 90),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        icon: GestureDetector(
          onTap: () {
            passwordVisibilityProvider.toggleVisibility();
          },
          child: Icon(
            passwordVisibilityProvider.isVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: const Color.fromARGB(255, 90, 90, 90),
          ),
        ),
      ),
      obscureText: !passwordVisibilityProvider.isVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
