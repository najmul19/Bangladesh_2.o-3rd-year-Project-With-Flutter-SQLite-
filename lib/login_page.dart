// import 'package:bangladesh_2o/AdminPanel/admin_page.dart';
// import 'package:bangladesh_2o/auth_db_helper.dart';
// import 'package:bangladesh_2o/bottom_navigation.dart';
// import 'package:bangladesh_2o/forgot_password_page.dart';
// import 'package:bangladesh_2o/sign_up.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: "Login".text.bold.xl2.black.make(),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//             child: Column(
//               children: [
//                 // Login Image
//                 Image.asset(
//                   "assets/images/login_image.png",
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(height: 20),

//                 // Welcome Text
//                 Text(
//                   "Welcome Back",
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Email and Password Fields
//                 Column(
//                   children: [
//                     // Email Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF4F5F9),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: TextFormField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Enter Email",
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Email cannot be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Password Field
//                     Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF4F5F9),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: TextFormField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Enter Password",
//                           labelText: "Password",
//                           prefixIcon: Icon(Icons.lock),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Password cannot be empty";
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // Forgot Password
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ForgotPasswordPage(),
//                           ),
//                         );
//                       },
//                       child: const Text('Forgot Password?'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),

//                 // Login Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if(_emailController.text=="admin" && _passwordController.text =="admin"){
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => AdminPage(
                               
//                               ),
//                             ),
//                           );
//                       }
//                       if (_formKey.currentState!.validate()) {
//                         final email = _emailController.text;
//                         final password = _passwordController.text;

//                         final user =
//                             await AuthDBHelper().loginUser(email, password);

//                         if (user != null) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => Bottomavigation(
//                                 userName: user['username'],
//                                 userImage:
//                                     'assets/images/nj.png',
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('Invalid email or password'),
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: const Text('Sign In'),
//                   ),
//                 ),

//                 // Sign Up Redirect
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const SignUp()),
//                     );
//                   },
//                   child: const Text('Don’t have an account? Sign Up'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bangladesh_2o/AdminPanel/home_admin.dart';
import 'package:flutter/material.dart';
import 'AdminPanel/admin_page.dart';
import 'auth_db_helper.dart';
import 'bottom_navigation.dart';
import 'forgot_password_page.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to release resources
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> _handleLogin() async {
  //   // Check for admin credentials
  //   if (_emailController.text == "admin" && _passwordController.text == "admin") {
  //     // Use Future.microtask for safe navigation
  //     Future.microtask(() {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => HomeAdmin(),
  //         ),
  //       );
  //     });
  //     return;
  //   }

  //   // Validate form and authenticate user
  //   if (_formKey.currentState!.validate()) {
  //     final email = _emailController.text;
  //     final password = _passwordController.text;

  //     final user = await AuthDBHelper().loginUser(email, password);

  //     if (user != null) {
  //       Future.microtask(() {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => Bottomavigation(
  //               userName: user['username'],
  //               userImage: 'assets/images/nj.png',
                
  //             ),
  //           ),
  //         );
  //       });
  //     } else {
  //       // Show error message for invalid credentials
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Invalid email or password')),
  //       );
  //     }
  //   }
  // }

  Future<void> _handleLogin() async {
  // Check for admin credentials
  if (_emailController.text == "admin" && _passwordController.text == "admin") {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeAdmin(),
      ),
    );
    return;
  }

  // Validate form and authenticate user
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await AuthDBHelper().loginUser(email, password);

    if (user != null && user['userId'] != null) {
      // Now pass the 'userId' to the Bottomavigation widget
      // final userId = user['userId']; // Assuming 'userId' is in the map
      final userId = user['userId'].toString(); // Ensure the userId is a String
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Bottomavigation(
            userName: user['username'],
            userImage: 'assets/images/nj.png',
            userId: userId,  // Pass userId here
          ),
        ),
      );
    } else {
      // Show error message for invalid credentials or missing userId
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email, password, or user data')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                // Login Image
                Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Email",
                      labelText: "Email",
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
                const SizedBox(height: 16),

                // Password Field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Password",
                      labelText: "Password",
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
                const SizedBox(height: 10),

                // Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Sign In'),
                  ),
                ),

                // Sign Up Redirect
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUp()),
                    );
                  },
                  child: const Text('Don’t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
