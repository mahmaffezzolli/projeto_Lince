import 'package:flutter/material.dart';

import '../entities/store.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Store store;

  const StoreDetailsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('CNPJ: ${store.cnpj}'),
          Text('Autonomia: ${store.autonomy}'),
        ],
      ),
    );
  }
}
