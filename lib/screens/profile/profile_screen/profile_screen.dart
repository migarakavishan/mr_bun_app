import 'package:bun_app/controllers/auth_controller.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/screens/profile/admin_screen/admin_screen.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CustomNavigators.goTo(context, const AdminScreen());
          },
          child: const Icon(Icons.admin_panel_settings_outlined),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<AuthProvider>(builder: (context, value, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(value.userModel!.image),
                    ),
                  ],
                ),
                Text(
                  value.userModel!.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: const Color(0xffCAE0F0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    value.userModel!.email,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 350,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.edit,
                                color: Color(0xff1B6BA7), size: 25),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Edit Profile",
                                style: TextStyle(
                                    color: Color(0xff1B6BA7),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Color(0xff1B6BA7))
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.favorite,
                                color: Color(0xff1B6BA7), size: 25),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Favorite",
                                style: TextStyle(
                                    color: Color(0xff1B6BA7),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Color(0xff1B6BA7))
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.my_library_books,
                                color: Color(0xff1B6BA7), size: 25),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "My Orders",
                              style: TextStyle(
                                  color: Color(0xff1B6BA7),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: Color(0xff1B6BA7))
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthController().signOutUser();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.red,
                                size: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
