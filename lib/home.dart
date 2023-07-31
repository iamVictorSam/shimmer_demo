import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shimmer_demo/product_shimmer.dart';

import 'api_request.dart';
import 'items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<dynamic> photos = await fetchPhotos();
      setState(() {
        _photos = photos;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Effect'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading ? _buildProductShimmer() : _buildProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductShimmer() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.black12,
              direction: ShimmerDirection.ttb,
              period: const Duration(milliseconds: 800),
              child: const ProductShimmer());
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 2,
        ),
      );

  Widget _buildProduct() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Items(
                  imageUrl: photo['url'],
                  title: photo['title'],
                  number: photo['id'].toString(),
                );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 2,
        ),
      );
}
