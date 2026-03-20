class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.name,
    required this.price,
    required this.features,
    required this.ctaLabel,
  });

  final String name;
  final String price;
  final List<String> features;
  final String ctaLabel;

  static const List<SubscriptionPlanModel> plans = [
    SubscriptionPlanModel(
      name: 'Basic',
      price: '99\$',
      features: [
        'Appears at the top of search results for 24 hours',
        '"Featured" badge on your auction',
        'Highlighted card color to attract buyers',
      ],
      ctaLabel: 'Boost Now',
    ),
    SubscriptionPlanModel(
      name: 'Premium',
      price: '499\$',
      features: [
        'Appears at the top of search results for 3 days',
        'Push notifications sent to interested buyers',
        '"Featured" badge & highlighted card',
        'Basic Analytics (Track your daily views)',
      ],
      ctaLabel: 'Upgrade to Premium',
    ),
    SubscriptionPlanModel(
      name: 'Elite',
      price: '999\$',
      features: [
        'Pinned as a Top Banner on the homepage for 7 days',
        'Instant push notifications to all interested buyers',
        '"Featured" badge on your auction',
        'Detailed Analytics (Views, clicks, and active bidders)',
      ],
      ctaLabel: 'Go Elite',
    ),
  ];
}
