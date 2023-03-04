import 'package:flutter/material.dart';
import 'package:ticktok/controller/auth_controller.dart';
import 'package:ticktok/view/auth/signup_page.dart';
import 'package:ticktok/widgets/text_input.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Log in Page",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInput(controller: _emailController, myIcon: Icons.email, myLabel: "Email")),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInput(controller: _passwordController, myIcon: Icons.lock, myLabel: "Password",toHide: true,)),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed: (){
              AuthController.instance.login(_emailController.text, _passwordController.text);
            }, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
              child: Text("Login"),
            ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account/ ",style: TextStyle(color: Colors.white70,fontSize: 16,),),
                InkWell(
                    onTap: (){Get.to(SignUpPage());
                      },
                    child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),))
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
