import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manager/featured_books/featured_books_cubit.dart';
import 'package:bookly/Features/home/presentation/manager/new_books/new_book_cubit.dart';
import 'package:bookly/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'best_seller_list_view.dart';
import 'custom_app_bar.dart';
import 'featured_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: CustomAppBar()),
              FeaturedBookListBlocBuilder(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Best Seller',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: NewBookBlocBuilder(),
          ),
        ),
      ],
    );
  }
}

class NewBookBlocBuilder extends StatefulWidget {
  const NewBookBlocBuilder({
    super.key,
  });

  @override
  State<NewBookBlocBuilder> createState() => _NewBookBlocBuilderState();
}

class _NewBookBlocBuilderState extends State<NewBookBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewBookCubit, NewBookState>(
      listener: (context, state) {
        if (state is NewBookSuccess) {
          books.addAll(state.books);
        }
      },
      builder: (context, state) {
        if (state is NewBookSuccess || state is NewPaginationLoading) {
          return BestSellerListView(
            books: books,
          );
        } else if (state is NewBookFail) {
          return Text(state.message);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FeaturedBookListBlocBuilder extends StatefulWidget {
  const FeaturedBookListBlocBuilder({
    super.key,
  });

  @override
  State<FeaturedBookListBlocBuilder> createState() =>
      _FeaturedBookListBlocBuilderState();
}

class _FeaturedBookListBlocBuilderState
    extends State<FeaturedBookListBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedPaginationLoading) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is FeaturedBooksFail) {
          return Text(state.message);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      listener: (BuildContext context, FeaturedBooksState state) {
        if (state is FeaturedBooksSuccess) {
          books.addAll(state.books);
        }
      },
    );
  }
}
