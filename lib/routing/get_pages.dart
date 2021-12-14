import 'package:ajbell/ui/account/overview/account_history_list_screen/account_history_list_screen.dart';
import 'package:ajbell/ui/account/overview/account_overview_screen.dart';
import 'package:ajbell/ui/account/overview/investment_portfolio_history_list_screen/investment_portfolio_history_list_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_gia/summary/withdrawal_summary_gia_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_gia/withdrawal_cash_gia_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_isa/summary/withdrawal_summary_isa_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_isa/withdrawal_cash_isa_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_lisa/summary/withdrawal_summary_lisa_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_cash_lisa/withdrawal_cash_lisa_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_lisa_warning/withdrawal_home_purchase_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_lisa_warning/withdrawal_lisa_warning_screen.dart';
import 'package:ajbell/ui/account/withdrawal_cash/withdrawal_result_screen.dart';
import 'package:ajbell/ui/account_chooser/select_account/select_account_screen.dart';
import 'package:ajbell/ui/add_cash/add_cash_screen/add_cash_screen.dart';
import 'package:ajbell/ui/add_cash/cash_added_screen/cash_added_screen.dart';
import 'package:ajbell/ui/decider/decider_screen.dart';
import 'package:ajbell/ui/root/home/browse_accounts/choose_account_screen.dart';
import 'package:ajbell/ui/root/invest/invest_tab/invest_tab_screen.dart';
import 'package:ajbell/ui/root/invest/investments_funds/investments_funds_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/etf/etf_purchase/etf_purchase_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/etf/etf_recap/etf_recap_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/fund/fund_purchase/fund_purchase_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/fund/fund_recap/fund_recap_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/loader/invest_loader_page.dart';
import 'package:ajbell/ui/root/invest/purchase/purchase_result_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/shares/shares_purchase_screen.dart';
import 'package:ajbell/ui/root/invest/purchase/shares/shares_recap/share_recap_screen.dart';
import 'package:ajbell/ui/root/invest/sell/etf/etf_sell/etf_sell_screen.dart';
import 'package:ajbell/ui/root/invest/sell/etf/etf_sell_recap/etf_sell_recap_screen.dart';
import 'package:ajbell/ui/root/invest/sell/fund_review_order/fund_review_order_screen.dart';
import 'package:ajbell/ui/root/invest/sell/fund_sell_investment/fund_sell_investment_screen.dart';
import 'package:ajbell/ui/root/invest/sell/sell_order_loader/sell_loader_screen.dart';
import 'package:ajbell/ui/root/invest/sell/sell_result_screen.dart';
import 'package:ajbell/ui/root/invest/sell/share_review_order/share_review_order_screen.dart';
import 'package:ajbell/ui/root/invest/sell/share_sell_investment/share_sell_investment_screen.dart';
import 'package:ajbell/ui/root/invest/shares/shares_screen.dart';
import 'package:ajbell/ui/root/invest/shares_detail/shares_detail_screen.dart';
import 'package:ajbell/ui/root/learn/learn_tab_screen.dart';
import 'package:ajbell/ui/root/root_screen.dart';
import 'package:ajbell/ui/root/settings/accounts_carousel_test_webview/accounts_carousel_test_webview_screen.dart';
import 'package:ajbell/ui/welcome/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

/// Facade of the main routing pages

List<GetPage> getPages = [
  GetPage(name: "/", page: () => DeciderScreen()),
  GetPage(name: BrowseAccountScreen.routeName, page: () => BrowseAccountScreen()),
  GetPage(name: SharesPurchaseOncePage.routeName, page: () => SharesPurchaseOncePage()),
  GetPage(name: FundPurchaseOncePage.routeName, page: () => FundPurchaseOncePage()),
  GetPage(name: FundSellInvestmentScreen.routeName, page: () => FundSellInvestmentScreen()),
  GetPage(name: ShareSellInvestmentScreen.routeName, page: () => ShareSellInvestmentScreen()),
  GetPage(name: EtfSellPage.routeName, page: () => EtfSellPage()),
  GetPage(name: FundReviewOrderScreen.routeName, page: () => FundReviewOrderScreen()),
  GetPage(name: ShareReviewOrderScreen.routeName, page: () => ShareReviewOrderScreen()),
  GetPage(name: EtfSellRecapScreen.routeName, page: () => EtfSellRecapScreen()),
  GetPage(name: SellResultScreen.routeName, page: () => SellResultScreen()),
  GetPage(name: FundRecapPage.routeName, page: () => FundRecapPage()),
  GetPage(name: ShareRecapPage.routeName, page: () => ShareRecapPage()),
  GetPage(name: SharesScreen.routeName, page: () => SharesScreen()),
  GetPage(name: InvestmentsFundsScreen.routeName, page: () => InvestmentsFundsScreen()),
  GetPage(name: WithdrawalLisaWarningScreen.routeName, page: () => WithdrawalLisaWarningScreen()),
  GetPage(name: WithdrawalHomePurchaseScreen.routeName, page: () => WithdrawalHomePurchaseScreen()),
  GetPage(name: WithdrawalCashISAScreen.routeName, page: () => WithdrawalCashISAScreen()),
  GetPage(name: WithdrawalCashLISAScreen.routeName, page: () => WithdrawalCashLISAScreen()),
  GetPage(name: WithdrawalCashGIAScreen.routeName, page: () => WithdrawalCashGIAScreen()),
  GetPage(name: WithdrawalSummaryISAScreen.routeName, page: () => WithdrawalSummaryISAScreen()),
  GetPage(name: WithdrawalSummaryLISAScreen.routeName, page: () => WithdrawalSummaryLISAScreen()),
  GetPage(name: WithdrawalSummaryGIAScreen.routeName, page: () => WithdrawalSummaryGIAScreen()),
  GetPage(name: WithdrawalResultScreen.routeName, page: () => WithdrawalResultScreen()),
  GetPage(name: AccountOverviewScreen.routeName, page: () => AccountOverviewScreen()),
  GetPage(name: RootScreen.routeName, page: () => RootScreen()),
  GetPage(name: AccountsCarouselTestWebViewScreen.routeName, page: () => AccountsCarouselTestWebViewScreen()),
  GetPage(name: SharesDetailScreen.routeName, page: () => SharesDetailScreen()),
  GetPage(name: EtfPurchaseOncePage.routeName, page: () => EtfPurchaseOncePage()),
  GetPage(name: EtfRecapPage.routeName, page: () => EtfRecapPage()),
  GetPage(name: SelectAccountPage.routeName, page: () => SelectAccountPage()),
  GetPage(name: AddCashScreen.routeName, page: () => AddCashScreen()),
  GetPage(name: CashAddedScreen.routeName, page: () => CashAddedScreen()),
  GetPage(name: PurchaseResultScreen.routeName, page: () => PurchaseResultScreen()),
  GetPage(name: LearnTabScreen.learnTabRoot, page: () => LearnTabScreen()),
  GetPage(name: InvestTabScreen.investTabRoot, page: () => InvestTabScreen()),
  GetPage(name: AccountHistoryListScreen.routeName, page: () => AccountHistoryListScreen()),
  GetPage(name: InvestLoaderPage.routeName, page: () => InvestLoaderPage()),
  GetPage(name: SellLoaderPage.routeName, page: () => SellLoaderPage()),
  GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
  GetPage(name: InvestmentPortfolioHistoryListScreen.routeName, page: () => InvestmentPortfolioHistoryListScreen()),
];
