import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchController = TextEditingController();
  bool isSong = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0
          )
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back)
        ),
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: isSong ? 'Search song...' : 'Search library...',
            hintStyle: const TextStyle(color: Colors.black54),
            border: InputBorder.none,
            suffixIcon: searchController.text.isNotEmpty 
              ? IconButton(
                  onPressed: () => searchController.clear(), 
                  icon: const Icon(Icons.clear)
                ) 
              : null
          ),
          onChanged: (value) {
            if (isSong) {

            } else {

            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() { isSong = !isSong; }),
            icon: isSong ? Icon(Icons.lyrics_outlined) : Icon(Icons.folder_outlined),
          ),
          SizedBox(width: 8,),
        ],
      ),
      body: const Center(child: Text('Search'),),
    );
  }
}