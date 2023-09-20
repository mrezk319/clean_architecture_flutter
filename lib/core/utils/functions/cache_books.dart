import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

void saveData({required List<BookEntity> books, boxName}) {
  var box = Hive.box<BookEntity>(boxName);
  box.addAll(books);
}
