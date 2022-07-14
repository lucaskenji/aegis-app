import 'package:aegis_app/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class SearchScreen extends StatefulWidget{
  final List<User> _users;
  final List<User> _usersFollowing;
  final Function _addPost;

  SearchScreen(this._users, this._usersFollowing, this._addPost);

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>{
  final TextEditingController _searchController = TextEditingController();
  late List<User> _users = [...widget._users];

  void _filterUsers(){
    setState(() {
      // Using toLowerCase to make a case insensitive search.
      _users = [...widget._users].where((user) {
        return user.username.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

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
                          onPressed: _filterUsers,
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
                children: _users.map((user) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return PostsScreen(user, widget._usersFollowing, false, widget._addPost);
                      }));
                    },
                    child: Container(
                      color: Color(0xffd3d9e3),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                          user.username,
                          style: TextStyle(fontSize: 20)
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}