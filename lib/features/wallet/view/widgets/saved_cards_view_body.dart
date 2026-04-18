import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/wallet/view/add_card_view.dart';
import 'package:safqaseller/features/wallet/view/widgets/card_list_item.dart';
import 'package:safqaseller/features/wallet/view/widgets/wallet_skeleton_data.dart';
import 'package:safqaseller/features/wallet/view_model/wallet/wallet_view_model.dart';
import 'package:safqaseller/features/wallet/view_model/wallet/wallet_view_model_state.dart';
import 'package:safqaseller/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SavedCardsViewBody extends StatelessWidget {
  const SavedCardsViewBody({super.key});

  Future<void> _refresh(BuildContext context) async {
    await context.read<WalletViewModel>().loadWallet();
  }

  Future<void> _openAddCard(BuildContext context) async {
    final cardAdded = await Navigator.pushNamed(context, AddCardView.routeName);
    if (!context.mounted || cardAdded != true) return;
    await _refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary, size: 22.sp),
        ),
        title: Text(
          'Saved Cards',
          style: TextStyle(
            fontFamily: 'AlegreyaSC',
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _openAddCard(context),
            icon: Icon(Icons.add_rounded,
                color: Theme.of(context).colorScheme.primary, size: 28.sp),
          ),
        ],
      ),
      body: BlocBuilder<WalletViewModel, WalletState>(
        builder: (context, state) {
          final isLoading = state is WalletLoading || state is WalletInitial;
          if (state is WalletError) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                children: [
                  SizedBox(height: 160.h),
                  Center(child: Text(state.message)),
                ],
              ),
            );
          }

          final cards = state is WalletSuccess
              ? state.cards
              : WalletSkeletonData.cards;

          if (cards.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                children: [
                  SizedBox(height: 160.h),
                  Column(
                    children: [
                      Icon(Icons.credit_card_off_outlined,
                          size: 64.sp, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text(S.of(context).kNoSavedCards,
                          style: TextStyles.regular16(context)
                              .copyWith(color: Colors.grey)),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => _openAddCard(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary),
                        child: Text(S.of(context).kAddCard,
                            style: TextStyles.semiBold16(context)
                                .copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: cards.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, thickness: 0.5),
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: CardListItem(
                    card: cards[i],
                    onDelete: () =>
                        context.read<WalletViewModel>().deleteCard(cards[i].id),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
