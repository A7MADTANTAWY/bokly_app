import 'package:bloc/bloc.dart';
import 'package:bokly_app/features/home/data/models/book_model/item.dart';
import 'package:bokly_app/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepo) : super(SimilarBooksInitial());

  final HomeRepo homeRepo;

  Future<void> fetchSimilarBooks({required String category}) async {
    emit(SimilarBooksLoading());

    final result = await homeRepo.fetchSimilarBooks(category: category);

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(SimilarBooksFailure(errorMessage: failure.errorMessage));
        }
      },
      (books) {
        if (!isClosed) {
          emit(SimilarBooksSuccess(books: books));
        }
      },
    );
  }
}
