import 'package:bun_app/model/category_model.dart';

class DemoData {
  static List<CategoryModel> categories = [
    CategoryModel(id: 1, name: 'Burger'),
    CategoryModel(id: 2, name: 'Pizza'),
    CategoryModel(id: 3, name: 'Hotdog'),
  ];

  // static List<ProductModel> productList = [
  //   ProductModel(
  //     id: '1',
  //     title: 'Classic Bun',
  //     description: 'A soft, fluffy bun with a classic taste.',
  //     category: 'ban',
  //     image:
  //         'https://www.cobsbread.com/wp-content/uploads/2022/05/cobs-product-traditional-hamburger-bun-583x400-1.png',
  //     price: 1.50,
  //   ),
  //   ProductModel(
  //     id: '2',
  //     title: 'Cheese Bun',
  //     description: 'A savory bun filled with melted cheese.',
  //     category: 'ban',
  //     image:
  //         'https://www.cobsbread.com/wp-content/uploads/2018/01/cobs-product-savoury-roll-cheese-650x458.png',
  //     price: 2.20,
  //   ),
  //   ProductModel(
  //     id: '3',
  //     title: 'Garlic Bun',
  //     category: 'ban',
  //     description: 'A soft bun with a garlic butter flavor.',
  //     image:
  //         'https://static.vecteezy.com/system/resources/thumbnails/047/270/299/small_2x/garlic-bread-with-cheese-and-parsley-food-photography-png.png',
  //     price: 2.00,
  //   ),
  // ];

  static List<String> images = [
    "https://arcticgrub.com/wp-content/uploads/2023/07/cardamombunsheroimage1-1.png",
    "https://denmark.dk/-/media/websites/denmarkdk/people-and-culture/recipes/wheatbunsedit.ashx?mw=1600&hash=D6C5E3CF8134F49047B44035F54D8136",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKNhawYm_PXEf07NfkSNIy5gMs2vOg0H6y-Q&s"
  ];
}
