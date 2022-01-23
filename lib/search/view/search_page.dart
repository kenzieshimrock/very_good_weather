import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

class SearchPage extends StatefulWidget {
  SearchPage._({Key? key}) : super(key: key);

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => SearchPage._());
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
        title: IntrinsicWidth(
          child: Row(
            children: [
              Image.asset(
                'assets/vgv_unicorn_filled.png',
                scale: 45,
              ),
              SizedBox(
                width: Sizing.standard,
              ),
              const Text('Very Good Search'),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizing.standard),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black,
                  autofocus: true,
                  controller: _textController,
                  onSubmitted: (_) => Navigator.of(context).pop(_text),
                  decoration: InputDecoration(
                    hintText: 'City Name',
                    hintStyle: TextStyle(fontSize: Sizing.standard),
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(width: 1.2, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              key: const Key('searchPage_search_iconButton'),
              icon: const Icon(Icons.search),
              onPressed: () {
                _textController.text.isNotEmpty
                    ? Navigator.of(context).pop(_text)
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.all(Sizing.standard),
                          content: Text(
                            'Search field cannot be blank.',
                            style: TextStyle(
                              fontSize: Sizing.standard,
                            ),
                          ),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
