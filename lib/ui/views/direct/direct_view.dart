import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/widgets/thread_tile.dart';
import 'direct_viewmodel.dart';

class DirectView extends StatelessWidget {
  const DirectView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DirectViewModel>.reactive(
      viewModelBuilder: () => DirectViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Direct'),
            actions: [
              IconButton(
                onPressed: vm.onCompose,
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          body: vm.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: vm.refresh,
            child: ListView.separated(
              itemCount: vm.threads.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final thread = vm.threads[i];
                return ThreadTile(
                  thread: thread,
                  onTap: () => vm.openThread(thread),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
