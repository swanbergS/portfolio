import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:core';
import 'dart:io' as IO;
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

//import 'package:audio_manager/audio_manager.dart';
//import 'package:flutter_audio_query/flutter_audio_query.dart';

/*dependencies with errors:
flutter_audio_query: ^0.3.5+6
  audio_manager: ^0.8.2
*
* */
//The testing version

Map stocks = {};
Map tickers = {};
Map names = {};
String s1 = '';
String s2 = '';
String s3 = '';
String s4 = '';
String s5 = '';
//for team vs opp
Map response_1 = {};
Map r1 = {}; //team 1
Map r2 = {}; //team 2
Map test = {'0': 'MSFT', '1': 'AAPL', '2': 'COM', '3': 'NKE', '4': 'STCK'};
Map test2 = {'0': 'SFC', '1': 'ABC', '2': 'DEC', '3': 'NKE', '4': 'LOK'};
Map p1 = {}; //portfolio 1
Map p2 = {}; //portfolio 2
Map po1 = {}; //points parallel to portfolio 1
Map po2 = {}; //points parallel to portfolio 2
String teamName = "";
String email = "";
int numTeam = 0;
DateTime date = DateTime.now();
String d2 = "";
String _currentSelectedValue = '';
int numMem = 0;
int id = 0;

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => ChooseLeagueType(),
      '/twoAndAHalf': (context) => resumeLeagueOptions(),
      '/third': (context) => CustomFormSetup(),
      '/fourth': (context) => JoinLeagueApp(),
      '/fifth': (context) => JoinSpecificLeague(),
      '/sixth': (context) => CreateLineupPage(),
      '/sixthAndAHalf': (context) => ChooseSharesPage(),
      '/seventh': (context) => _ViewLineupPageState(),
      '/tenth': (context) => teamvsOpp(),
      '/eleventh': (context) => ViewCurrentStandings(),
      '/twelfth': (context) => ViewRecord(),
      '/thirteenth': (context) => ProfilePicUploadPage(),
      '/fourteenth': (context) => ViewNewsPage(),
    },
  ));
  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    const testKey = Key('K');

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
    );
    return MaterialApp(
      title: 'Moolah Master',
      theme: ThemeData(
        // is not restarted.
        fontFamily: 'Bebas Neue',
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Image.asset(
              'assets/MoolahMasterLogo2.png',
              scale: 1.3,
            ),
          ),
          Container(
            child: Text(
              'Moolah Master',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Flexible(
              child: TextButton(
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 50.0, color: Colors.black),
                ),
                style: TextButton.styleFrom(
                  primary: Color.fromRGBO(1, 25, 54, 1.0),
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ),
          ),
        ])),
      ),
    );
  }
}

