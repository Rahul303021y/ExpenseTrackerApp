/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 19:57
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_manager.dart';
enum LocaleKeys {
  appName,
  quote,
  home,
  transactions,
  settings,
  income,
  expense,
  total,
  description,
  date,
  paymentMode,
  deleteTransaction,
  thisActionCantBeUndone,
  cancel,
  delete,
  save,
  edit,
  search,
  loading,
  noDataFound,
  availableBalance,
  pleaseEnterATitle,
  pleaseEnterAValidAmount,
  pleaseSelectACategory,
  pleaseSelectAPaymentMode,
  pleaseSelectATransactionType,
  pleaseSelectSpentAt,
  expenseAddedSuccessfully,
  expenseSavedButAttachmentUploadFailed,
  addExpense,
  titleUpperCase,
  addYourTitleHere,
  category,
  failedToLoadCategories,
  select,
  paymentModeUpperCase,
  failedToLoadPaymentModes,
  transactionTypeUpperCase,
  transactionType,
  amountUpperCase,
  dateUpperCase,
  spentAtUpperCase,
  failedToLoadSpentAt,
  egMorning,
  invoiceUpperCase,
  addInvoice,
  descriptionUpperCase,
  addYourDescriptionHere,
  initial,
  imageDownloadedSuccessfully,
  failedToLoadImage,
  failedToDownloadImage,
  download,
  transactionHistory,
  seeAll,
  transactionDetails,
  goodDay,
  failedToOpenPDF,
  status,
  from,
  to,
  spentAt,
  createdOn,
  lastEdited,
  attachments,
  deleting,
  areYouSureYouWantToDeleteThisTransaction,
  loginFailed,
  login,
  emailAddress,
  enterYourEmailAddress,
  password,
  enterYourPassword,
  loginUpperCases,
  passwordRecoveryComingSoon,
  forgotPassword,
  getStarted,
  categoryUpperCase
}

extension LocaleKeysExtension on LocaleKeys {
  String tr(BuildContext context) {
    return context.read<LanguageManager>().translate(name);
  }
}