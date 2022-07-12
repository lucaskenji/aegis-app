import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>{
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ]
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Type in an username...',
                          fillColor: Color(0xffd3d9e3),
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text('Search'),
                          style: ElevatedButton.styleFrom(minimumSize: Size(24, 56)),
                        )
                    ),
                  ],
                )
            ),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [],
                ),
            ),
          ],
        ),
      ),
    );
  }
}