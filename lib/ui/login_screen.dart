import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bike_data_register/ui/profile_screen.dart';
import 'package:bike_data_register/ui/forgot_pass.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Function to handle login
  static Future<User?> loginUsingEmailPassword(
      {required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 234), // Background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Color.fromARGB(255, 234, 234, 234), // Color for the container holding content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Cool Rides",
                style: TextStyle(
                  color: Color.fromARGB(255, 13, 0, 96),
                  fontSize: 44.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Log In",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 44.0,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "User Email",
                    prefixIcon: Icon(Icons.mail, color: Colors.black)),
              ),
              const SizedBox(
                height: 44.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password, color: Colors.black)),
              ),
              const SizedBox(
                height: 12.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPass()),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 88.0,
              ),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Color(0xFF0069FE),
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Invalid username or password."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
