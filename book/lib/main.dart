import 'package:book/controller/data/author/authoradd/authoradd_bloc.dart';
import 'package:book/controller/data/author/bloc/author_bloc.dart';
import 'package:book/controller/data/books/book_bloc.dart';
import 'package:book/controller/data/books/bookadd/bloc/book_add_bloc.dart';
import 'package:book/controller/data/books/bookedit/bloc/book_edit_bloc.dart';
import 'package:book/model/book.dart';
import 'package:book/screens/home/pages/book_add.dart';
import 'package:book/screens/home/pages/details.dart';
import 'package:book/screens/splash/splash.dart';
import 'package:book/screens/widget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const CustomBottomNavigationBar(),
    ),
    GoRoute(
      path: '/bookAdd',
      builder: (context, state) => AddBookPage(), 
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final book = state.extra as Book; 
        return BookDetailScreen(book: book); 
      },
    ),
  ],
);



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookBloc()),
        BlocProvider(create: (context) => AuthorBloc()),
        BlocProvider(create: (context) => AuthorAddBloc(),),
        BlocProvider(create: (context) => BookEditBloc(),),
        BlocProvider(create: (context) => AddBookBloc(),),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }
}
