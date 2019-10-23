import 'package:flutter/material.dart';
import './signuppage.dart';

//TODO make this a Stateful widget
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use WillPopScope to disable the back button to prevent the user from
    // going back to the splashscreen.
    return WillPopScope(
      onWillPop: (){ return Future.value(false); },
      child: Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Image.asset('assets/quizme-logo-banner.png')
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: TextFormField(
                  initialValue: '',
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'email',
                    labelText: 'email',
                    icon: Icon(Icons.email),
                    
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){ return null; },
                  onSaved: (value){},
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25, left: 10, right: 10),
                child: TextFormField(
                  initialValue: '',
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'password',
                    icon: Icon(Icons.lock),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value){ return null; },
                  onSaved: (value){},
                ),
              ),
              SizedBox(
                child: RaisedButton(
                    child: Text('Sign In'),
                    onPressed: (){},
                  ),
                  width: double.infinity,
                  height: 45,
              ),
              // InkWell allows us to create clickable text
              InkWell(
                // RichText widget allows us to style text in creative ways
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(text: 'Signup here!', style: TextStyle(color: Theme.of(context).hintColor)),
                      ],
                    ),
                  ),
                ),
                onTap: (){ Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                )); }
              ),
            ],
          ),
        ),
      ),
    );
  }
}