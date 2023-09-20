part of 'new_book_cubit.dart';

@immutable
abstract class NewBookState {}

class NewBookInitial extends NewBookState {}

class NewBookLoading extends NewBookState {}

class NewPaginationLoading extends NewBookState {}

class NewBookSuccess extends NewBookState {
  final List<BookEntity> books;

  NewBookSuccess(this.books);
}

class NewBookFail extends NewBookState {
  final String message;

  NewBookFail(this.message);
}
