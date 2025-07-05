import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/controller/my_subscription_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/controller/subscription_controller.dart';

class MyPlanScreen extends HookConsumerWidget {
  final String serviceType;

  const MyPlanScreen({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(mySubscriptionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_formatServiceType(serviceType)} Subscription'),
        backgroundColor: context.colors.primary,
      ),
      body: subscriptionAsync.when(
        data: (data) => _buildContent(context, data, ref, serviceType),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _formatServiceType(String serviceType) {
    return serviceType
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildContent(BuildContext context, Map<String, dynamic> data,
      WidgetRef ref, String serviceType) {
    final isSubscribed = data['subscribed'] as bool? ?? false;
    final plan = data['plan'] as Map<String, dynamic>? ?? {};
    final theme = Theme.of(context);

    bool isServiceSubscribed = isSubscribed &&
        (plan['category'] as String?)?.toLowerCase() ==
            serviceType.toLowerCase();

    if (plan.isEmpty && isSubscribed) {
      return const Center(child: Text('Subscription data is incomplete'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isServiceSubscribed ? 'Your Current Plan' : 'Available Plans',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
          const SizedBox(height: 16),
          if (isServiceSubscribed) ...[
            _buildSubscribedView(data, theme),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // TODO: Implement subscription cancellation or management
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.redAccent,
            //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //   ),
            //   child: Text(
            //     'Manage Subscription',
            //     style: context.typography.bodyLarge.copyWith(color: Colors.white),
            //   ),
            // ),
          ] else ...[
            _buildAvailablePlans(context, ref, serviceType, theme),
          ],
        ],
      ),
    );
  }

  Widget _buildSubscribedView(Map<String, dynamic> data, ThemeData theme) {
    final plan = data['plan'] as Map<String, dynamic>;
    final vendors = data['vendors'] as List<dynamic>? ?? [];

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
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Price: ${plan['price'] == 'N/A' ? 'Free' : plan['price']}'),
            Text('Start Date: ${plan['start_date']}'),
            Text('End Date: ${plan['end_date']}'),
            const SizedBox(height: 12),
            Text('Vendors:', style: theme.textTheme.titleMedium),
            if (vendors.isEmpty)
              const Text('No vendors available')
            else
              ...vendors.map((vendor) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${vendor['name']}'),
                      Text('Contact: ${vendor['contact']}'),
                      const SizedBox(height: 8),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailablePlans(BuildContext context, WidgetRef ref,
      String serviceType, ThemeData theme) {
    final plansAsync = ref.watch(planNotifierProvider(serviceType));

    return plansAsync.when(
      data: (plans) => plans.isEmpty
          ? const Center(child: Text('No plans available'))
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.name,
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Price: ${plan.price}'),
                        Text('Service Type: ${plan.serviceType}'),
                        Text('Duration: ${plan.duration}'),
                        if (plan.description != null &&
                            plan.description!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text('Features:'),
                          Text(
                            plan.description!,
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement plan subscription logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colors.primary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: Text(
                            'Subscribe',
                            style: context.typography.bodyLarge
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error loading plans: $error')),
    );
  }
}
