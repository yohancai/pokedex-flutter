import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:pokedex/models/Pokemon.dart';

void main() {
  runApp(MyApp());
}

List<Pokemon> pokemon_list = [];
List<String> pokemonImage_list = [];
ScrollController _scrollController = ScrollController();
int offset = 20;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoading = true;

  @override
  void initState() {
    getPokemon(offset);

    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
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
          body: NotificationListener(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
              itemCount: pokemon_list.length,
              itemBuilder: (context, index) {
                return Container(

                  child: Column(
                    children: <Widget>[
                      Text(
                        pokemon_list[index].name,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      ),
                      if(pokemon_list[index].type == "fire") ... [
                        Container(
                          color: Colors.red,
                          width: 100,
                          height: 100,
                          child: Image.network(pokemonImage_list[index]),
                        ),
                      ]
                      else if(pokemon_list[index].type == "grass") ... [
                        Container(
                          color: Colors.lightGreen,
                          width: 100,
                          height: 100,
                          child: Image.network(pokemonImage_list[index]),
                        ),
                      ]
                      else if(pokemon_list[index].type == "water") ... [
                          Container(
                            color: Colors.blueAccent,
                            width: 100,
                            height: 100,
                            child: Image.network(pokemonImage_list[index]),
                          ),
                        ]
                      else if(pokemon_list[index].type == "normal") ... [
                          Container(
                            color: Colors.grey,
                            width: 100,
                            height: 100,
                            child: Image.network(pokemonImage_list[index]),
                          ),
                        ]
                      else if(pokemon_list[index].type == "flying") ... [
                          Container(
                            color: Colors.lightBlue,
                            width: 100,
                            height: 100,
                            child: Image.network(pokemonImage_list[index]),
                          ),
                        ]
                            else if(pokemon_list[index].type == "electric") ... [
                                Container(
                                  color: Colors.yellow,
                                  width: 100,
                                  height: 100,
                                  child: Image.network(pokemonImage_list[index]),
                                ),
                              ]
                              else if(pokemon_list[index].type == "ground") ... [
                                  Container(
                                    color: Colors.orangeAccent,
                                    width: 100,
                                    height: 100,
                                    child: Image.network(pokemonImage_list[index]),
                                  ),
                                ]
                                else if(pokemon_list[index].type == "fighting") ... [
                                    Container(
                                      color: Colors.deepOrange,
                                      width: 100,
                                      height: 100,
                                      child: Image.network(pokemonImage_list[index]),
                                    ),
                                  ]
                                  else if(pokemon_list[index].type == "psychic") ... [
                                      Container(
                                        color: Colors.purpleAccent,
                                        width: 100,
                                        height: 100,
                                        child: Image.network(pokemonImage_list[index]),
                                      ),
                                    ]
                                    else if(pokemon_list[index].type == "rock") ... [
                                        Container(
                                          color: Colors.brown,
                                          width: 100,
                                          height: 100,
                                          child: Image.network(pokemonImage_list[index]),
                                        ),
                                      ]
                                      else if(pokemon_list[index].type == "ice") ... [
                                          Container(
                                            color: Colors.blueGrey,
                                            width: 100,
                                            height: 100,
                                            child: Image.network(pokemonImage_list[index]),
                                          ),
                                        ]
                                        else if(pokemon_list[index].type == "ghost") ... [
                                            Container(
                                              color: Colors.deepPurple,
                                              width: 100,
                                              height: 100,
                                              child: Image.network(pokemonImage_list[index]),
                                            ),
                                          ]
                                          else if(pokemon_list[index].type == "dragon") ... [
                                              Container(
                                                color: Colors.deepPurpleAccent,
                                                width: 100,
                                                height: 100,
                                                child: Image.network(pokemonImage_list[index]),
                                              ),
                                            ]
                                            else if(pokemon_list[index].type == "dark") ... [
                                                Container(
                                                  color: Colors.black45,
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.network(pokemonImage_list[index]),
                                                ),
                                              ]
                                              else if(pokemon_list[index].type == "steel") ... [
                                                  Container(
                                                    color: Colors.blueGrey,
                                                    width: 100,
                                                    height: 100,
                                                    child: Image.network(pokemonImage_list[index]),
                                                  ),
                                                ]
                                                else if(pokemon_list[index].type == "fairy") ... [
                                                    Container(
                                                      color: Colors.pink,
                                                      width: 100,
                                                      height: 100,
                                                      child: Image.network(pokemonImage_list[index]),
                                                    ),
                                                  ]
                      else ... [
                        Container(
                          color: Colors.brown,
                          width: 100,
                          height: 100,
                          child: Image.network(pokemonImage_list[index]),
                        ),
                      ]

                    ],
                  ),
                );
              },
            ),
            onNotification: (end) {
              if (end is ScrollEndNotification) {
                offset = offset + 20;
                addPokemon(offset);
                Future.delayed(const Duration(milliseconds: 5000), () {
                  setState(() {
                    print("setstate");
                  });
                });
              }
              return true;
            },
          )
      ),
    );
  }

  Future<List<Pokemon>> getPokemon(int offset) async {
    var pokemonurl;
    pokemonImage_list.clear();
    pokemon_list.clear();
    for (int i = 1; i <= offset; i++) {
      pokemonImage_list.add(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png");
      pokemonurl = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
      var response = await http.get(
          pokemonurl
      );
      if (response.statusCode == 200) {
          String data = response.body;
          final parsedJson = convert.jsonDecode(data);
          final pokemon = Pokemon.fromJson(parsedJson);
          final type = typeFromJson(data);
          pokemon.type = type.types[0].type.name;
          pokemon_list.add(pokemon);
          print("Added " + pokemon.name);
      }
      else {
        print("response status code is " + response.statusCode.toString());
      }
    }
    return pokemon_list;
  }
  Future<List<Pokemon>> addPokemon(int offset) async {
    var url;
    for (int i = offset; i <= offset+20; i++) {
      pokemonImage_list.add(
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png");
      url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
      var response = await http.get(
          url
      );
      if (response.statusCode == 200) {
        String data = response.body;
        final parsedJson = convert.jsonDecode(data);
        final pokemon = Pokemon.fromJson(parsedJson);
        final type = typeFromJson(data);
        pokemon.type = type.types[0].type.name;
        pokemon_list.add(pokemon);
        print("Added " + pokemon.name);
      }
      else {
        print("response status code is " + response.statusCode.toString());
      }
    }
    return pokemon_list;
  }
}