class ChooseLeagueType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bebas Neue',
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Spacer(),
            Center(
              child: Text(
                'Resume a current league, create a new league, or join a friend\'s league:',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/twoAndAHalf');
              },
              label: Image.asset(
                'assets/resumeButton.png',
                scale: 6,
                alignment: FractionalOffset.centerRight,
              ),
              icon: Text(
                'Resume League',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                minimumSize: Size(350, 100),
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              label: Image.asset(
                'assets/createButton.png',
                scale: 6,
              ),
              icon: Text(
                'Create League',
                style: TextStyle(fontSize: 50.0),
              ),
              style: TextButton.styleFrom(
                alignment: FractionalOffset.center,
                primary: Colors.white,
                minimumSize: Size(350, 100),
                backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/fourth');
              },
              label: Image.asset(
                'assets/joinButton.png',
                scale: 6,
              ),
              icon: Text(
                'Join League',
                style: TextStyle(fontSize: 50.0),
              ),
              style: TextButton.styleFrom(
                alignment: FractionalOffset.center,
                primary: Colors.white,
                minimumSize: Size(350, 100),
                backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class resumeLeagueOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Bebas Neue',
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                  'View Information about your current league and team:',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/seventh');
                },
                label: Image.asset(
                  'assets/viewStocksButton.png',
                  scale: 6,
                  alignment: FractionalOffset.centerRight,
                ),
                icon: Text(
                  'View Your Stock Choices',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  minimumSize: Size(335, 100),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/eleventh');
                },
                label: Image.asset(
                  'assets/viewStandingsButton.png',
                  scale: 6,
                  alignment: FractionalOffset.centerRight,
                ),
                icon: Text(
                  'View Current Standings',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  minimumSize: Size(335, 100),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/tenth');
                },
                label: Image.asset(
                  'assets/teamVsOppButton.png',
                  scale: 6,
                  alignment: FractionalOffset.centerRight,
                ),
                icon: Text(
                  'Team vs. Opp. Standings',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  minimumSize: Size(335, 100),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/twelfth');
                },
                label: Image.asset(
                  'assets/record.png',
                  scale: 6,
                  alignment: FractionalOffset.centerRight,
                ),
                icon: Text(
                  'View Your Team\'s Record',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  minimumSize: Size(335, 100),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/fourteenth');
                },
                label: Image.asset(
                  'assets/newsButton.png',
                  scale: 6,
                  alignment: FractionalOffset.centerRight,
                ),
                icon: Text(
                  'View Stockmarket News',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                  minimumSize: Size(335, 100),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomFormSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create League',
      theme: ThemeData(
          textTheme: GoogleFonts.bebasNeueTextTheme(
        Theme.of(context).textTheme,
      )),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(01, 19, 36, 20),
        body: MyCustomForm(),
      ),
      //home: createLeague(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _date = TextEditingController();
  String dropdownValue = 'CHOOSE NUMBER OF TEAM MEMBERS';

  @override
  Widget build(BuildContext context) {
    //Color color = Theme.of(context).primaryColor;
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

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          TextFormField(
            controller: _controller,
            style:
                TextStyle(color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
            decoration: InputDecoration(
              labelText: 'ENTER YOUR TEAM NAME',
              labelStyle: TextStyle(color: Colors.white, fontSize: 30),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0)),
              border: const OutlineInputBorder(),
            ),
          ),
          Spacer(),
          TextFormField(
            // The validator receives the text that the user has entered.
            style:
                TextStyle(color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
            decoration: InputDecoration(
              labelText: 'ENTER YOUR EMAIL',
              labelStyle: TextStyle(color: Colors.white, fontSize: 30),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0)),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value != null && !EmailValidator.validate(value)) {
                setState(() => email = value);
                return 'Enter a real email';
              }
              setState(() => email = value!);
              return null;
            },
          ),
          Spacer(),
          TextFormField(
              controller: _date,
              style: TextStyle(
                  color: Color.fromRGBO(239, 41, 23, 1), fontSize: 20),
              decoration: InputDecoration(
                labelText: 'ENTER THE NEXT MONDAY',
                labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0)),
                border: const OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? d1 = DateTime.now();
                date = (await showDatePicker(
                  context: context,
                  initialDate: d1,
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2023),
                ))!;
                setState(() => d2 = DateFormat('yyyy-MM-dd').format(date));
                _date.text = d2;
              }),
          Spacer(),
          TextButton(
            child: Text('Choose PFP (Optional)'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Color.fromRGBO(4, 119, 111, 1),
              minimumSize: Size(100, 50),
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, right: 15, left: 15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/thirteenth');
            },
          ),
          Spacer(),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Color.fromRGBO(239, 41, 23, 1)),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
              setState(() => numMem = int.parse(dropdownValue));
            },
            items: <String>['CHOOSE NUMBER OF TEAM MEMBERS', '2', '4', '6']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Spacer(),
          Row( children: [
            Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              width: 120,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(239, 41, 23, 1),
                  ),
                  //textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    setState(() => teamName = _controller.text);
                    Map response = {
                      'league': teamName.toString(),
                      'owner': email.toString(),
                      'capacity': numMem,
                      'startdate': d2.toString(),
                    };
                    sendData(response);
                    print(response);
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Creating your League')),
                    );*/
                  }
                },
                child: const Text('Submit League Data'),
              ),
            ),
          ),
            Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              width: 120,
              height: 50,
                //textStyle: TextStyle(fontSize: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(239, 41, 23, 1),
                  ),
                  //textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sixth');
                },
                child: const Text('Continue to Choose Lineup'),
              ),
            ),
          ),
            Spacer(),
          ]),
        ],
      ),
    );
  }
}

