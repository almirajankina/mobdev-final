import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fixInvalidUserDocuments() async {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final snapshot = await usersCollection.get();

  for (final doc in snapshot.docs) {
    dynamic rawData;

    try {
      rawData = doc.data();
    } catch (e) {
      print('❌ Ошибка при чтении ${doc.id}: $e');
      continue;
    }

    // Если данные — список (ошибочная структура)
    if (rawData is List) {
      print('⚠️ Документ ${doc.id} содержит List вместо Map. Исправляем...');

      Map<String, dynamic> fixedData = {};

      for (final item in rawData) {
        if (item is Map<String, dynamic>) {
          fixedData.addAll(item);
        } else {
          print('❌ Элемент внутри списка не является Map: $item');
        }
      }

      // Перезаписываем документ
      await usersCollection.doc(doc.id).set(fixedData);
      print('✅ Документ ${doc.id} исправлен');
    }

    // Если всё ок
    else if (rawData is Map<String, dynamic>) {
      print('✔️ Документ ${doc.id} в порядке');
    }

    // Иначе — неподдерживаемый тип
    else {
      print('❌ Документ ${doc.id} содержит неподдерживаемый тип: ${rawData.runtimeType}');
    }
  }

  print('🎉 Проверка и исправление завершены');
}
