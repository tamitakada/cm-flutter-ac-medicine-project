import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'user_information.dart';
import 'route.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(

        children: [

          SignUpForm(),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();

}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;

  bool agreed = false;

  TextEditingController passwordControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();

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

            onSaved: (val) {
              email = val;
            },
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter an email";
              }

              return null;
            },
          ),

          TextFormField(

            controller: passwordControl,

            decoration: InputDecoration(

              prefixIcon: Icon(Icons.password),
              labelText: "Password",
              border: OutlineInputBorder(),
            ),

            onSaved: (val) {
              password = val;
            },
            validator: (val) {
              if (val!.isEmpty) { //"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"

                return "Please enter a password";
              }

              return null;
            },
            obscureText: true,
          ),

          TextFormField(

            decoration: InputDecoration(

              prefixIcon: Icon(Icons.password),
              labelText: "Re-enter the password",
              border: OutlineInputBorder(),
            ),

            onSaved: (val) {
              confirmPassword = val;
            },
            validator: (val) {
              if (val!.isEmpty) { //"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"

                return "Please re-enter the password";
              }

              return null;
            },
            obscureText: true,
          ),

          Padding(

            padding: EdgeInsets.only(right: 5),

            child: Row(

              children: [

                Checkbox(

                  value: agreed,
                  onChanged: (_){

                    setState(() {

                      agreed = !agreed;
                    });
                  },
                ),

                Expanded(

                  child: Text("I agree to the Terms & Conditions and the Privacy Policy."),
                ),
              ],
            ),
          ),

          ElevatedButton(

            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                createUser(emailControl.text, passwordControl.text);
                Navigator.push(context,

                    MaterialPageRoute(builder: (context) => UserInformation(email: emailControl.text,)
                    )
                );
              }
            },

            child: Text("Sign Up"),
          ),
        ],
      ),
    );
  }

  Future<bool> createUser(String email, String password) async {

    try{

      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

    }catch(e){

      print(e);
      return false;
    }

    return true;
  }
}
