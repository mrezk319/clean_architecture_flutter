import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNum = 0});
  List<BookEntity> fetchNewBooks({int pageNum = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int pageNum = 0, int pageSize = 10}) {
    int startIndex = pageNum * pageSize;
    int endIndex = (pageNum + 1) * pageSize;
    var box = Hive.box<BookEntity>(KFeaturedBooks);
    try {
      List<BookEntity> allItems = box.values.toList();
      if (endIndex > allItems.length) {
        endIndex = allItems.length;
      }
      return allItems.sublist(startIndex, endIndex);
    } catch (e) {
      return [];
    }
  }

  @override
  List<BookEntity> fetchNewBooks({int pageNum = 0, int pageSize = 0}) {
    int startIndex = pageNum * pageSize;
    int endIndex = (pageNum + 1) * pageSize;
    var box = Hive.box<BookEntity>(KNewBooks);
    try {
      List<BookEntity> allItems = box.values.toList();
      if (endIndex > allItems.length) {
        endIndex = allItems.length;
      }
      return allItems.sublist(startIndex, endIndex);
    } catch (e) {
      return [];
    }
  }
}
