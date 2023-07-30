import 'package:flutter/material.dart';
import 'package:testassignment/API/getproduct.dart';
import 'package:testassignment/Model/productmodel.dart';
import 'package:testassignment/Screens/Theme/theme.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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

class ProductCard extends StatefulWidget {
  final ProductoModel data;
  const ProductCard({super.key, required this.data});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
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
                maxLines: 2,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
