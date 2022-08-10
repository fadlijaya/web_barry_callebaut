import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page/menu_page.dart';
import 'split_view.dart';

class AdminView extends ConsumerWidget {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplitView(menu: const MenuPage(), content: selectedPageBuilder(context)),
    );
  }
}