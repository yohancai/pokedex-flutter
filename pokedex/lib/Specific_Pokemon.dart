import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class SpecificPokemon extends StatefulWidget {
  final Pokemon pokemon;
  const SpecificPokemon({super.key, required this.pokemon});

  @override
  State<SpecificPokemon> createState() => _SpecificPokemonState();
}

class _SpecificPokemonState extends State<SpecificPokemon> {

  bool isLoading = true;
  Pokemon pokemon = Pokemon("");

  @override
  void initState() {
    pokemon = widget.pokemon;
    pokemon.name = toBeginningOfSentenceCase(pokemon.name).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: const Text("Pokedex"),
      ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 300,
                    child: Image.network(pokemon.image, fit: BoxFit.fill),
                  ),
                  Text(
                    pokemon.name,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3,
                  ),
                ]
            ),
          ),
      ),
    );
  }
}