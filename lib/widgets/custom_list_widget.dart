import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:educatly/size_config.dart';
import 'package:flutter/material.dart';

class ListLoadingBuilder extends StatelessWidget {
  const ListLoadingBuilder({
    super.key,
    required this.condition,
    required this.itemCount,
    required this.itemBuilder,
    required this.fallback,
  });

  final bool condition;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: condition,
      builder: (context) => itemCount == 0
          ? fallback
          : ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: itemBuilder,
              separatorBuilder: (context, index) => SizedBox(
                height: height(15),
              ),
              itemCount: itemCount,
            ),
      fallback: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}