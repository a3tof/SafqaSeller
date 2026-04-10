import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/features/wallet/view/deposit_view.dart';
import 'package:safqaseller/features/wallet/view/saved_cards_view.dart';
import 'package:safqaseller/features/wallet/view/transaction_history_view.dart';
import 'package:safqaseller/features/wallet/view/widgets/wallet_skeleton_data.dart';
import 'package:safqaseller/features/wallet/view/widgets/transaction_item.dart';
import 'package:safqaseller/features/wallet/view/widgets/wallet_action_button.dart';
import 'package:safqaseller/features/wallet/view/withdrawal_view.dart';
import 'package:safqaseller/features/wallet/view_model/wallet/wallet_view_model.dart';
import 'package:safqaseller/features/wallet/view_model/wallet/wallet_view_model_state.dart';
import 'package:safqaseller/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WalletViewBody extends StatefulWidget {
  const WalletViewBody({super.key});

  @override
  State<WalletViewBody> createState() => _WalletViewBodyState();
}

class _WalletViewBodyState extends State<WalletViewBody> {
  bool _isBalanceVisible = true;

  Future<void> _openRoute(String routeName) async {
    await Navigator.pushNamed(context, routeName);
    if (!mounted) return;
    await context.read<WalletViewModel>().loadWallet();
  }

  String _formatBalance(double balance) {
    if (!_isBalanceVisible) {
      return 'EGP ••••';
    }

    final locale = Localizations.localeOf(context).toLanguageTag();
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: 'EGP ',
      decimalDigits: balance == balance.roundToDouble() ? 0 : 2,
    );
    return formatter.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context: context, title: S.of(context).kWallet),
      body: BlocBuilder<WalletViewModel, WalletState>(
        builder: (context, state) {
          final isLoading = state is WalletLoading || state is WalletInitial;

          if (state is WalletError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyles.regular16(context),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<WalletViewModel>().loadWallet(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: Text(
                        S.of(context).retry,
                        style: TextStyles.semiBold16(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final wallet = state is WalletSuccess
              ? state
              : WalletSuccess(
                  balance: WalletSkeletonData.balance,
                  cards: WalletSkeletonData.cards,
                  transactions: WalletSkeletonData.transactions,
                );
          final transactions = wallet.transactions.take(4).toList();

          return Skeletonizer(
            enabled: isLoading,
            child: RefreshIndicator(
              onRefresh: context.read<WalletViewModel>().loadWallet,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final locale = Localizations.localeOf(context).toLanguageTag();
                  final maxContentWidth =
                      constraints.maxWidth > 700 ? 520.0 : 343.w;

                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxContentWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 28.h),
                            _BalanceSection(
                              title: S.of(context).walletBalance,
                              formattedBalance: _formatBalance(
                                wallet.balance.balance,
                              ),
                              isVisible: _isBalanceVisible,
                              onToggleVisibility: () {
                                setState(() {
                                  _isBalanceVisible = !_isBalanceVisible;
                                });
                              },
                            ),
                            SizedBox(height: 34.h),
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16.w,
                                runSpacing: 16.h,
                                children: [
                                  WalletActionButton(
                                    icon: Icons.arrow_upward_rounded,
                                    label: S.of(context).kDepositNmoney,
                                    onTap: () => _openRoute(DepositView.routeName),
                                    backgroundColor: const Color(0xFFE7F6EC),
                                    iconColor: const Color(0xFF00762E),
                                  ),
                                  WalletActionButton(
                                    icon: Icons.account_balance_wallet_outlined,
                                    label: S.of(context).kWithdrawalNmoney,
                                    onTap: () =>
                                        _openRoute(WithdrawalView.routeName),
                                    backgroundColor: const Color(0xFFFDEBEC),
                                    iconColor: const Color(0xFFBA1A1A),
                                  ),
                                  WalletActionButton(
                                    icon: Icons.credit_card_rounded,
                                    label: S.of(context).savedCards,
                                    onTap: () =>
                                        _openRoute(SavedCardsView.routeName),
                                    backgroundColor: AppColors.secondaryColor,
                                    iconColor: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    S.of(context).kTransactionHistory,
                                    style: TextStyles.medium20(
                                      context,
                                    ).copyWith(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _openRoute(
                                    TransactionHistoryView.routeName,
                                  ),
                                  child: Text(
                                    S.of(context).seeAll,
                                    style: TextStyles.regular14(
                                      context,
                                    ).copyWith(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            if (transactions.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.h),
                                child: Center(
                                  child: Text(
                                    S.of(context).kNoTransactionsYet,
                                    style: TextStyles.regular14(
                                      context,
                                    ).copyWith(color: Colors.grey),
                                  ),
                                ),
                              )
                            else ...[
                              Text(
                                DateFormat('d MMMM yyyy', locale).format(
                                  transactions.first.date,
                                ),
                                style: TextStyles.medium14(context).copyWith(
                                  color: const Color(0xFFAAAAAA),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              ...transactions.map(
                                (transaction) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: TransactionItem(
                                    transaction: transaction,
                                  ),
                                ),
                              ),
                            ],
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────────

class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
    required this.title,
    required this.formattedBalance,
    required this.isVisible,
    required this.onToggleVisibility,
  });

  final String title;
  final String formattedBalance;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.regular16(
                context,
              ).copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(width: 8.w),
            InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: onToggleVisibility,
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: Icon(
                  isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          formattedBalance,
          textAlign: TextAlign.center,
          style: TextStyles.bold28(context).copyWith(
            color: Colors.black,
            fontSize: 34.sp,
          ),
        ),
      ],
    );
  }
}
