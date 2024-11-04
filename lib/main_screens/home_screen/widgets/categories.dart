import 'package:bun_app/data/demo_data.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          DemoData.categories.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color(0xff352A4C)
                        : const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                  DemoData.categories[index].name,
                  style: TextStyle(
                      color:
                          selectedIndex == index ? Colors.white : Colors.black),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
