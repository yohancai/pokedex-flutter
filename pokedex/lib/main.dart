import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/specific_pokemon.dart';
import 'dart:convert' as convert;
import 'package:pokedex/models/pokemon.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;


void main() {
  runApp(const MyApp());
}

List<Pokemon> pokemonList = [];
List<Pokemon> allPokemon = [];
List<Pokemon> searchedPokemon = [];
ScrollController _scrollController = ScrollController();
int offset = 20;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoading = true;
  bool isSearching = false;

  @override
  void initState() {
    getPokemon(offset);
    getAllPokemon();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (isTop) {

        } else {
          offset = offset + 20;
          addPokemon(offset);
          setState(() {});
        }
      }
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: !isSearching ? const Text("Pokedex") : TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search Pokemon",
            hintStyle: TextStyle(color: Colors.white)
          ),
          onChanged: (query) async {
            pokemonList.clear();
            for(int i = 0; i < allPokemon.length; i++){
              if(allPokemon[i].name.toLowerCase().contains(query)){
                pokemonList.add(allPokemon[i]);
              }
            }
            setState(() {});
          },
        ),

        actions: <Widget> [
          isSearching ?
          IconButton(icon: const Icon(Icons.cancel), onPressed: (){
            getPokemon(offset).then((value) =>
                setState(() {
                  isSearching = false;
                })
            );

          }) :
          IconButton(icon: const Icon(Icons.search), onPressed: (){
            setState(() {
              isSearching = true;
            });
            // showSearch(context: context, delegate: SearchBehavior());
          }),
        ],
      ),
          body: NotificationListener(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    children: <Widget>[
                      if(pokemonList[index].type[0] == "fire") ... [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xfff08030),
                          ),
                          child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  pokemonList[index].name,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline5,
                                ),
                                Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Column(
                                        children: [
                                          for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                            Text(
                                              toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                          ]
                                        ],
                                      ),
                                      Image.network(pokemonList[index].image),
                                    ]

                                ),
                              ]
                          ),
                        ),
                      ]
                      else if(pokemonList[index].type[0] == "grass") ... [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Color(0xff78c850),
                          ),
                          child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  pokemonList[index].name,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline5,
                                ),
                                Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Column(
                                        children: [
                                          for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                            Text(
                                              toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                          ]
                                        ],
                                      ),
                                      Image.network(pokemonList[index].image),
                                    ]

                                ),
                              ]
                          ),
                        ),
                      ]
                      else if(pokemonList[index].type[0] == "water") ... [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xff6890f0),
                            ),
                            child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    pokemonList[index].name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline5,
                                  ),
                                  Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Column(
                                          children: [
                                            for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                              Text(
                                                toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6,
                                              )
                                            ]
                                          ],
                                        ),
                                        Image.network(pokemonList[index].image),
                                      ]

                                  ),
                                ]
                            ),
                          ),
                        ]
                      else if(pokemonList[index].type[0] == "normal") ... [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffa8a878),
                            ),
                            child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    pokemonList[index].name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline5,
                                  ),
                                  Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Column(
                                          children: [
                                            for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                              Text(
                                                toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6,
                                              )
                                            ]
                                          ],
                                        ),
                                        Image.network(pokemonList[index].image),
                                      ]

                                  ),
                                ]
                            ),
                          ),
                        ]
                      else if(pokemonList[index].type[0] == "flying") ... [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color(0xffc03028),
                            ),
                            child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    pokemonList[index].name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline5,
                                  ),
                                  Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Column(
                                          children: [
                                            for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                              Text(
                                                toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6,
                                              )
                                            ]
                                          ],
                                        ),
                                        Image.network(pokemonList[index].image),
                                      ]

                                  ),
                                ]
                            ),
                          ),
                        ]
                            else if(pokemonList[index].type[0] == "electric") ... [
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Color(0xfff8d030),
                                  ),
                                  child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          pokemonList[index].name,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                    Text(
                                                      toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline6,
                                                    )
                                                  ]
                                                ],
                                              ),
                                              Image.network(pokemonList[index].image),
                                            ]

                                        ),
                                      ]
                                  ),
                                ),
                              ]
                              else if(pokemonList[index].type[0] == "ground") ... [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: Color(0xffe0c068),
                                    ),
                                    child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            pokemonList[index].name,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          Row(
                                              children: [
                                                const SizedBox(width: 5),
                                                Column(
                                                  children: [
                                                    for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                      Text(
                                                        toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .headline6,
                                                      )
                                                    ]
                                                  ],
                                                ),
                                                Image.network(pokemonList[index].image),
                                              ]

                                          ),
                                        ]
                                    ),
                                  ),
                                ]
                                else if(pokemonList[index].type[0] == "fighting") ... [
                                    Container(
                                      width: 180,
                                      height: 180,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        color: Color(0xffc03028),
                                      ),
                                      child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Text(
                                              pokemonList[index].name,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            Row(
                                                children: [
                                                  const SizedBox(width: 5),
                                                  Column(
                                                    children: [
                                                      for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                        Text(
                                                          toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .headline6,
                                                        )
                                                      ]
                                                    ],
                                                  ),
                                                  Image.network(pokemonList[index].image),
                                                ]

                                            ),
                                          ]
                                      ),
                                    ),
                                  ]
                                  else if(pokemonList[index].type[0] == "psychic") ... [
                                      Container(
                                        width: 180,
                                        height: 180,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          color: Color(0xfff85888),
                                        ),
                                        child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Text(
                                                pokemonList[index].name,
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                              Row(
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                          Text(
                                                            toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .headline6,
                                                          )
                                                        ]
                                                      ],
                                                    ),
                                                    Image.network(pokemonList[index].image),
                                                  ]

                                              ),
                                            ]
                                        ),
                                      ),
                                    ]
                                    else if(pokemonList[index].type[0] == "rock") ... [
                                        Container(
                                          width: 180,
                                          height: 180,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: Color(0xffb8a038),
                                          ),
                                          child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                  pokemonList[index].name,
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                                Row(
                                                    children: [
                                                      const SizedBox(width: 5),
                                                      Column(
                                                        children: [
                                                          for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                            Text(
                                                              toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline6,
                                                            )
                                                          ]
                                                        ],
                                                      ),
                                                      Image.network(pokemonList[index].image),
                                                    ]

                                                ),
                                              ]
                                          ),
                                        ),
                                      ]
                                      else if(pokemonList[index].type[0] == "ice") ... [
                                          Container(
                                            width: 180,
                                            height: 180,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              ),
                                              color: Color(0xff98d8d8),
                                            ),
                                            child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    pokemonList[index].name,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  Row(
                                                      children: [
                                                        const SizedBox(width: 5),
                                                        Column(
                                                          children: [
                                                            for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                              Text(
                                                                toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .headline6,
                                                              )
                                                            ]
                                                          ],
                                                        ),
                                                        Image.network(pokemonList[index].image),
                                                      ]

                                                  ),
                                                ]
                                            ),
                                          ),
                                        ]
                                        else if(pokemonList[index].type[0] == "ghost") ... [
                                            Container(
                                              width: 180,
                                              height: 180,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                                color: Color(0xff705898),
                                              ),
                                              child: Column(
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      pokemonList[index].name,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                    Row(
                                                        children: [
                                                          const SizedBox(width: 5),
                                                          Column(
                                                            children: [
                                                              for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                Text(
                                                                  toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                  style: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .headline6,
                                                                )
                                                              ]
                                                            ],
                                                          ),
                                                          Image.network(pokemonList[index].image),
                                                        ]

                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ]
                                          else if(pokemonList[index].type[0] == "dragon") ... [
                                              Container(
                                                width: 180,
                                                height: 180,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                    bottomLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10),
                                                  ),
                                                  color: Color(0xff7038f8),
                                                ),
                                                child: Column(
                                                    children: [
                                                      const SizedBox(height: 10),
                                                      Text(
                                                        pokemonList[index].name,
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                      Row(
                                                          children: [
                                                            const SizedBox(width: 5),
                                                            Column(
                                                              children: [
                                                                for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                  Text(
                                                                    toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                    style: Theme
                                                                        .of(context)
                                                                        .textTheme
                                                                        .headline6,
                                                                  )
                                                                ]
                                                              ],
                                                            ),
                                                            Image.network(pokemonList[index].image),
                                                          ]

                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ]
                                            else if(pokemonList[index].type[0] == "dark") ... [
                                                Container(
                                                  width: 180,
                                                  height: 180,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                    color: Color(0xffa4928e),
                                                  ),
                                                  child: Column(
                                                      children: [
                                                        const SizedBox(height: 10),
                                                        Text(
                                                          pokemonList[index].name,
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .headline5,
                                                        ),
                                                        Row(
                                                            children: [
                                                              const SizedBox(width: 5),
                                                              Column(
                                                                children: [
                                                                  for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                    Text(
                                                                      toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                      style: Theme
                                                                          .of(context)
                                                                          .textTheme
                                                                          .headline6,
                                                                    )
                                                                  ]
                                                                ],
                                                              ),
                                                              Image.network(pokemonList[index].image),
                                                            ]

                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ]
                                              else if(pokemonList[index].type[0] == "steel") ... [
                                                  Container(
                                                    width: 180,
                                                    height: 180,
                                                    decoration: const BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                      ),
                                                      color: Color(0xffb8b8d0),
                                                    ),
                                                    child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          Text(
                                                            pokemonList[index].name,
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                          Row(
                                                              children: [
                                                                const SizedBox(width: 5),
                                                                Column(
                                                                  children: [
                                                                    for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                      Text(
                                                                        toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                        style: Theme
                                                                            .of(context)
                                                                            .textTheme
                                                                            .headline6,
                                                                      )
                                                                    ]
                                                                  ],
                                                                ),
                                                                Image.network(pokemonList[index].image),
                                                              ]

                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                ]
                                                else if(pokemonList[index].type[0] == "fairy") ... [
                                                    Container(
                                                      width: 180,
                                                      height: 180,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(10),
                                                          topRight: Radius.circular(10),
                                                          bottomLeft: Radius.circular(10),
                                                          bottomRight: Radius.circular(10),
                                                        ),
                                                        color: Color(0xffee99ac),
                                                      ),
                                                      child: Column(
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              pokemonList[index].name,
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                            ),
                                                            Row(
                                                                children: [
                                                                  const SizedBox(width: 5),
                                                                  Column(
                                                                    children: [
                                                                      for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                        Text(
                                                                          toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                          style: Theme
                                                                              .of(context)
                                                                              .textTheme
                                                                              .headline6,
                                                                        )
                                                                      ]
                                                                    ],
                                                                  ),
                                                                  Image.network(pokemonList[index].image),
                                                                ]

                                                            ),
                                                          ]
                                                      ),
                                                    ),
                                                  ]
                                                  else if(pokemonList[index].type[0] == "poison") ... [
                                                      Container(
                                                        width: 180,
                                                        height: 180,
                                                        decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(10),
                                                            topRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10),
                                                            bottomRight: Radius.circular(10),
                                                          ),
                                                          color: Color(0xff97598e),
                                                        ),
                                                        child: Column(
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Text(
                                                                pokemonList[index].name,
                                                                style: Theme
                                                                    .of(context)
                                                                    .textTheme
                                                                    .headline5,
                                                              ),
                                                              Row(
                                                                  children: [
                                                                    const SizedBox(width: 5),
                                                                    Column(
                                                                      children: [
                                                                        for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                          Text(
                                                                            toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                            style: Theme
                                                                                .of(context)
                                                                                .textTheme
                                                                                .headline6,
                                                                          )
                                                                        ]
                                                                      ],
                                                                    ),
                                                                    Image.network(pokemonList[index].image),
                                                                  ]

                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ]
                                                    else if(pokemonList[index].type[0] == "bug") ... [
                                                        Container(
                                                          width: 180,
                                                          height: 180,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              topRight: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                              bottomRight: Radius.circular(10),
                                                            ),
                                                            color: Color(0xffafb837),
                                                          ),
                                                          child: Column(
                                                              children: [
                                                                const SizedBox(height: 10),
                                                                Text(
                                                                  pokemonList[index].name,
                                                                  style: Theme
                                                                      .of(context)
                                                                      .textTheme
                                                                      .headline5,
                                                                ),
                                                                Row(
                                                                    children: [
                                                                      const SizedBox(width: 5),
                                                                      Column(
                                                                        children: [
                                                                          for(int i = 0; i < pokemonList[index].type.length; i++)...[
                                                                            Text(
                                                                              toBeginningOfSentenceCase(pokemonList[index].type[i]).toString(),
                                                                              style: Theme
                                                                                  .of(context)
                                                                                  .textTheme
                                                                                  .headline6,
                                                                            )
                                                                          ]
                                                                        ],
                                                                      ),
                                                                      Image.network(pokemonList[index].image),
                                                                    ]

                                                                ),
                                                              ]
                                                          ),
                                                        ),
                                                      ]
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpecificPokemon(pokemon: pokemonList[index])),
                    );
                  },
                );
              },
            ),

          )
      ),
    );
  }

  Future<List<Pokemon>> getPokemon(int offset) async {
    Uri pokemonurl;
    pokemonList.clear();
    for (int i = 1; i <= offset; i++) {
      pokemonurl = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
      var response = await http.get(
          pokemonurl
      );
      if (response.statusCode == 200) {
          String data = response.body;
          final parsedJson = convert.jsonDecode(data);
          final pokemon = Pokemon.fromJson(parsedJson);
          final type = typeFromJson(data);
          pokemon.name = toBeginningOfSentenceCase(pokemon.name).toString();
          for(int j = 0; j < type.types.length; j++){
            pokemon.type.add(type.types[j].type.name);
          }
          pokemon.image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png";
          pokemonList.add(pokemon);
      }
    }
    return pokemonList;
  }
  Future<List<Pokemon>> addPokemon(int offset) async {
    Uri url;
    for (int i = offset; i <= offset+20; i++) {
      url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
      var response = await http.get(
          url
      );
      if (response.statusCode == 200) {
        String data = response.body;
        final parsedJson = convert.jsonDecode(data);
        final pokemon = Pokemon.fromJson(parsedJson);
        final type = typeFromJson(data);
        pokemon.name = toBeginningOfSentenceCase(pokemon.name).toString();
        for(int j = 0; j < type.types.length; j++){
          pokemon.type.add(type.types[j].type.name);
        }
        pokemon.image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png";
        pokemonList.add(pokemon);
      }
    }
    return pokemonList;
  }
  Future<List<Pokemon>> getAllPokemon() async {
    Uri url;
    for (int i = 1; i <= 1000; i++) {
      url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$i/");
      var response = await http.get(
          url
      );
      if (response.statusCode == 200) {
        String data = response.body;
        final parsedJson = convert.jsonDecode(data);
        final pokemon = Pokemon.fromJson(parsedJson);
        final type = typeFromJson(data);
        pokemon.name = toBeginningOfSentenceCase(pokemon.name).toString();
        for(int j = 0; j < type.types.length; j++){
          pokemon.type.add(type.types[j].type.name);
        }
        pokemon.image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png";
        allPokemon.add(pokemon);
      }
    }
    return pokemonList;
  }
}
