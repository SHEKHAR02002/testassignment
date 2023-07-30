import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testassignment/API/filterproduct.dart';
import 'package:testassignment/Model/productmodel.dart';
import 'package:testassignment/Screens/Theme/constant.dart';
import 'package:testassignment/Screens/widget/productgrid.dart';

class CategoryFilter extends ConsumerStatefulWidget {
  const CategoryFilter({super.key});

  @override
  ConsumerState<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends ConsumerState<CategoryFilter> {
  late List<ProductoModel?> productdata;
  bool loader = true;
  getdata() async {
    final filter = ref.read(filterProvider);
    productdata = await getcategoryproduct(filter: filter);
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
