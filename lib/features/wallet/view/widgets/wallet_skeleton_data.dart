import 'package:safqaseller/features/wallet/model/models/wallet_models.dart';

abstract class WalletSkeletonData {
  static const balance = WalletBalance(balance: 200);

  static final cards = List<CardModel>.generate(
    3,
    (index) => CardModel(
      id: index + 1,
      cardholderName: 'Card Holder',
      last4: '1234',
      expiryDate: '12/30',
      label: 'Master Card',
    ),
  );

  static final transactions = List<TransactionModel>.generate(
    4,
    (index) => TransactionModel(
      id: index + 1,
      title: index.isEven ? 'Cash Withdrawal' : 'Cash Deposit',
      amount: 20129,
      date: DateTime(2022, 4, 13),
      type: index.isEven ? TransactionType.withdrawal : TransactionType.deposit,
    ),
  );
}
