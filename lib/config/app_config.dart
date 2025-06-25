import 'package:feed/views/ask_question.dart';
import 'package:feed/views/share_expe/exp_share_page.dart';
import 'package:feed/views/home_page.dart';
import 'package:feed/views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppConfig {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(
        path: '/share-experience',
        builder: (context, state) => const ShareExperiencePage(),
      ),
      GoRoute(
        path: '/ask-question',
        builder: (context, state) => const AskQuestionPage(),
      ),
      GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
    ],
  );

  static ThemeData get theme =>
      ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto');
}