class JoinLeagueApp extends StatelessWidget {
  JoinLeagueApp(); //I had to make it not const so I could create these functions

  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> sendData(formData) async {
    final header = {
      'Api-Version': 'v2',
      'Ocp-Apim-Subscription-Key':
          'c7d04b42632847e4bd1a633c4e54a75d', //I think this is the same???
    };
    final response = await http.post(
        Uri.parse('https://csc494apimgmt.azure-api.net/league'),
        headers: header,
        body: json.encode(formData));
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const JoinLeagueScreen(),
        '/joinleague': (context) => const JoinLeagueScreen(),
      },
    );
  }
}

class JoinLeagueScreen extends StatelessWidget {
  const JoinLeagueScreen();

  final String leaguename =
      ""; // change this once we figure out how to get league name from the database

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      body: new Column(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 20),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: Text(
                          'Moolah Master',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(239, 41, 23, 1),
                            fontFamily: 'Bebas Neue',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 60),
                    child: Image.asset(
                      'assets/MoolahMasterLogo2.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: FormBuilderTextField(
                        name: 'joinedleague',
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Color.fromRGBO(239, 41, 23, 1),
                            fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'ENTER A TEAM NAME:',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0)),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Center(
                child: TextButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromRGBO(239, 41, 23, 1),
                    padding: EdgeInsets.only(
                        top: 20, bottom: 10, right: 35, left: 35),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sixth');
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class JoinSpecificLeague extends StatelessWidget {
  const JoinSpecificLeague();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a League"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text(
          'Join a Moolah Master League',
        ),
      ),
    );
  }
}

class CreateLineupPage extends StatefulWidget {
  @override
  State<CreateLineupPage> createState() => _CreateLineupPageState();
}

class _CreateLineupPageState extends State<CreateLineupPage> {
  String teamname = "Teamname"; // change once we get team names from API
  /**Created by: Sophia S Last Modified: 3/22/22 */
  @override
  void initState() {
    getStocks();
    super.initState();
  }

  /**Created by: Sophia S Last Modified: 3/24/22 */
  Future<void> getStocks() async {
    final header = {
      'Api-Version': 'v2',
      'Ocp-Apim-Subscription-Key': 'c7d04b42632847e4bd1a633c4e54a75d',
    };
    final response = await http.get(
        Uri.parse('https://csc494apimgmt.azure-api.net/league/stocks'),
        headers: header);
    setState(() => stocks = jsonDecode(response.body));
    map(stocks);
  }

  /**Created by: Sophia S Last Modified: 3/25/22 */
  Future<void> sendStocks() async {
    Map<String, String> bod = {
      's1': s1,
      's2': s2,
      's3': s3,
      's4': s4,
      's5': s5
    };
    final header = {
      'Api-Version': 'v2',
      'Ocp-Apim-Subscription-Key': 'c7d04b42632847e4bd1a633c4e54a75d',
    };
    //final response = await http.post(
    //    Uri.parse('https://csc494apimgmt.azure-api.net/league/stocks'),
    //    headers: header,
    //    body: json.encode(bod));
    print(bod);
  }

  /**Created by: Sophia S Last Modified: 3/24/22 */
  void map(Map map) {
    // Get all keys
    int key = 1;
    map['stocks'].elementAt(0).keys.forEach((keys) {
      setState(() => tickers['$key'] = '$keys');
      key += 1;
    });
    // Get all values
    key = 1;
    map['stocks'].elementAt(0).values.forEach((values) {
      setState(() => names['$key'] = '$values');
      key += 1;
    });
  }

