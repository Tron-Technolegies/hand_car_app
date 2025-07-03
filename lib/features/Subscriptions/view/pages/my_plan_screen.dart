import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/controller/my_subscription_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPlanScreen extends HookConsumerWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(mySubscriptionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscription'),
        backgroundColor: Colors.blueAccent,
      ),
      body: subscriptionAsync.when(
        data: (data) => _buildContent(context, data, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> data, WidgetRef ref) {
    final isSubscribed = data['subscribed'] as bool;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSubscribed ? 'Your Current Plan' : 'Available Plans',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 16),
          if (isSubscribed) ...[
            _buildSubscribedView(data, theme),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Manage Subscription', style: TextStyle(color: Colors.white)),
            ),
          ] else ...[
            _buildAvailablePlans(data['plans'] as List<dynamic>, theme),
          ],
        ],
      ),
    );
  }

  Widget _buildSubscribedView(Map<String, dynamic> data, ThemeData theme) {
    final plan = data['plan'] as Map<String, dynamic>;
    final vendor = data['vendor'] as Map<String, dynamic>;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan['name'] as String,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Price: ${plan['price']}'),
            Text('Start Date: ${plan['start_date']}'),
            Text('End Date: ${plan['end_date']}'),
            const SizedBox(height: 12),
            Text('Vendor:', style: theme.textTheme.titleMedium),
            Text('Name: ${vendor['name']}'),
            Text('Contact: ${vendor['contact']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailablePlans(List<dynamic> plans, ThemeData theme) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index] as Map<String, dynamic>;
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan['name'] as String,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Price: ${plan['price']}'),
                Text('Features:'),
                Text(
                  plan['features']?.toString() ?? 'No features listed',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement plan subscription logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Subscribe', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}