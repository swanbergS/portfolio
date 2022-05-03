import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:core';

void main() {
  runApp(MyApp());
}

/**Sophia Swanberg Last Modified: 3/3/22 */
class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      //padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Moolah Master',
                    style: TextStyle(
                        fontSize: 50, color: Color.fromRGBO(239, 41, 23, 1)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Future<void> sendData(formData) async {
      final header = {
        'Api-Version': 'v2',
        'Ocp-Apim-Subscription-Key': 'c7d04b42632847e4bd1a633c4e54a75d',
      };
      final response = await http.post(
          Uri.parse('https://csc494apimgmt.azure-api.net/league'),
          headers: header,
          body: json.encode(formData));
      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create League',
      theme: ThemeData(
          textTheme: GoogleFonts.bebasNeueTextTheme(
        Theme.of(context).textTheme,
      )),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(01, 19, 36, 20),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Create Your League!'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                titleSection,
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                FormBuilderTextField(
                  name: 'league', //{'name': Sophia}
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'ENTER YOUR TEAM NAME',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 0.0)),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                FormBuilderTextField(
                  name: 'owner', //{'email': email@email.com}
                  style: TextStyle(
                      color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'ENTER EMAIL',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 0.0)),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                FormBuilderDropdown(
                  name: 'capacity',
                  style: TextStyle(
                      color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'NUMBER OF TEAM MEMBERS',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 0.0)),
                    border: const OutlineInputBorder(),
                  ),
                  items: ['4', '6', '8']
                      .map((val) => DropdownMenuItem(
                            value: val,
                            child: Text('$val'),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                /*FormBuilderDropdown(
                name: 'league',
                decoration: InputDecoration(labelText: 'LEAGUE TYPE'),
                items: ['Basic League', 'Advanced League']
                    .map((val) => DropdownMenuItem(
                          value: val,
                          child: Text('$val'),
                        ))
                    .toList(),
              ),*/
                ButtonTheme(
                  minWidth: 200.0,
                  height: 70,
                  child: RaisedButton(
                    color: Color.fromRGBO(239, 41, 23, 1),
                    textColor: Colors.white,

                    onPressed: () async {
                      //saving form data
                      _formKey.currentState?.save();
                      final formData =
                          _formKey.currentState?.value; //all form values
                      print(
                          formData); //{'name': Sophia, 'email': email@email.com, 'number': 8 members, 'league': Basic League}
                      sendData(formData);
                    }, //FUCK YEAH BABY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    child: Text('continue', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
