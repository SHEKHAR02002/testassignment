import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testassignment/API/filterproduct.dart';
import 'package:testassignment/API/getproduct.dart';
import 'package:testassignment/Model/productmodel.dart';
import 'package:testassignment/Screens/Theme/theme.dart';
import 'package:testassignment/Screens/addtocart.dart';
import 'package:testassignment/Screens/widget/categoryfilter.dart';
import 'package:testassignment/Screens/widget/productgrid.dart';

import 'Theme/constant.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController search = TextEditingController();
  final filteronofProvider = StateProvider((ref) => false);

  late List<ProductoModel?> productdata;
  bool loader = true;

  getdata() async {
    final filterstr = ref.read(filterProvider);

    if (filterstr == "All") {
      productdata = await getproduct();
      setState(() {
        loader = false;
      });
    } else {
      productdata = await getcategoryproduct(filter: filterstr);
      setState(() {
        loader = false;
      });
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final filteronoff = ref.watch(filteronofProvider);
    final filter = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddtoCart())),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Icon(
                CupertinoIcons.cart,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => filteronoff
                      ? ref.watch(filteronofProvider.notifier).state = false
                      : ref.watch(filteronofProvider.notifier).state = true,
                  child: SvgPicture.asset(
                    "assets/filter.svg",
                  ),
                ),
                const Spacer(),
                Container(
                  width: width / 1.3,
                  decoration: shadowdecoration,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Search",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    controller: search,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            filteronoff
                ? SizedBox(
                    height: 40,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          InkWell(
                            onTap: () {
                              ref.watch(filterProvider.notifier).state = 'All';
                              getdata();
                              toast(msg: "Filter By All Category");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "All",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              ref.watch(filterProvider.notifier).state =
                                  "electronics";
                              toast(msg: "Filter By Electronic Category");
                              getdata();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "Electronic",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              print("come3");
                              ref.watch(filterProvider.notifier).state =
                                  "jewelery";
                              toast(msg: "Filter By Jewelery Category");
                              getdata();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "jewelery",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              print("come4");
                              ref.watch(filterProvider.notifier).state =
                                  "men's clothing";
                              toast(msg: "Filter By Men's Cloth Category");
                              getdata();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "men's clothing",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              print("come6");
                              ref.watch(filterProvider.notifier).state =
                                  "women's clothing";
                              toast(msg: "Filter By Womens Cloth Category");

                              getdata();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "women's clothing",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]))
                : const SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "All Products",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            loader
                ? CircularProgressIndicator()
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productdata.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.30),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12),
                    itemBuilder: (context, index) {
                      var product = productdata[index];
                      return ProductCard(
                        data: product!,
                      );
                    })
            // filter == "All" ? ProductGrid() : CategoryFilter()
          ],
        ),
      ),
    );
  }
}
