import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_news_book_use_case.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl());

  getIt.registerSingleton<HomeRemoteDataSource>(
      HomeRemoteDataSourceImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>()));

  getIt.registerSingleton<FetchFeaturedBooksUseCase>(
      FetchFeaturedBooksUseCase(getIt.get<HomeRepo>()));

  getIt.registerSingleton<FetchNewBooksUseCase>(
      FetchNewBooksUseCase(getIt.get<HomeRepo>()));
}
