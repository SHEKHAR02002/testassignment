import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testassignment/API/getproduct.dart';
import 'package:testassignment/Model/productmodel.dart';
import 'package:testassignment/Provider/addtocartfun.dart';
import 'package:testassignment/Screens/Theme/constant.dart';
import 'package:testassignment/Screens/Theme/theme.dart';

class AddtoCart extends ConsumerStatefulWidget {
  const AddtoCart({super.key});

  @override
  ConsumerState<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends ConsumerState<AddtoCart> {
  void callapi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getStringList('addtocart');
    if (data != null) {
      ref.watch(addtocarproductid.notifier).state = data;
    } else {
      print("empty data");
    }
  }

  @override
  void initState() {
    callapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(addtocarproductid);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "My Cart",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddtoCart())),
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
        body: products.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AddtocartCard(
                    id: products[index],
                  );
                })
            : SizedBox.shrink());
  }
}

class AddtocartCard extends ConsumerStatefulWidget {
  final String id;
  const AddtocartCard({super.key, required this.id});

  @override
  ConsumerState<AddtocartCard> createState() => _AddtocartCardState();
}

class _AddtocartCardState extends ConsumerState<AddtocartCard> {
  ProductoModel? data;
  final datacomeloaderProvidera = StateProvider((ref) => true);

  getsingledata() async {
    data = await getsingleproduct(id: widget.id);
    ref.watch(datacomeloaderProvidera.notifier).state = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getsingledata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final loader = ref.watch(datacomeloaderProvidera);
    final addtocartlist = ref.watch(addtocarproductid);
    return loader
        ? const CircularProgressIndicator()
        : Column(
            children: [
              Container(
                decoration: shadowdecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Image.network(
                      data!.image.toString(),
                      width: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 1.5,
                          child: Text(
                            // "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                            data!.title.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "₹ ${data!.price.toString()}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Text(
                              "${data!.rating!.rate} (${data!.rating!.count})",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (check(
                                  id: data!.id.toString(),
                                  list: addtocartlist)) {
                                final adtocartlist1 =
                                    ref.watch(addtocarproductid);
                                adtocartlist1.remove(data!.id.toString());
                                ref.watch(addtocarproductid.notifier).state = [
                                  ...adtocartlist1
                                ];
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setStringList('addtocart', adtocartlist1);
                                Fluttertoast.showToast(
                                    msg: "Product Remove succesfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Already Present",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: Colors.white,
                                minimumSize: Size(90, 30)),
                            child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey),
                                ))),
                      ],
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
  }
}
