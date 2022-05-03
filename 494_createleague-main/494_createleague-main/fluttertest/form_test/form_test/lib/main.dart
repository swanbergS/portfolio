import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("FormBuilder Basics"),
        ),
        body: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(name: 'name'),
              //RaisedButton(
              //  onPressed: () {},
              //  child: Text('Submit'),
              //),
              //RaisedButton(
              //  onPressed: () {
              //saving form data
              //    final nameData = _formKey.currentState?.fields['name']
              //        ?.value; //bracket has to be same as textfield key
              //    print(nameData);
              //  },
              //  child: Text('Enter name'),
              //),
              FormBuilderTextField(name: 'email'),
              //RaisedButton(
              //  onPressed: () {
              //saving form data
              //    final emailData = _formKey.currentState?.fields['email']
              //        ?.value; //bracket has to be same as textfield key
              //    print(emailData);
              //  },
              //  child: Text('Enter email'),
              //),
              RaisedButton(
                onPressed: () {
                  //saving form data
                  _formKey.currentState?.save();
                  final formData =
                      _formKey.currentState?.value; //all form values
                  print(formData);
                },
                //child: Text('save form data'),
                child: Text('continue'),
              ),
              //RaisedButton(
              //  onPressed: () {
              //saving form data
              //    final formData =
              //        _formKey.currentState?.value; //all form values
              //    print(formData);
              //  },
              //  child: Text('show form data'),
              //),
            ],
          ),
          //onChanged: () => print("Form has been changed"),
          //initialValue: {
          //  'textfield': 'This is my inital value',
          //},
        ),
      ),
    );
  }
}
