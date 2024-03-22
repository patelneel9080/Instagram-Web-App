import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram/Pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/loginpage.dart';
import '../app_const.dart';
import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
   WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> with TickerProviderStateMixin{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        return authResult.user;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return null;
  }
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  String data = "";

  bool isCheck = false;

  bool isVisible= true;

  late AnimationController _scaleController;

  late Animation<double> _scaleAnimation;

  bool hide = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 12));

    _scaleAnimation =
    Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.fade,
          //         child: const HomeScreen()));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffEE0015),
              Color(0xffDD0046),
              Color(0xffCC0078),
              Color(0xffBE00A3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                color: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white,strokeAlign: BorderSide.strokeAlignCenter),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: 350,
                  height: size.height/1.9,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       SizedBox(height: size.height / 54),
                       Text("Instagram",style: GoogleFonts.oleoScriptSwashCaps(textStyle: TextStyle(color:Colors.black87,fontSize: 50,fontWeight: FontWeight.w300)),),
                       SizedBox(height: size.height / 34),
                       TextField(
                         onTap: () {},
                         cursorColor: Colors.black54,
                         controller: _usernameController,
                         style: const TextStyle(fontWeight: FontWeight.w400),
                         decoration: InputDecoration(
                           alignLabelWithHint: true,
                           border: InputBorder.none,
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(12),
                             borderSide: const BorderSide(color: Colors.black54),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(12),
                             borderSide: const BorderSide(color: Colors.black54),
                           ),
                           labelText: "Username",
                           labelStyle: const TextStyle(color: Colors.black54),
                           hintText: 'Enter your username',
                           hintStyle:
                           const TextStyle(fontSize: 16, color: Colors.black54),
                           contentPadding: const EdgeInsets.symmetric(
                               vertical: 15.0, horizontal: 10.0),
                         ),
                       ),
                       SizedBox(height: size.height / 54),
                       TextField(
                         enabled: true,
                         controller: _passwordController,
                         onTap: () {},
                         cursorColor: Colors.black,
                         autocorrect: true,
                         obscureText: true,
                         decoration: InputDecoration(
                           alignLabelWithHint: true,
                           border: InputBorder.none,
                           labelText: "Password",
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(12),
                             borderSide: const BorderSide(color: Colors.black54),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(12),
                             borderSide: const BorderSide(color: Colors.black54),
                           ),
                           labelStyle: const TextStyle(color: Colors.black54),
                           hintText: 'Enter your password',
                           hintStyle:
                           const TextStyle(fontSize: 16, color: Colors.black54),
                           contentPadding: const EdgeInsets.symmetric(
                               vertical: 15.0, horizontal: 10.0),
                         ),
                       ),
                       SizedBox(height: size.height / 54),
                       ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor:
                           MaterialStateProperty.all(Color(0xff4CB5F9)),
                           elevation: MaterialStateProperty.all(6),
                           fixedSize:
                           MaterialStateProperty.all(const Size(250, 40)),
                           shape: MaterialStateProperty.all(
                             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(24),
                             ),
                           ),
                         ),
                         onPressed: () async {
                           // Your onPressed logic
                         },
                         child: Text("Login",style: TextStyle(color: Colors.white),),
                       ),
                       SizedBox(height: size.height / 74),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("-------------      ",style: TextStyle(color: Colors.black54),),
                           Text("OR",style: TextStyle(color: Colors.black54),),
                           Text("      -------------",style: TextStyle(color: Colors.black54), ),
                         ],
                       ),
                       SizedBox(height: size.height / 74),
                       // ElevatedButton(
                       //   style: ButtonStyle(
                       //     backgroundColor:
                       //     MaterialStateProperty.all(Color(0xff4CB5F9)),
                       //     elevation: MaterialStateProperty.all(6),
                       //     fixedSize:
                       //     MaterialStateProperty.all(const Size(250, 40)),
                       //     shape: MaterialStateProperty.all(
                       //       RoundedRectangleBorder(
                       //         borderRadius: BorderRadius.circular(24),
                       //       ),
                       //     ),
                       //   ),
                       //   onPressed: () async {
                       //     // Your onPressed logic
                       //   },
                       //   child: Row(
                       //     mainAxisAlignment: MainAxisAlignment.center,
                       //     children: [
                       //       Text('Login in with Google',style: TextStyle(color: Colors.white),),
                       //     ],
                       //   ),
                       // ),
                       TextButton(
                           onPressed: _signInWithGoogle,
                           style: ButtonStyle(
                       //       backgroundColor:
                       // MaterialStateProperty.all(Color(0xff4CB5F9)),
                         elevation: MaterialStateProperty.all(6),
                         fixedSize:
                         MaterialStateProperty.all(const Size(250, 40)),
                         shape: MaterialStateProperty.all(
                           RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(24),
                           ),
                         ),), child: Text("Login in with Google",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 16),)),
                       SizedBox(height: size.height/85,),
                       TextButton(onPressed: () {}, child: Text("Forgot Password?",style: TextStyle(color: Colors.black),))
                     ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 6,
                color: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: 350,
                  height: size.height/14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(color: Colors.black),),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                          },
                          child: Text("Sign up",style: TextStyle(color: Colors.blueAccent),)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}