  void set(String stock) {
    /**Created by: Sophia S Last Modified: 3/25/22 */
    //this sets the text in the row of boxes for the selected stocks
    if (s1 == '') {
      setState(() => s1 = stock);
    } else if (s2 == '') {
      setState(() => s2 = stock);
    } else if (s3 == '') {
      setState(() => s3 = stock);
    } else if (s4 == '') {
      setState(() => s4 = stock);
    } else {
      setState(() => s5 = stock);
    }
  }

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Choose Your Lineup!',
            style: TextStyle(fontFamily: 'Bebas Neue')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
            ),
            Text('${teamname}\'s current lineup:',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'bebas neue',
                  fontSize: 30,
                )),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 20),
            ),
            Row(
              // this is where the actual stocks are gonna be displayed
              // stocks
              children: [
                const Spacer(),
                Container(
                  width: 75,
                  height: 75,
                  color: Color.fromRGBO(239, 41, 23, 1),
                  child: Center(
                      child: Text(
                    '${s1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
                const Spacer(),
                Container(
                  width: 75,
                  height: 75,
                  color: Color.fromRGBO(239, 41, 23, 1),
                  child: Center(
                      child: Text(
                    '${s2}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
                const Spacer(),
                Container(
                  width: 75,
                  height: 75,
                  color: Color.fromRGBO(239, 41, 23, 1),
                  child: Center(
                      child: Text(
                    '${s3}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
                const Spacer(),
                Container(
                  width: 75,
                  height: 75,
                  color: Color.fromRGBO(239, 41, 23, 1),
                  child: Center(
                      child: Text(
                    '${s4}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
                const Spacer(),
                Container(
                  width: 75,
                  height: 75,
                  color: Color.fromRGBO(239, 41, 23, 1),
                  child: Center(
                      child: Text(
                    '${s5}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ),
                const Spacer(),
              ],
            ),
            Row(
              // delete buttons
              children: [
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                    ),
                    onPressed: () {
                      setState(() => s1 = '');
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                    ),
                    onPressed: () {
                      setState(() => s2 = '');
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                    ),
                    onPressed: () {
                      setState(() => s3 = '');
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                    ),
                    onPressed: () {
                      setState(() => s4 = '');
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 30,
                  width: 75,
                  child: TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                    ),
                    onPressed: () {
                      setState(() => s5 = '');
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
            ),
            const Text(
                "Tap the stocks from the selection below to add them to your lineup!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'bebas neue',
                    fontSize: 30)),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['1']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['1']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['2']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['2']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['3']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['3']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['4']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['4']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['5']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['5']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['6']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['6']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['7']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['7']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['8']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['8']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['9']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['9']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['10']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['10']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['11']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['11']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['12']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['12']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['13']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['13']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['14']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['14']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['15']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['15']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['16']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['16']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['17']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['17']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['18']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['18']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['19']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['19']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['20']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['20']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['21']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['21']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['22']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['22']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['23']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['23']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['24']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['24']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['25']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['25']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['26']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['26']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['27']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['27']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Row(children: [
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['28']}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['28']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['29']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['29']);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: TextButton(
                        child: Text(
                          "${tickers['30']}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Bebas Neue',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromRGBO(4, 119, 111, 1),
                        ),
                        onPressed: () {
                          set(tickers['30']);
                        },
                      ),
                    ),
                    const Spacer(),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
            ),
            Center(
              child: TextButton(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromRGBO(239, 41, 23, 1),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 10, right: 35, left: 35),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                onPressed: () async {
                  await sendStocks();
                  Navigator.pushNamed(context, '/eleventh');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseSharesPage extends StatefulWidget {
  @override
  State<ChooseSharesPage> createState() => ChooseSharesPageState();
}

class ChooseSharesPageState extends State<ChooseSharesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Choose amount of shares for your stocks',
            style: TextStyle(fontFamily: 'Bebas Neue')),
      ),
    );
  }
}

class _ViewLineupPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('View Your Lineup!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
            ),
            Text(
              'Your lineup:',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'bebas neue',
                fontSize: 30,
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              width: 350,
              color: Color.fromRGBO(239, 41, 23, 1),
              child: Center(
                child: Text(
                  'First Choice',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              width: 350,
              color: Color.fromRGBO(239, 41, 23, 1),
              child: Center(
                child: Text(
                  'Second Choice',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              width: 350,
              color: Color.fromRGBO(239, 41, 23, 1),
              child: Center(
                child: Text(
                  'Third Choice',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              width: 350,
              color: Color.fromRGBO(239, 41, 23, 1),
              child: Center(
                child: Text(
                  'Fourth Choice',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 100,
              width: 350,
              color: Color.fromRGBO(239, 41, 23, 1),
              child: Center(
                child: Text(
                  'Fifth Choice',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: 'Bebas Neue',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class ViewCurrentStandings extends StatefulWidget {
  @override
  State<ViewCurrentStandings> createState() => _ViewCurrentStandingsState();
}

class _ViewCurrentStandingsState extends State<ViewCurrentStandings> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('View Current League Standings',
            style: TextStyle(fontFamily: 'Bebas Neue')),
      ),
      body: Stack(
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 45),
            child: Text('Here is how your stocks are doing today:',
                style: TextStyle(
                  fontFamily: 'Bebas Neue',
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center),
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              Column(
                children: [
                  Spacer(),
                  Container(
                    width: 100,
                    height: 75,
                    color: Color.fromRGBO(239, 41, 23, 1),
                    child: Center(
                        child: Text(
                      'Stock',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 75,
                    color: Color.fromRGBO(239, 41, 23, 1),
                    child: Center(
                        child: Text(
                      'Stock',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 75,
                    color: Color.fromRGBO(239, 41, 23, 1),
                    child: Center(
                        child: Text(
                      'Stock',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 75,
                    color: Color.fromRGBO(239, 41, 23, 1),
                    child: Center(
                        child: Text(
                      'Stock',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 75,
                    color: Color.fromRGBO(239, 41, 23, 1),
                    child: Center(
                        child: Text(
                      'Stock',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Spacer(),
                  Container(
                    width: 175,
                    height: 75,
                    color: Color.fromRGBO(4, 119, 111, 1),
                    child: Center(
                        child: Text(
                      'Stockdata',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 175,
                    height: 75,
                    color: Color.fromRGBO(4, 119, 111, 1),
                    child: Center(
                        child: Text(
                      'Stockdata',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 175,
                    height: 75,
                    color: Color.fromRGBO(4, 119, 111, 1),
                    child: Center(
                        child: Text(
                      'Stockdata',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 175,
                    height: 75,
                    color: Color.fromRGBO(4, 119, 111, 1),
                    child: Center(
                        child: Text(
                      'Stockdata',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                  Container(
                    width: 175,
                    height: 75,
                    color: Color.fromRGBO(4, 119, 111, 1),
                    child: Center(
                        child: Text(
                      'Stockdata',
                      //will replace this with their stocks from the database when I figure out how
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class teamvsOpp extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team vs Opponent',
      theme: ThemeData(
          textTheme: GoogleFonts.bebasNeueTextTheme(
        Theme.of(context).textTheme,
      )),
      home: teamOpp(),
    );
  }
}

class teamOpp extends StatefulWidget {
  @override
  _teamOppState createState() => _teamOppState();
}

class _teamOppState extends State<teamOpp> {
  @override
  void initState() {
    //getMatchup();
    //dummyFunc(12);
    super.initState();
  }

  Future<void> getMatchup() async {
    //pass day instead
    final body = {"leagueID": "1", "week_number": "1", "teamID": "1"};
    final header = {
      'Api-Version': 'v2',
      'Ocp-Apim-Subscription-Key': 'c7d04b42632847e4bd1a633c4e54a75d',
    };
    final response = await http.post(
        Uri.parse(
            'https://csc494apimgmt.azure-api.net/league/league/matchup/stats'),
        headers: header,
        body: jsonEncode(body));
    //print(response.body);
    setState(() => response_1 = jsonDecode(response.body));
    //print(response_1);
    map(response_1);
  }

  void map(Map map) {
    // Get all keys
    map['team1'].forEach((keys, values) {
      setState(() => r1[keys] = values);
    });
    map['team2'].forEach((keys, values) {
      setState(() => r2[keys] = values);
    });
    setP(r1, r2);
  }

  void setP(Map map1, Map map2) {
    Map h1 = {};
    int index = 0;
    map1['stocks'].forEach((values) {
      h1['${index}'] = values;
      index += 1;
    });
    index = 0;
    h1.forEach((key, value) {
      Map values = value;
      values.forEach((key, value) {
        if (key == "ticker") {
          setState(() => p1['${index}'] = value);
        } else {
          setState(() => po1['${index}'] = value);
        }
        index += 1;
      });
    });
    index = 0;
    h1 = {};
    map2['stocks'].forEach((values) {
      h1['${index}'] = values;
      index += 1;
    });
    index = 0;
    h1.forEach((key, value) {
      Map values = value;
      values.forEach((key, value) {
        if (key == "ticker") {
          setState(() => p2['${index}'] = value);
        } else {
          setState(() => po2['${index}'] = value);
        }
        index += 1;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(03, 47, 32, 20),
        //appBar: AppBar(
        //  backgroundColor: Colors.transparent,
        //  title: const Text('Team vs Opponent'),
        //),
        body: pageBuild());
  }
}

class pageBuild extends StatefulWidget {
  @override
  pageBuildState createState() => pageBuildState();
}

class pageBuildState extends State<pageBuild> {
  @override
  void initState() {}

  void dummyFunc() {
    print("Date: ${date}");
    setState(() => date = DateTime(date.year, date.month, date.day + 1));
    print("Date: ${date}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(03, 47, 32, 20),
      body: ListView(
        children: [
          Center(
            child: Text(
              "${r1['team']} vs ${r2['team']}",
              style: TextStyle(
                  color: Color.fromARGB(215, 1, 185, 112), fontSize: 40),
            ),
          ),
          Center(
            child: ButtonTheme(
              minWidth: 200.0,
              height: 70,
              child: RaisedButton(
                color: Color.fromRGBO(239, 41, 23, 1),
                textColor: Color.fromRGBO(255, 255, 255, 1),
                onPressed: () {
                  dummyFunc();
                },
                child: Text(
                    'Click to increase date: \n${date.year}-${date.month}-${date.day}',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                //your team
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "${r1['team']}",
                    style: TextStyle(
                        color: Color.fromARGB(215, 1, 185, 112), fontSize: 30),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "Projected Points: ${r1['total_points']}",
                    style: TextStyle(
                        color: Color.fromRGBO(207, 255, 179, 1), fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "Team 1 portfolio: ",
                    style: TextStyle(
                        color: Color.fromRGBO(207, 255, 179, 1), fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test['0']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test['1']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test['2']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test['3']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test['4']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                ],
              ),
              Column(
                //opponent
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "${r2['team']}",
                    style: TextStyle(
                        color: Color.fromARGB(215, 1, 185, 112), fontSize: 30),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "Projected Points: ${r2['total_points']}",
                    style: TextStyle(
                        color: Color.fromRGBO(207, 255, 179, 1), fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Text(
                    "Team 2 portfolio:",
                    style: TextStyle(
                        color: Color.fromRGBO(207, 255, 179, 1), fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test2['0']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test2['1']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test2['2']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test2['3']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 70,
                    child: RaisedButton(
                      color: Color.fromRGBO(239, 41, 23, 1),
                      textColor: Color.fromRGBO(255, 255, 255, 1),
                      onPressed: () {},
                      child: Text('${test2['4']}',
                          style: TextStyle(
                              fontSize: 30)), //this will be stock ticker?
                    ),
                  ),
                ],
              ),
              /*Flexible(
                  child: SizedBox(
                      height: 100.0, width: 100.0, child: widgetBuild())),*/
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
          ),
        ],
      ),
    );
  }
}

class widgetBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(03, 47, 32, 20),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: p1.length,
            itemBuilder: (context, int itemIndex) {
              return ButtonTheme(
                minWidth: 200.0,
                height: 70,
                child: RaisedButton(
                  color: Color.fromRGBO(239, 41, 23, 1),
                  textColor: Color.fromRGBO(255, 255, 255, 1),
                  onPressed: () {},
                  child: Text('${p1.values.elementAt(itemIndex)}',
                      style:
                          TextStyle(fontSize: 30)), //this will be stock ticker?
                ),
              );
            }));
  }
}

class ViewRecord extends StatefulWidget {
  @override
  State<ViewRecord> createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  String teamname = 'Teamname';
  String wins = '5';
  String losses = '3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('View Your Team\'s Record',
            style: TextStyle(fontFamily: 'Bebas Neue')),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  child: Text('${teamname}\'s Win/Loss record',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bebas Neue',
                          fontSize: 30)),
                ),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Text('${teamname} has won ${wins} times',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bebas Neue',
                        fontSize: 30)),
              ),
            ),
            Image.asset('assets/winImage.png'),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Text('${teamname} has lost ${losses} times',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bebas Neue',
                        fontSize: 30)),
              ),
            ),
            Image.asset('assets/loss.png'),
          ],
        ),
      ),
    );
  }
}

class ProfilePicUploadPage extends StatefulWidget {
  const ProfilePicUploadPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ProfilePicUploadPageState createState() => _ProfilePicUploadPageState();
}

class _ProfilePicUploadPageState extends State<ProfilePicUploadPage> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    await _displayPickImageDialog(context!,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(IO.File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Profile Pic"),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _handlePreview();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _handlePreview(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: IconButton(
              icon: const BackButtonIcon(),
              color: Colors.red,
              tooltip: "Back",
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                // these are all optional but I'm leaving them in in case the user wants/needs to modify their pic
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ViewNewsPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: const BackButtonIcon(),
            color: Colors.red,
            tooltip: "Back",
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(01, 19, 36, 20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            const Spacer(),
            Text(
              'Here are some recent articles that may help you during gameplay.',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  _ViewNewsPageState createState() => _ViewNewsPageState();
}

class _ViewNewsPageState extends State<ViewNewsPage> {
  var client = http.Client();
  var headlines = ['', '', '', '', '', '', '', ''];
  var urls = ['', '', '', '', '', '', '', ''];

  fetchNews() async {
    //print("in fetchNews");
    String url = 'https://MMWebScraperAI.gomalley411.repl.co';
    try {
      //print("getting url");

      var response = await http.get(Uri.parse(url));
      //print(response.statusCode);
      var body = response.body;
      //print("Body: " + body);
      var i = jsonDecode(body);
      for (var n = 0; n < 8; n++) {
        //print("in for; " + i[n].toString());
        setState(() {
          headlines[n] = i[n]['headline'];
          urls[n] = i[n]['url'];
        });
      }
      //print(headlines);
      //print(urls);
      //print("Success");
    } finally {
      client.close();
    }
  }

  @override
  void initState() {
    super.initState(); // requesting to fetch before UI drawing starts
    fetchNews();
    build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: const Color.fromRGBO(01, 19, 36, 20),
      body: Center(
        child: Expanded(
          child: ListView(
            padding: const EdgeInsets.all(80),
            children: <Widget>[
              const Text(
                'Here are some recent articles that may help you during gameplay.',
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue'),
              ),
              const Spacer(),
              const Text(
                'Headlines taken from the New York Times.',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'Bebas Neue',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[0], forceSafariVC: false)},
                child: Text(
                  headlines[0],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[1], forceSafariVC: false)},
                child: Text(
                  headlines[1],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[2], forceSafariVC: false)},
                child: Text(
                  headlines[2],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[3], forceSafariVC: false)},
                child: Text(
                  headlines[3],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[4], forceSafariVC: false)},
                child: Text(
                  headlines[4],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[5], forceSafariVC: false)},
                child: Text(
                  headlines[5],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[6], forceSafariVC: false)},
                child: Text(
                  headlines[6],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(239, 41, 23, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async =>
                    {await launch(urls[7], forceSafariVC: false)},
                child: Text(
                  headlines[7],
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
