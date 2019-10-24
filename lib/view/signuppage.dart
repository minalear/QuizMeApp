import 'package:flutter/material.dart';
import '../controller/signuppage_controller.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  SignUpPageController controller;
  var formKey = GlobalKey<FormState>();

  SignUpPageState() {
    controller = SignUpPageController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Form (
        key: formKey,
        child: ListView(
          children: <Widget>[
            TextFormField( 
              initialValue: '',
              autocorrect:  false,
              decoration: InputDecoration(
                hintText: 'email',
                labelText:  'email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            TextFormField( 
              initialValue: '',
              autocorrect:  false,
              decoration: InputDecoration(
                hintText: 'username',
                labelText:  'username',
              ),
              keyboardType: TextInputType.text,
              validator: controller.validateUserName,
              onSaved: controller.saveUserName,
            ),
            TextFormField( 
              initialValue: '',
              autocorrect:  false,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                labelText:  'password',
              ),
              keyboardType: TextInputType.text,
              validator: controller.validatePassword,
              onSaved: controller.savePassword,
            ),
            RaisedButton(
              child: Text('Create Account'),
              onPressed: controller.createAccount,
            ),
          ],
        ),
      ),
    );
  }

}