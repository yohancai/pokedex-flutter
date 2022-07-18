import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:pokedex/models/Pokemon.dart';

void main() {
  runApp(MyApp());
}

List<Pokemon> pokemon_list = [];
List<String> pokemonImage_list = [];

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoading = true;

  @override
  void initState() {
    getPokemon();

    Future.delayed(const Duration(milliseconds: 5000), (){
      setState(() {
        isLoading = false;
        print("setstate");
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
        title: Text("Pokedex"),
        ),
    body: isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    ): GridView.count(
      crossAxisCount: 2,
      children: List.generate(20, (index) {
        return Center(
          child: Column(
            children: <Widget> [

              Text(
                pokemon_list[index].name,
                style: Theme.of(context).textTheme.headline5,
              ),
              Container(
                width: 100,
                height: 100,
                child: Image.network(pokemonImage_list[index]),
              ),
            ],
          ),
        );
      }),
    ),
    )
    );
  }
}

void getPokemon() async {
  var url;
  for(int i = 1; i <= 20; i++){
    pokemonImage_list.add("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png");
    url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
    var response = await http.get(
        url
    );
    if(response.statusCode == 200){
      String data = response.body;
      final parsedJson = convert.jsonDecode(data);
      final pokemon = Pokemon.fromJson(parsedJson);
      print(pokemon.name);
      pokemon_list.add(pokemon);
      print("THIS QUERY = "+pokemon_list[i-1].name+" SUCCESS");
    }
    else{
      print("response status code is " + response.statusCode.toString());
    }

  }
}