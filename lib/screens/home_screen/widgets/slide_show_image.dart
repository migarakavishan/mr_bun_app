import 'package:bun_app/utils/demo_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SlideShowImage extends StatelessWidget {
  const SlideShowImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(aspectRatio: 16 / 7, autoPlay: true),
      items: DemoData.images.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                width: 600,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        // Image has finished loading
                        return child;
                      } else {
                        // Display Spinkit loading indicator
                        return const Center(
                          child: SpinKitFadingCircle(
                            color: Colors.blue,
                            size: 50.0,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
