import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

import '../resources/auth_resources.dart';
import '../responsive_layout/mobilescreen_layout.dart';
import '../responsive_layout/responsive_layout.dart';
import '../responsive_layout/webscreen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  Uint8List? _pickedImage;
  bool _isLoading = false;

  // AuthMethods signUp = AuthMethods();

  void selectImage() async {
    Uint8List pickedImagePath =
    await pickedImage(imageSource: ImageSource.gallery);
    if (pickedImagePath != null) {
      setState(() {
        _pickedImage = pickedImagePath;
      });
    }
  }

  void signUpMethod() async {
    try {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        username: _userNameController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        file: _pickedImage!,
      );
      setState(() {
        _isLoading = false;
      });

      if (res != 'success') {
        showSnackBar(context: context, content: res);
      }else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            },
          ),
        );}
    } catch (error) {
      showSnackBar(context: context, content: error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToSignIn()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>  WebScreenLayout(),),);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
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
                  height: size.height/1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: size.height / 54),
                        Text("Instagram",style: GoogleFonts.oleoScriptSwashCaps(textStyle: TextStyle(color:Colors.black87,fontSize: 50,fontWeight: FontWeight.w300)),),
                        Stack(
                          children: [
                            _pickedImage != null
                                ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(
                                _pickedImage!,
                              ),
                            )
                                : const CircleAvatar(
                              radius: 64,
                              backgroundImage: AssetImage(
                                "assets/default.jpeg",
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blueColor,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: selectImage,
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    // size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: size.height / 34),
                        TextField(
                          onTap: () {},
                          cursorColor: Colors.black54,
                          controller: _userNameController,
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
                          onTap: () {},
                          cursorColor: Colors.black54,
                          controller: _emailController,
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
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'Enter your email',
                            hintStyle:
                            const TextStyle(fontSize: 16, color: Colors.black54),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                        ),

                        SizedBox(height: size.height / 54),
                        TextField(
                          onTap: () {},
                          cursorColor: Colors.black54,
                          controller: _bioController,
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
                            labelText: "Bio",
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'Enter your bio',
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
                          onPressed: signUpMethod,
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
                            onPressed: () {

                            },
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