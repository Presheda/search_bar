import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search bar"),
        actions: <Widget>[
         IconButton(
            icon: Icon(Icons.search, ),
           onPressed: (){
           showSearch(context: context, delegate: DataSearch()).
           then((value) => print(value));
           },
         ),
          SizedBox(
            width: 4,
          )
        ],
      ),
      body: Center(
        child: Text("Regular Text Here",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }


}

class DataSearch extends SearchDelegate<String>{



  final cities = [
    "Bhandup",
    "Mumbai",
    "Visakhaptnam",
    "Coinbatore",
    "Delhi",
    "Bangalore",
    "Pune",
    "Nagpur",
    "Lucknow",
    "Vadodara",
    "Indore",
    "Jalalpur",
    "Bhopal",
    "Kolkata",
    "Kanpur",
    "New Delhi",
    "Fardabad",
    "Rajkot",
    "Ghaziabad",
    "Chennai",
    "Meerut",
    "Agra",
    "Jaipur",
    "Jabalpur",
    "Varanasi",
    "Allahabad",
    "Hyderabad",
    "Noida",
    "Howrah",
    "Thane"

  ];
  final recentCities = [
    "Meerut",
    "Agra",
    "Lucknow",
    "Noida",
  ];




  @override
  ThemeData appBarTheme(BuildContext context) {

    return ThemeData(
      primaryColorDark: Colors.blue,
      primaryTextTheme: TextTheme(

      )

    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),
        onPressed: (){
        query = "";
        },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }


  @override
  void showResults(BuildContext context) {

    super.showResults(context);

    showDialog(
        context:context,
      builder: (c)=> AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(
            ),
            SizedBox(
              width: 20,
            ),

            Text("Loading", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {



    return Center();
  }




  @override
  String get searchFieldLabel => "Location";

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty?recentCities:
    cities.where((element) => element.toLowerCase()
        .startsWith(query.toLowerCase())).toList();

    return ListView.builder(
        itemBuilder:(c,i){
         return ListTile(
           onTap: (){
            // close(context, suggestionList[i]);
             query = suggestionList[i];
             showResults(context);
           },
            leading: Icon(Icons.location_city),
           title: RichText(text: TextSpan(
             text: suggestionList[i].substring(0, query.length),
                 style: TextStyle(color : Colors.black,
                     fontWeight: FontWeight.bold),
             children: [
               TextSpan(
                 text: suggestionList[i].substring(query.length),
                 style: TextStyle(color: Colors.grey)
               )
             ]
           )),
          );

        }, 
        itemCount: suggestionList.length,
    );
  }

}

