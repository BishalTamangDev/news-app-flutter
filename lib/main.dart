import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/constants.dart';
import 'package:news_app/widgets/news_card.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: false,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<StatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  _fetchTopNews() async {
    var url = Uri.parse(newsApiUrl);
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top News"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fetchTopNews(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("has data: ${snapshot.data}");
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...snapshot.data['articles'].map((e) => getNewsCard(e)),
                    // Text(snapshot.data['articles'].toString()),
                  ],
                ),
              );
            } else {
              print("has no data");

              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
