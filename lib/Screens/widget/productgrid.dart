import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testassignment/API/getproduct.dart';
import 'package:testassignment/Model/productmodel.dart';
import 'package:testassignment/Provider/addtocartfun.dart';
import 'package:testassignment/Screens/Theme/constant.dart';
import 'package:testassignment/Screens/Theme/theme.dart';

class ProductGrid extends ConsumerStatefulWidget {
  const ProductGrid({super.key});

  @override
  ConsumerState<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends ConsumerState<ProductGrid> {
  late List<ProductoModel?> productdata;
  bool loader = true;
  getdata() async {
    productdata = await getproduct();
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return loader
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
            });
  }
}

class ProductCard extends ConsumerStatefulWidget {
  final ProductoModel data;
  const ProductCard({super.key, required this.data});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final addtocartlist = ref.watch(addtocarproductid);
    return InkWell(
      onTap: () => getproduct(),
      child: Container(
        decoration: shadowdecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.data.image.toString(),
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                // "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                widget.data.title.toString(),
                maxLines: 1,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "₹ ${widget.data.price.toString()}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                    "${widget.data.rating!.rate} (${widget.data.rating!.count})",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (!check(
                          id: widget.data.id.toString(), list: addtocartlist)) {
                        SetData().setaddtocartids(
                            id: widget.data.id.toString(), ref: ref);
                        Fluttertoast.showToast(
                            msg: "Product Added succesfully",
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
                            side: BorderSide(width: 1, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.white,
                        minimumSize: Size(120, 36)),
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
