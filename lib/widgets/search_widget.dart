import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {


  List<dynamic> Suggestions =[];

  Search({this.Suggestions});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query='';
          },
          icon: Icon(Icons.cancel)
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (){
          close(context, "");
        },
        icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<dynamic> matchFruit= [];
    // for( var fruit in Fruits){
    //   if(fruit.toUpperCase().contains(query.toUpperCase()))
    //     matchFruit.add(fruit);
    // }
    if(query != '')
      Suggestions.add(query);

    matchFruit = Suggestions.where(
            (fruit) => fruit.toUpperCase().contains(query.toUpperCase())
    ).toList();

    // if(query != '')
    //   close(context, query);
    // ///notthing happen
    return
      ListView.builder(
        itemCount: matchFruit.length,
        itemBuilder: (context, index) {
          var result = matchFruit[index];
          return ListTile(
            title: Text(result , style: TextStyle(fontSize: 20, color: Colors.deepOrange),),
            onTap: (){
              query = result;
              close(context, query);
            },
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<dynamic> matchFruit = [];
    // for(var fruit in Fruits) {
    //   if(fruit.toUpperCase().contains(query.toUpperCase())) {
    //     matchFruit.add(fruit);
    //   }
    // }

    matchFruit = Suggestions.where(
            (fruit) => fruit.toUpperCase().contains(query.toUpperCase())
    ).toList();
    return ListView.builder(
        itemCount: matchFruit.length,
        itemBuilder: (context, index) {
          var result = matchFruit[index];
          return ListTile(
            title: Text(result, style: TextStyle(fontSize: 20, color: Colors.green),),
            onTap: () {
              query = result;
              close(context, query);
            },
          );
        });
  }


}
