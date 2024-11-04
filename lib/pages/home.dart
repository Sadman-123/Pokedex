import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  TextEditingController pokecontroller = TextEditingController();
  bool isLoading = false;
  String? pokemonName;
  String? pokemonImageUrl;
  Future<void> getPokemon()
  async {
    if (pokecontroller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("Please Fill the Box"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              )
            ],
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/${pokecontroller.text.toLowerCase()}");
      var res = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        setState(() {
          pokemonName = data['name'];
          pokemonImageUrl = data['sprites']['front_default'];
          isLoading = false;
        });
        pokecontroller.clear();
        Navigator.pop(context);
      } else {
        throw Exception('Failed to load Pokémon');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: pokemonImageUrl != null
                        ? Image.network(pokemonImageUrl!,width: mdw*0.26,)
                        : Image.asset("assets/pic/pickachu.png"),
                  ),
                  Container(
                    child: Text(
                      pokemonName ?? "Welcome",
                      style: TextStyle(fontSize: mdw * 0.13),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Color(0xFFFFFFF0)
                                : Color(0xFF0D0D0D),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Search",
                                  style: TextStyle(fontSize: mdw * 0.084),
                                ),
                                SizedBox(height: mdh * 0.06),
                                Container(
                                  width: mdw * 0.77,
                                  child: TextField(
                                    controller: pokecontroller,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: mdw * 0.051,
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? Color(0xFF1E1E1E)
                                          : Color(0xFFFFFFF0),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Pokemon name",
                                    ),
                                  ),
                                ),
                                SizedBox(height: mdh * 0.018),
                                GestureDetector(
                                  onTap: getPokemon,
                                  child: Container(
                                    width: mdw * 0.44,
                                    height: mdh * 0.059,
                                    child: Center(
                                      child: isLoading
                                          ? CircularProgressIndicator(color: Colors.white)
                                          : Text(
                                        "SEARCH",
                                        style: TextStyle(
                                          fontSize: mdw * 0.05,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.indigoAccent,
                                          Colors.blue,
                                          Colors.blueAccent.shade200,
                                          Colors.blueAccent.shade700
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigoAccent,
                          Colors.blue,
                          Colors.blueAccent.shade200,
                          Colors.blueAccent.shade700
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    height: mdh * 0.069,
                    width: mdw * 0.6,
                    child: Center(
                      child: Text(
                        "Search Pokemon",
                        style: TextStyle(
                          fontSize: mdw * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
