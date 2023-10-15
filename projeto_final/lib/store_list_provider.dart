import 'package:flutter/material.dart';
import 'package:projeto_final/entities/store.dart';
import 'package:projeto_final/storages/user_database.dart';

class StoreListProvider extends ChangeNotifier {
  List<Store> stores = [];

  StoreController userDatabase;

  StoreListProvider(this.userDatabase) {
    loadStores();
  }





   Future<List<Store>> loadStores() async {
    try {
      List<Store> loadedStores = await userDatabase.getAllStores();
      stores = loadedStores;
      return loadedStores;
    } catch (e) {
      throw e;
    }
  }

  void deleteStore(Store store) async {
    final storeIndex = stores.indexWhere((s) => s.id == store.id);

    if (storeIndex != -1) {
      await userDatabase.deleteStore(store.id!);
      stores.removeAt(storeIndex);
      notifyListeners();
      userDatabase.getAllStores();
    }
  }

  void updateStore(Store store) async {
    await userDatabase.updateStore(store);
    final storeIndex =
    stores.indexWhere((storeUpdated) => storeUpdated.id == store.id);

    if (storeIndex != -1) {
      stores[storeIndex] = store;
      userDatabase.getAllStores();
      notifyListeners();
    }
  }
}
