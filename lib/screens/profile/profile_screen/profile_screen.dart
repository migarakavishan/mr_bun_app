import 'package:bun_app/controllers/admin_controller.dart';
import 'package:bun_app/controllers/auth_controller.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/providers/profile_provider.dart';
import 'package:bun_app/screens/favorite/favorite_screen.dart';
import 'package:bun_app/screens/my_orders/my_orders.dart';
import 'package:bun_app/screens/profile/admin_screen/admin_screen.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
        floatingActionButton: FutureBuilder(
            future: AdminController().getAdmins(),
            builder: (context, snapshot) {
              String uid =
                  Provider.of<AuthProvider>(context, listen: false).user!.uid;

              if (snapshot.connectionState == ConnectionState.waiting) {}
              if (snapshot.hasError) {}
              if (snapshot.hasData) {
                Logger().e(snapshot.data);
              }
              // Show admin floating action button if the current user is an admin
              if (snapshot.hasData) {
                return snapshot.data!.contains(uid)
                    ? FloatingActionButton(
                        child: const Icon(Icons.admin_panel_settings),
                        onPressed: () {
                          CustomNavigators.goTo(context, const AdminScreen());
                        },
                      )
                    : const SizedBox();
              }
              return const SizedBox();
            }),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer2<AuthProvider, ProfileProvider>(
              builder: (context, value, profile, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        profile.pickProfileImage(context);
                      },
                      child: Align(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: profile.pickedImage == null
                              ? NetworkImage(value.userModel!.image)
                              : FileImage(profile.pickedImage!)
                                  as ImageProvider,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: profile.nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.edit),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2B2A4C)),
                    onPressed: () {
                      profile.updateUserData(context);
                    },
                    child: const Text(
                      "Update Profle",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 300,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite,
                                color: Color(0xff1B6BA7), size: 25),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                CustomNavigation2.nextPage2(
                                    context, const FavoriteScreen());
                              },
                              child: const Text("Favorite",
                                  style: TextStyle(
                                      color: Color(0xff1B6BA7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: Color(0xff1B6BA7))
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomNavigation2.nextPage2(
                                context, const MyOrders());
                          },
                          child: const Row(
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
                                key: ValueKey('logout'),
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
