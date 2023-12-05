import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
import 'user.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(

        children: [

          SignInForm(),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  final formKey = GlobalKey<FormState>();

  TextEditingController passwordControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();

  bool loginError = false;

  @override
  Widget build(BuildContext context) {
    return Form(

      key: formKey,

      child: Column(

        children: [

          TextFormField(

            decoration: InputDecoration(

              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              border: OutlineInputBorder(),
            ),

            controller: emailControl,

            validator: (val){

              if(val!.isEmpty){

                return "Please enter an email";
              }

              return null;
            },
          ),

          TextFormField(

            decoration: InputDecoration(

              prefixIcon: Icon(Icons.password),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),

            controller: passwordControl,

            validator: (val){

              if (val!.isEmpty){ //"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"

                return "Please enter a password";
              }

              return null;
            },
            obscureText: true,
          ),

          ElevatedButton(

            onPressed: (){

              if(formKey.currentState!.validate()){

                formKey.currentState!.save();
                getUser(emailControl.text, passwordControl.text).then((login){

                  if (login){

                    Navigator.push(context,

                        MaterialPageRoute(builder: (context) => RoutePage())
                    );
                  }else{

                    setState(() {

                      loginError = true;
                    });
                  }
                });
              }
            },
            child: Text("Sign In"),
          ),

          loginError ? Text("Incorret Email or Password") : Container(),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 30,),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                GestureDetector(

                  child: Text("Don't have an account? \nRegister now.",

                    style: TextStyle(

                      color: Colors.lightBlue,
                    ),
                  ),

                  onTap: (){

                    Navigator.push(context,

                        MaterialPageRoute(builder: (context) => SignUpPage())
                    );
                  },
                ),

                GestureDetector(

                  child: Text("Forgot login?",

                    style: TextStyle(

                      color: Colors.lightBlue,
                    ),
                  ),

                  onTap: (){},
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Future<bool> getUser(String email, String password) async {

    try{

      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    }catch(e){

      print(e);
      return false;
    }

    return true;
  }


}

