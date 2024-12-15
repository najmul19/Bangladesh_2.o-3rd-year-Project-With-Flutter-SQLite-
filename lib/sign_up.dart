// import 'package:firebase_auth/firebase_auth.dart';
import 'package:bangladesh_2o/auth_db_helper.dart';
import 'package:bangladesh_2o/login_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? name, password, email;

  // registration() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email!, password: password!);
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: Colors.green,
  //         content: "Registered Successfully".text.xl2.make(),
  //       ));
  //       String id = randomAlphaNumeric(10);
  //       await SharedPreferencesHelper().saveUserEmail(emailController.text);
  //       await SharedPreferencesHelper().saveUserId(id);
  //       await SharedPreferencesHelper().saveUserName(nameController.text);

  //       await SharedPreferencesHelper().saveUserImage(
  //           "https://scontent.fdac22-1.fna.fbcdn.net/v/t39.30808-1/455890343_999955728807433_6785008603388102544_n.jpg?stp=dst-jpg_s160x160&_nc_cat=107&ccb=1-7&_nc_sid=0ecb9b&_nc_eui2=AeHh-3OOKCdbQJPAhBxAYUfMzO5wu3-B-DDM7nC7f4H4MKGrh_W2vgSraHQD4DIfeAaRRtQqpmLe059Ze9jXG6gp&_nc_ohc=LX-3MBNkY9cQ7kNvgF8VLUV&_nc_zt=24&_nc_ht=scontent.fdac22-1.fna&_nc_gid=Ap42yazkgSz2eRTIBjsA6XE&oh=00_AYDRQ8lSbmVmk6zpx0tAdsB8R0hv220-ymWnt2Wjr1JaZg&oe=67467572");

  //       Map<String, dynamic> userInfo = {
  //         "Name": _nameController.text,
  //         "Email": _emailController.text,
  //         "Id": id,
  //         "Image":
  //             "https://scontent.fdac22-1.fna.fbcdn.net/v/t39.30808-1/455890343_999955728807433_6785008603388102544_n.jpg?stp=dst-jpg_s160x160&_nc_cat=107&ccb=1-7&_nc_sid=0ecb9b&_nc_eui2=AeHh-3OOKCdbQJPAhBxAYUfMzO5wu3-B-DDM7nC7f4H4MKGrh_W2vgSraHQD4DIfeAaRRtQqpmLe059Ze9jXG6gp&_nc_ohc=LX-3MBNkY9cQ7kNvgF8VLUV&_nc_zt=24&_nc_ht=scontent.fdac22-1.fna&_nc_gid=Ap42yazkgSz2eRTIBjsA6XE&oh=00_AYDRQ8lSbmVmk6zpx0tAdsB8R0hv220-ymWnt2Wjr1JaZg&oe=67467572",
  //       };
  //       await Databse().addUserDetails(userInfo, id);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => LoginPage()));
  //     } on FirebaseAuthException catch (e) {
  //       String errorMsg = "";
  //       if (e.code == 'weak-password') {
  //         errorMsg = "Password provided is too weak";
  //       } else if (e.code == 'email-already-in-use') {
  //         errorMsg = "Account already exists";
  //       } else {
  //         errorMsg = "Registration failed. Try again.";
  //       }
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         backgroundColor: Colors.redAccent,
  //         content: errorMsg.text.xl2.make(),
  //       ));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Sign Up".text.bold.xl2.black.make(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/sign_up.png",
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Name Field
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF4F5F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Name",
                        labelText: "Name",
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  16.heightBox,

                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF4F5F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Email",
                        labelText: "Email",
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  16.heightBox,

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF4F5F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Password",
                        labelText: "Password",
                        // border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  16.heightBox,

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final name = _nameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        final result = await AuthDBHelper()
                            .registerUser(name, email, password);
                        if (result > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('User registered successfully')));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email already exists')));
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ),
                  16.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Already have an account?".text.make(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: " Login".text.black.bold.make()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
