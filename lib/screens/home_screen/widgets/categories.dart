import 'package:bun_app/utils/demo_data.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top Categories",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
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
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? const Color(0xff352A4C)
                                : const Color(0xffD9D9D9),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          DemoData.categories[index].name,
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              "See all",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
