import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/functions/cache_books.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNum = 0});
  Future<List<BookEntity>> fetchNewBooks({int pageNum = 0});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNum = 0}) async {
    var data = await apiService.getData(
        endPoint:
            "volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNum * 10}");
    List<BookEntity> books = parseBooks(data);
    saveData(books: books, boxName: KFeaturedBooks);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewBooks({int pageNum = 0}) async {
    var data = await apiService.getData(
        endPoint:
            "volumes?Filtering=free-ebooks&q=programming&Sorting=newest&startIndex=${pageNum * 10}");
    List<BookEntity> books = parseBooks(data);
    saveData(books: books, boxName: KNewBooks);
    return books;
  }

  List<BookEntity> parseBooks(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var book in data['items']) {
      books.add(BookModel.fromJson(book));
    }
    return books;
  }
}
