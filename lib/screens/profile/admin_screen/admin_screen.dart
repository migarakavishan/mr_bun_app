import 'package:bun_app/providers/admin_provider.dart';
import 'package:bun_app/utils/demo_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F6F6),
        title: const Text("Add New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<AdminProvider>(builder: (context, value, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  value.pickImage(context);
                },
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: value.imageFile != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(value.imageFile!)))
                      : null,
                  child: value.imageFile == null
                      ? const CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.add,
                            size: 60,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.nameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Product Name',
                  prefixIcon: const Icon(Icons.shopping_cart_rounded),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.descriptionController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Description',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: value.priceController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Price',
                  prefixIcon: const Icon(Icons.price_change),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select Product Category",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      DemoData.categories.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: InkWell(
                              onTap: () {
                                value.setSelectCategory(
                                    DemoData.categories[index].name);
                              },
                              child: Chip(
                                  backgroundColor: value.selectedCategory ==
                                          DemoData.categories[index].name
                                      ? Colors.blue
                                      : Colors.white,
                                  label: Text(
                                    DemoData.categories[index].name,
                                    style: TextStyle(
                                        color: value.selectedCategory ==
                                                DemoData.categories[index].name
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                            ),
                          )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff352A4C)),
                  onPressed: () {
                    value.addProduct(context);
                  },
                  child: const Text(
                    "Add Product",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
