import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._({Key? key}) : super(key: key);

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Very Good Search',
          style: TextStyle(fontSize: Sizing.medium),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizing.standard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizing.standard,
            ),
            Text(
              'Search for a city:',
              style: TextStyle(fontSize: Sizing.medium),
            ),
            SizedBox(
              height: Sizing.small,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 27, height: 1.2),
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: Colors.black,
                    cursorHeight: 27,
                    autofocus: true,
                    controller: _textController,
                    onSubmitted: (_) => Navigator.of(context).pop(_text),
                    decoration: InputDecoration(
                      hintText: 'City Name',
                      hintStyle: const TextStyle(fontSize: 25),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 1.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  key: const Key('searchPage_search_iconButton'),
                  icon: const Icon(Icons.search),
                  tooltip: 'search for city',
                  onPressed: () {
                    _textController.text.isNotEmpty
                        ? Navigator.of(context).pop(_text)
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 3),
                              padding: EdgeInsets.all(Sizing.standard),
                              content: Image.asset(
                                  'assets/unicorn_snackbar_black.png',
                                  scale: 4.5),
                            ),
                          );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
