import 'package:flutter/material.dart';
import 'package:projeto_final/entities/store.dart';
import 'package:projeto_final/storages/user_database.dart';
import 'package:provider/provider.dart';

class StoreListProvider extends ChangeNotifier {
  List<Store> stores = [];

  StoreController userDatabase;

  StoreListProvider(this.userDatabase) {
    _loadStores();
  }

  void _loadStores() async {
    try {
      List<Store> loadedStores = await userDatabase.getAllStores();
      stores = loadedStores;
    } catch (e) {
      print("Erro ao carregar listagem: $e");
    }
  }

  void deleteStore(Store store) async {
    notifyListeners();
    await userDatabase.deleteStore(store.id!);

    final storeIndex = stores.indexWhere((s) => s.id == store.id);

    if (storeIndex != -1) {
      stores.removeAt(storeIndex);

      notifyListeners();
    }
    notifyListeners();
  }

  void updateStore(Store updatedStore) async {
    //await userDatabase.updateStore(store);
    final storeIndex =
        stores.indexWhere((store) => store.id == updatedStore.id);

    if (storeIndex != -1) {
      stores[storeIndex] = updatedStore;
      notifyListeners();
    }

  }
}
