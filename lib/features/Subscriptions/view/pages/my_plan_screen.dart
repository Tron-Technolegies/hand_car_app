import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/controller/my_subscription_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/controller/subscription_controller.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/core/utils/snackbar.dart';

class MyPlanScreen extends HookConsumerWidget {
  final String serviceType;
  final bool showUpgradeOptions;

  const MyPlanScreen({
    super.key,
    required this.serviceType,
    this.showUpgradeOptions = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(mySubscriptionControllerProvider);

    return Scaffold(
      appBar: showUpgradeOptions
          ? null
          : AppBar(
              title: Text(
                '${_formatServiceType(serviceType)} Subscription',
                style: context.typography.bodyLarge,
              ),
              backgroundColor: context.colors.white,
            ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(mySubscriptionControllerProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: EdgeInsets.all(context.space.space_200),
            child: subscriptionAsync.when(
              data: (data) =>
                  _buildContent(context, data, ref, serviceType, constraints),
              loading: () => SizedBox(
                height: constraints.maxHeight,
                child: const Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SizedBox(
                height: constraints.maxHeight,
                child: Center(
                    child: Text('Error: $error',
                        style: context.typography.bodyMedium)),
              ),
            ),
          ),
        ),
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
      WidgetRef ref, String serviceType, BoxConstraints constraints) {
    final isSubscribed = data['subscribed'] as bool? ?? false;
    final plan = data['plan'] as Map<String, dynamic>? ?? {};
    final theme = Theme.of(context);

    bool isServiceSubscribed = isSubscribed &&
        (plan['category'] as String?)?.toLowerCase() ==
            serviceType.toLowerCase();

    if (plan.isEmpty && isSubscribed) {
      return SizedBox(
        height: constraints.maxHeight,
        child: Center(
            child: Text('Subscription data is incomplete',
                style: context.typography.bodyMedium)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            isServiceSubscribed ? 'Your Current Plan' : 'Available Plans',
            style: context.typography.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.primary,
            ),
          ),
        ),
        SizedBox(height: context.space.space_200),
        if (isServiceSubscribed) ...[
          SizedBox(height: context.space.space_200),
          Center(child: _buildSubscribedView(data, theme, context)),
          SizedBox(height: context.space.space_200),
        ] else ...[
          _buildAvailablePlans(context, ref, serviceType, theme, constraints),
        ],
      ],
    );
  }



  Widget _buildSubscribedView(
      Map<String, dynamic> data, ThemeData theme, BuildContext context) {
    final plan = data['plan'] as Map<String, dynamic>;
    final vendors = data['vendors'] as List<dynamic>? ?? [];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.space.space_100)),
      child: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan['name'] as String,
                  style: context.typography.bodyLarge
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.space.space_100,
                    vertical: context.space.space_50,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(context.space.space_50),
                  ),
                  child: Text(
                    'Active',
                    style: context.typography.bodySmall.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.space.space_100),
            Text(
              'Price: ${plan['price'] == 'N/A' ? 'Free' : plan['price']}',
              style: context.typography.bodyMedium,
            ),
            SizedBox(height: context.space.space_100),
            Text(
              'Start Date: ${plan['start_date']}',
              style: context.typography.bodyMedium,
            ),
            SizedBox(height: context.space.space_100),
            Text(
              'End Date: ${plan['end_date']}',
              style: context.typography.bodyMedium,
            ),
            SizedBox(height: context.space.space_200),
            Text(
              'Vendors:',
              style: context.typography.bodyMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.space.space_100),
            if (vendors.isEmpty)
              Text(
                'No vendors available',
                style: context.typography.bodyMedium
                    .copyWith(color: const Color(0xff7D7D7D)),
              )
            else
              ...vendors.map((vendor) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${vendor['name']}',
                        style: context.typography.bodyMedium,
                      ),
                      SizedBox(height: context.space.space_100),
                      Text(
                        'Contact: ${vendor['contact']}',
                        style: context.typography.bodyMedium,
                      ),
                      SizedBox(height: context.space.space_100),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailablePlans(BuildContext context, WidgetRef ref,
      String serviceType, ThemeData theme, BoxConstraints constraints) {
    final plansAsync = ref.watch(planNotifierProvider(serviceType));

    return plansAsync.when(
      data: (plans) => plans.isEmpty
          ? SizedBox(
              height: constraints.maxHeight,
              child: Center(
                  child: Text('No plans available',
                      style: context.typography.bodyMedium)),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showUpgradeOptions) ...[
                  Padding(
                    padding: EdgeInsets.only(bottom: context.space.space_200),
                    child: Text(
                      'Available ${_formatServiceType(serviceType)} Plans',
                      style: context.typography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ],
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    final plan = plans[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.only(bottom: context.space.space_200),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(context.space.space_100)),
                      child: Padding(
                        padding: EdgeInsets.all(context.space.space_200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  plan.name,
                                  style: context.typography.bodyLarge
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                if (showUpgradeOptions)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.space.space_100,
                                      vertical: context.space.space_50,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colors.background
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          context.space.space_50),
                                    ),
                                    child: Text(
                                      'Upgrade Option',
                                      style:
                                          context.typography.bodySmall.copyWith(
                                        color: context.colors.primaryTxt,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: context.space.space_100),
                            Text(
                              'Price: ${plan.price}',
                              style: context.typography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colors.primary,
                              ),
                            ),
                            SizedBox(height: context.space.space_100),
                            Text(
                              'Service Type: ${_formatServiceType(plan.serviceType)}',
                              style: context.typography.bodyMedium,
                            ),
                            SizedBox(height: context.space.space_100),
                            Text(
                              'Duration: ${plan.duration}',
                              style: context.typography.bodyMedium,
                            ),
                            if (plan.description != null &&
                                plan.description!.isNotEmpty) ...[
                              SizedBox(height: context.space.space_100),
                              Text(
                                'Features:',
                                style: context.typography.bodyMedium
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: context.space.space_100),
                              Text(
                                plan.description!,
                                style: context.typography.bodyMedium
                                    .copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                            SizedBox(height: context.space.space_200),
                            SizedBox(
                              width: constraints.maxWidth * 0.6,
                              child: ButtonWidget(
                                label: showUpgradeOptions
                                    ? 'Upgrade to This Plan'
                                    : 'Subscribe',
                                onTap: () {
                                  if (showUpgradeOptions) {
                                    _showUpgradeConfirmationDialog(
                                        context, plan);
                                  } else {
                                    _showSubscribeConfirmationDialog(
                                        context, plan);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
      loading: () => SizedBox(
        height: constraints.maxHeight,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SizedBox(
        height: constraints.maxHeight,
        child: Center(
            child: Text('Error loading plans: $error',
                style: context.typography.bodyMedium)),
      ),
    );
  }

  void _showUpgradeConfirmationDialog(BuildContext context, dynamic plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade Plan'),
        content: Text(
            'Are you sure you want to upgrade to ${plan.name}?\n\nPrice: ${plan.price}\nDuration: ${plan.duration}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual upgrade logic
              SnackbarUtil.showsnackbar(
                  message:
                      'Upgrading to ${plan.name}... (Not implemented yet)');
            },
            child: Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  void _showSubscribeConfirmationDialog(BuildContext context, dynamic plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Subscribe to Plan'),
        content: Text(
            'Are you sure you want to subscribe to ${plan.name}?\n\nPrice: ${plan.price}\nDuration: ${plan.duration}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual subscription logic
              SnackbarUtil.showsnackbar(
                  message:
                      'Subscribing to ${plan.name}... (Not implemented yet)');
            },
            child: Text('Subscribe Now'),
          ),
        ],
      ),
    );
  }
}
