import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../repositories/vehicle_repositorie.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class DocumentNameAndDatePriceScreen extends StatefulWidget {
  const DocumentNameAndDatePriceScreen({super.key});

  @override
  DocumentNameAndDatePriceScreenState createState() =>
      DocumentNameAndDatePriceScreenState();
}

class DocumentNameAndDatePriceScreenState
    extends State<DocumentNameAndDatePriceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();
  DateTime? _selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _purchaseDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    final vehicleProvider =
        Provider.of<VehicleProvider>(context, listen: false);
    final cnpj = _cnpjController.text;
    final name = _storeNameController.text;
    final price = _priceController.text;
    final purchaseDate = _purchaseDateController.text;

    if (cnpj.isNotEmpty &&
        name.isNotEmpty &&
        price.isNotEmpty &&
        purchaseDate.isNotEmpty) {
      Navigator.pushNamed(context, '/next_screen');
      vehicleProvider.reset();
      Navigator.popUntil(
        context,
        ModalRoute.withName("/model_brand"),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsAlignment: MainAxisAlignment.center,
            title: const Text('Erro', style: TextStyle(color: Colors.black)),
            backgroundColor: const Color.fromRGBO(255, 109, 96, 1),
            content: const Text(
              'Por favor, preencha todos os campos obrigatórios.',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 234, 221, 1),
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
  }

  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );

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
                    child: Center(
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
                                value: 0.4,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: _cnpjController,
                                      inputFormatters: [maskFormatter],
                                      decoration: const InputDecoration(
                                        labelText: 'CPF',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        icon: Icon(
                                          Icons.text_snippet_sharp,
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: _storeNameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nome do comprador',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        icon: Icon(
                                          Icons.person,
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: _priceController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      decoration: const InputDecoration(
                                        labelText: 'Preço pago pelo comprador',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        icon: Icon(
                                          Icons.price_check,
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: _purchaseDateController,
                                      readOnly: true,
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Data da venda',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color:
                                              Color.fromARGB(255, 90, 90, 90),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 90, 90, 90),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      _navigateToNextScreen(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
