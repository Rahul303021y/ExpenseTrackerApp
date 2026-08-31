class AppConstants{
  static const String baseUrl = "https://expensetrackerservice-ha8p.onrender.com";
  static const String loginUrl = "/auth/login";
  static const String refreshTokenUrl = "/auth/refresh-token";

  static const String addExpenseUrl = "/expense/add-update-expense";
  static const String addExpenseAttachmentUrl = "/expense-attachment/upload";
  static const String getExpenseCategoriesUrl = "/expense-category";
  static const String getExpensePaymentTypeUrl = "/payment-type";
  static const String getAllTimeOfDayUrl = "/time-of-day";
  static const String getAttachmentsUrl = "/expense-attachment/expense/";
  static const String downloadAttachmentUrl = "/expense-attachment/view/";
  static const String getExpensesUrl = "/expense/get-all-expenses";
  static const String fetchAccountSummaryUrl = "/account-summary/get-monthly-summary";
  static const String deleteExpenseUrl = "/expense/delete-expense/";
}