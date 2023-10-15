import 'package:flutter/material.dart';
import 'package:projeto_final/view/vehicle_year_photo_screen.dart';
import 'package:provider/provider.dart';
import '../repositories/vehicle_repositorie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class ManufacturePlateScreen extends StatefulWidget {
  const ManufacturePlateScreen({Key? key}) : super(key: key);

  @override
  _ManufacturePlateScreenState createState() => _ManufacturePlateScreenState();
}

class _ManufacturePlateScreenState extends State<ManufacturePlateScreen> {
  final TextEditingController _manufactureYearController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(
    mask: 'XXX-9999',
    filter: {"X": RegExp(r'[A-Za-z]'), "9": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _manufactureYearController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen(BuildContext context) {
    final vehicleYear = _manufactureYearController.text;
    final licensePlate = _plateController.text;

    if (vehicleYear.isNotEmpty && licensePlate.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VehicleYearPhotoScreen()));    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsAlignment: MainAxisAlignment.center,
            title: const Text('Error', style: TextStyle(color: Colors.black)),
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
    final vehicleProvider = Provider.of<VehicleProvider>(context);

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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Vehicle Registration',
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
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _manufactureYearController,
                        onChanged: (value) {
                          vehicleProvider.setManufactureYear(value);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Manufacture Year',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          _pickManufactureYear(context);
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _plateController,
                        inputFormatters: [maskFormatter],
                        decoration: const InputDecoration(
                          labelText: 'License Plate (e.g., ABC-1234)',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        onChanged: (value) {
                          // Convert the entered text to uppercase
                          _plateController.value =
                              _plateController.value.copyWith(
                            text: value.toUpperCase(),
                            selection: TextSelection(
                              baseOffset: value.length,
                              extentOffset: value.length,
                            ),
                            composing: TextRange.empty,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickManufactureYear(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _manufactureYearController.text = selectedDate.year.toString();
      });
    }
  }
}
