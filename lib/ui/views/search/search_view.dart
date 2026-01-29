import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/widgets/search_grid.dart';
import 'search_viewmodel.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              onChanged: vm.setQuery,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          body: vm.isBusy
              ? const Center(child: CircularProgressIndicator())
              : SearchGrid(
            images: vm.images,
            onTap: vm.openImage,
          ),
        );
      },
    );
  }
}
