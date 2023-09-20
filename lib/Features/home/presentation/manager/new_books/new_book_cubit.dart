import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_news_book_use_case.dart';
import 'package:meta/meta.dart';
part 'new_book_state.dart';

class NewBookCubit extends Cubit<NewBookState> {
  NewBookCubit(this.fetchNewBooksUseCase) : super(NewBookInitial());
  final FetchNewBooksUseCase fetchNewBooksUseCase;
  Future<void> fetchNewBooks({int pageNum = 0}) async {
    if (pageNum == 0) {
      emit(NewBookLoading());
    } else {
      emit(NewPaginationLoading());
    }
    var result = await fetchNewBooksUseCase.execute(pageNum);
    result.fold((l) {
      emit(NewBookFail(l.toString()));
    }, (r) {
      emit(NewBookSuccess(r));
    });
  }
}
