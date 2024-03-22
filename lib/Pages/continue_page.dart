import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram/Pages/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_const.dart';

class Continue_Page extends StatefulWidget {
  @override
  _Continue_PageState createState() => _Continue_PageState();
}

class _Continue_PageState extends State<Continue_Page>
    with TickerProviderStateMixin {
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
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                height: size.height/6,
                  width: size.width/1.3,
                  placeholder: NetworkImage(
                      "https://akm-img-a-in.tosshub.com/businesstoday/images/story/202212/instagram-users-irked-with-the-new-update-sixteen_nine.jpg?size=1200:675"),
                  image: NetworkImage(
                      "https://akm-img-a-in.tosshub.com/businesstoday/images/story/202212/instagram-users-irked-with-the-new-update-sixteen_nine.jpg?size=1200:675")),
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        onTap: () {},
                        cursorColor: Colors.black54,
                        controller: _usernameController,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            labelText: "Username",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54.withOpacity(0.7)),
                            ),
                            labelStyle: const TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold),
                            hintText: 'Type your username',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            hintStyle: const TextStyle(fontSize: 16, color: Colors.black54),
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            prefixIcon: const Icon(
                              CupertinoIcons.profile_circled,
                              color: Colors.black54,
                              size: 26,
                            )),
                      ),),
                ),
              ),
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child:TextField(
                        enabled: true,
                        controller: _passwordController,
                        onTap: () {},
                        cursorColor: Colors.black,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54.withOpacity(0.7)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                          ),
                          hintText: 'Type your password',
                          hintStyle: const TextStyle(fontSize: 16, color: Colors.black54),
                          prefixIcon: const Icon(Icons.lock, color: Colors.black54, size: 26),
                        ),
                      ),

                //        if (_errorMessage.isNotEmpty){
                // Text(
                // _errorMessage,
                // style: const TextStyle(color: Colors.red),
                // ),
                // }),
                  )
                ),
              ),
              SizedBox(height: size.height/54,),
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child:  ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(6),
                              fixedSize: MaterialStateProperty.all(const Size(190, 40)),
                              shadowColor: MaterialStateProperty.all(
                                Colors.black87,
                              ),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)))),
                          onPressed: () async {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            // Here you can add your logical part for authentication
                            if (_usernameController.text.isEmpty &&
                                _passwordController.text.isEmpty) {
                              setState(() {
                                _errorMessage = 'Please enter both username and password.';
                              });
                            } else if (_usernameController.text.isEmpty) {
                              setState(() {
                                _errorMessage = "Please enter username";
                              });
                            } else if (_passwordController.text.isEmpty) {
                              setState(() {
                                _errorMessage = "Please enter password";
                              });
                            } else {
                              _errorMessage = "";
                              isCheck = true;
                              setState(() {});
                              Future.delayed(const Duration(seconds: 3), () {
                                if (userName == _usernameController.text &&
                                    userPassword == _passwordController.text) {
                                  isCheck = false;
                                  pref.setBool("isLogin", true);
                                  isLogin = pref.getBool("isLogin")!;
                                  print("isLogin:$isLogin");
                                  setState(() {});
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => const HomePageVIew(),
                                  //     ));
                                } else if (userName != _usernameController.text) {
                                  setState(() {
                                    isCheck = false;
                                    setState(() {});
                                    _errorMessage = "Invalid username";
                                  });
                                } else if (userPassword != _passwordController.text) {
                                  setState(() {
                                    isCheck = false;
                                    setState(() {});
                                    _errorMessage = "Invalid password";
                                  });
                                }
                              });
                            }
                          },
                          child: (!isCheck)
                              ? const Text("Login")
                              : const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )),),
                ),
              ),
              AnimatedBuilder(
                animation: _scaleController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(6),
                            fixedSize: MaterialStateProperty.all(const Size(190, 40)),
                            shadowColor: MaterialStateProperty.all(
                              Colors.black87,
                            ),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)))),
                        onPressed: () async {
                          User? user = await _signInWithGoogle();
                          if (user != null) {
                            // User is signed in, navigate to the next screen or perform desired action
                            print('Logged in user: ${user.displayName}');
                          } else {
                            // Handle sign in failure
                            print('Sign in failed');
                          }
                        },
                        child: Row(
                          children: [
                            Text('Login in with Google'),
                          ],
                        ),
                      ),),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}