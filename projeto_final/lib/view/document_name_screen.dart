import 'package:flutter/material.dart';
import 'package:projeto_final/view/date_price_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_final/view/home_screen.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class DocumentName extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();

  DocumentName({Key? key}) : super(key: key);

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
                      cnpjController: _cpfController,
                      storeNameController: _storeNameController,
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

class Inputs extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cnpjController;
  final TextEditingController storeNameController;

  const Inputs({
    required this.formKey,
    required this.cnpjController,
    required this.storeNameController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Cadastrar venda',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: const LinearProgressIndicator(
                value: 0.2,
                backgroundColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
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
                        labelText: 'CPF',
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
                    ),
                    TextFormField(
                      controller: storeNameController,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nome do comprador',
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, color: Colors.black),
                    onPressed: () {
                      final cnpj = cnpjController.text;
                      final name = storeNameController.text;

                      if (cnpj.isNotEmpty && name.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DatePrice()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              icon: const Icon(Icons.error_outline_outlined),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              title: const Text('Error'),
                              backgroundColor:
                                  const Color.fromRGBO(255, 109, 96, 1),
                              content: const Text(
                                'Por favor informe os campos ',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(255, 234, 221, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
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
