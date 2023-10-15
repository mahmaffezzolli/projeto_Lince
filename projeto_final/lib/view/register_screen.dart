import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../entities/store.dart';
import '../storages/user_database.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundo,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: null,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
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
                    child: Inputs(
                      formKey: _formKey,
                      cnpjController: _cnpjController,
                      storeNameController: _storeNameController,
                      passwordController: _passwordController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Autonomy {
  final String label;
  const Autonomy(this.label);

  static const beginner = Autonomy('Beginner');
  static const intermediate = Autonomy('Intermediate');
  static const advanced = Autonomy('Advanced');
  static const special = Autonomy('Special');

  @override
  String toString() {
    return label;
  }
}

// ignore: must_be_immutable
class Inputs extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cnpjController;
  final TextEditingController storeNameController;
  final TextEditingController passwordController;

  Autonomy? selectedAutonomy;
  Inputs({
    required this.formKey,
    required this.cnpjController,
    required this.storeNameController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordVisibilityProvider =
        Provider.of<PasswordVisibilityProviderRegister>(context);

    final maskFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              "Cadastro",
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
                    controller: cnpjController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    inputFormatters: [maskFormatter],
                    decoration: const InputDecoration(
                      labelText: 'CNPJ',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90),
                      ),
                      icon: Icon(
                        Icons.text_snippet_sharp,
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
                  TextFormField(
                    controller: storeNameController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
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
                      } else if (value.length > 120) {
                        return 'O nome deve conter 120 caracters ou menos';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<Autonomy?>(
                    value: selectedAutonomy,
                    onChanged: (value) {
                      selectedAutonomy = value!;
                    },
                    items: [
                      for (final autonomy in [
                        Autonomy.beginner,
                        Autonomy.intermediate,
                        Autonomy.advanced,
                        Autonomy.special,
                      ])
                        DropdownMenuItem(
                          value: autonomy,
                          child: Text(
                            autonomy.label,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Autonomia',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 90, 90, 90),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 90, 90, 90),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 90, 90, 90), width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
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
                      suffixIcon: IconButton(
                        onPressed: () {
                          String randomPassword = generateRandomPassword();
                          passwordController.text = randomPassword;
                        },
                        icon: const Icon(
                          Icons.refresh, // Ícone de atualização
                          color: Color.fromARGB(255, 90, 90, 90),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final store = Store(
                            cnpj: cnpjController.text,
                            name: storeNameController.text,
                            password: passwordController.text,
                            autonomy: selectedAutonomy?.label ?? '',
                          );

                          final BuildContext currentContext = context;

                          try {
                            final storeController = StoreController();
                            await storeController.initDatabase();
                            await storeController.insert(store);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(currentContext).showSnackBar(
                              const SnackBar(
                                content: Text('Loja cadastrada com sucesso!'),
                              ),
                            );
                            cnpjController.clear();
                            storeNameController.clear();
                            passwordController.clear();
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(currentContext).showSnackBar(
                              SnackBar(
                                content: Text('Erro ao cadastrar a loja: $e'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: const Size(100, 40),
                        backgroundColor: const Color.fromRGBO(70, 130, 169, 1),
                      ),
                      child: const Text(
                        "Cadastrar loja",
                        style: TextStyle(fontSize: 14),
                      ),
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

class PasswordVisibilityProviderRegister extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}

String generateRandomPassword() {
  const String chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  Random random = Random();
  String password = "";

  for (int i = 0; i < 15; i++) {
    int randomIndex = random.nextInt(chars.length);
    password += chars[randomIndex];
  }

  return password;
}
