@isTest
private with sharing class PaymentTransactionControllerTest {

  static testMethod void getRepaymentSchedule() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
    serv_Cal.servicecal__New_Loan_Amount__c = 100000;
    serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
    serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
    serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
    serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1887.12;
    serv_Cal.servicecal__Country_of_Residence__c = 'India';
    serv_Cal.servicecal__Foreign_Currency__c = '0';
    serv_Cal.servicecal__Foreign_Currency_Exchange_Rate__c = 0;
    serv_Cal.servicecal__Couples__c = 0;
    serv_Cal.servicecal__Children__c  = 0;
    serv_Cal.servicecal__Applicant_1_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Applicant_2_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_TNMI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_TNM__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Company_1_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_GFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_GFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_NFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_AGI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_TNMI__c = 1000;
    serv_Cal.servicecal__Total_GFI__c = 1000;
    serv_Cal.servicecal__Total_NFI__c = 1000;
    serv_Cal.servicecal__Total_AGI__c = 1000;
    serv_Cal.servicecal__Total_Gross_Income__c = 1000;
    serv_Cal.servicecal__Total_Net_Income__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_AUD__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_FC__c = 1000;
    serv_Cal.servicecal__Living_Expenses_Used__c = 1000;
    serv_Cal.servicecal__Total_income_available_for_debt__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_ADL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_AMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_D_L__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCDL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_MP__c = 1000;
    serv_Cal.servicecal__Overdraft_ADL__c = 1000;
    serv_Cal.servicecal__Overdraft_AMP__c = 1000;
    serv_Cal.servicecal__Overdraft_D_L__c = 1000;
    serv_Cal.servicecal__Overdraft_FCDL__c = 1000;
    serv_Cal.servicecal__Overdraft_FCMP__c = 1000;
    serv_Cal.servicecal__Overdraft_MP__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Lease_Hp_ADL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_AMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_D_L__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCDL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_MP__c = 1000;
    serv_Cal.servicecal__Other_ADL__c = 1000;
    serv_Cal.servicecal__Other_AMP__c = 1000;
    serv_Cal.servicecal__Other_D_L__c = 1000;
    serv_Cal.servicecal__Other_FCDL__c = 1000;
    serv_Cal.servicecal__Other_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_AMP__c = 1000;
    serv_Cal.servicecal__Child_Support_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_MP__c = 1000;
    serv_Cal.servicecal__Rent_Board_AMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_FCMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_MP__c = 1000;
    serv_Cal.servicecal__Total_FCMP__c = 1000;
    serv_Cal.servicecal__Total_AMP__c = 1000;
    serv_Cal.servicecal__Total_Commitments_AUD__c = 1000;
    serv_Cal.servicecal__Total_Commitments_Foreign_Currency__c = 1000;
    serv_Cal.servicecal__Total_Net_Commitments__c = 1000;
    serv_Cal.servicecal__Interest_Only_Term_Years__c ='5';
    serv_Cal.servicecal__Net_Disposable_Income__c = 1000;
    serv_Cal.servicecal__Loan_Assesment_Rate_minimum_7__c = 1000;
    serv_Cal.servicecal__minus_Existing_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__Single_Adult__c = 1000;
    serv_Cal.servicecal__Total_Expenses__c = 1000;
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR_t__c = 'True';
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR__c = 1000;
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_1__c ='True';
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_2__c  = 1000;
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_1__c = 'True';
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_2__c = 1000;
    serv_Cal.servicecal__Overall_Result__c = 'True';
    Database.SaveResult res3 = Database.insert(serv_Cal,false);

    servicecal__Amortization_Result__c ammort_result = new servicecal__Amortization_Result__c();
    ammort_result.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result.servicecal__Interest__c = 1000;
    ammort_result.servicecal__Opening_Balance__c  = 1000;
    ammort_result.servicecal__Closing_Balance__c = 1000;
    ammort_result.servicecal__Payment__c = 1000;
    ammort_result.servicecal__Principal__c = 1000;
    ammort_result.servicecal__Payment_Number__c = 1000;
    ammort_result.servicecal__Remaining__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result,false);

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 1000;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 1000;
    Database.SaveResult res5 = Database.insert(pt,false);

    Test.startTest();
    LMS.ConvertToLoan(serv_Cal.Id);
    PaymentTransactionController.getRepaymentSchedule(pt.lms2__Loan_Account_No__c);
    Test.stopTest();

  }

  static testMethod void doPaymentCondition1() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
    serv_Cal.servicecal__New_Loan_Amount__c = 100000;
    serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
    serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
    serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
    serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1887.12;
    serv_Cal.servicecal__Country_of_Residence__c = 'India';
    serv_Cal.servicecal__Foreign_Currency__c = '0';
    serv_Cal.servicecal__Foreign_Currency_Exchange_Rate__c = 0;
    serv_Cal.servicecal__Couples__c = 0;
    serv_Cal.servicecal__Children__c  = 0;
    serv_Cal.servicecal__Applicant_1_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Applicant_2_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_TNMI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_TNM__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Company_1_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_GFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_GFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_NFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_AGI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_TNMI__c = 1000;
    serv_Cal.servicecal__Total_GFI__c = 1000;
    serv_Cal.servicecal__Total_NFI__c = 1000;
    serv_Cal.servicecal__Total_AGI__c = 1000;
    serv_Cal.servicecal__Total_Gross_Income__c = 1000;
    serv_Cal.servicecal__Total_Net_Income__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_AUD__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_FC__c = 1000;
    serv_Cal.servicecal__Living_Expenses_Used__c = 1000;
    serv_Cal.servicecal__Total_income_available_for_debt__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_ADL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_AMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_D_L__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCDL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_MP__c = 1000;
    serv_Cal.servicecal__Overdraft_ADL__c = 1000;
    serv_Cal.servicecal__Overdraft_AMP__c = 1000;
    serv_Cal.servicecal__Overdraft_D_L__c = 1000;
    serv_Cal.servicecal__Overdraft_FCDL__c = 1000;
    serv_Cal.servicecal__Overdraft_FCMP__c = 1000;
    serv_Cal.servicecal__Overdraft_MP__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Lease_Hp_ADL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_AMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_D_L__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCDL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_MP__c = 1000;
    serv_Cal.servicecal__Other_ADL__c = 1000;
    serv_Cal.servicecal__Other_AMP__c = 1000;
    serv_Cal.servicecal__Other_D_L__c = 1000;
    serv_Cal.servicecal__Other_FCDL__c = 1000;
    serv_Cal.servicecal__Other_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_AMP__c = 1000;
    serv_Cal.servicecal__Child_Support_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_MP__c = 1000;
    serv_Cal.servicecal__Rent_Board_AMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_FCMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_MP__c = 1000;
    serv_Cal.servicecal__Total_FCMP__c = 1000;
    serv_Cal.servicecal__Total_AMP__c = 1000;
    serv_Cal.servicecal__Total_Commitments_AUD__c = 1000;
    serv_Cal.servicecal__Total_Commitments_Foreign_Currency__c = 1000;
    serv_Cal.servicecal__Total_Net_Commitments__c = 1000;
    serv_Cal.servicecal__Interest_Only_Term_Years__c ='5';
    serv_Cal.servicecal__Net_Disposable_Income__c = 1000;
    serv_Cal.servicecal__Loan_Assesment_Rate_minimum_7__c = 1000;
    serv_Cal.servicecal__minus_Existing_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__Single_Adult__c = 1000;
    serv_Cal.servicecal__Total_Expenses__c = 1000;
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR_t__c = 'True';
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR__c = 1000;
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_1__c ='True';
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_2__c  = 1000;
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_1__c = 'True';
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_2__c = 1000;
    serv_Cal.servicecal__Overall_Result__c = 'True';
    Database.SaveResult res3 = Database.insert(serv_Cal,false);

    servicecal__Amortization_Result__c ammort_result1 = new servicecal__Amortization_Result__c();
    ammort_result1.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result1.servicecal__Interest__c = 1000;
    ammort_result1.servicecal__Opening_Balance__c  = 1000;
    ammort_result1.servicecal__Closing_Balance__c = 1000;
    ammort_result1.servicecal__Payment__c = 1000;
    ammort_result1.servicecal__Principal__c = 1000;
    ammort_result1.servicecal__Payment_Number__c = 1;
    ammort_result1.servicecal__Remaining__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    servicecal__Amortization_Result__c ammort_result2 = new servicecal__Amortization_Result__c();
    ammort_result2.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result2.servicecal__Interest__c = 1000;
    ammort_result2.servicecal__Opening_Balance__c  = 1000;
    ammort_result2.servicecal__Closing_Balance__c = 1000;
    ammort_result2.servicecal__Payment__c = 1000;
    ammort_result2.servicecal__Principal__c = 1000;
    ammort_result2.servicecal__Payment_Number__c = 2;
    ammort_result2.servicecal__Remaining__c = 4;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 0;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 2000;


    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(serv_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'false');
    Test.stopTest();

  }

  static testMethod void doPaymentCondition2() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
    serv_Cal.servicecal__New_Loan_Amount__c = 100000;
    serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
    serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
    serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
    serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1887.12;
    serv_Cal.servicecal__Country_of_Residence__c = 'India';
    serv_Cal.servicecal__Foreign_Currency__c = '0';
    serv_Cal.servicecal__Foreign_Currency_Exchange_Rate__c = 0;
    serv_Cal.servicecal__Couples__c = 0;
    serv_Cal.servicecal__Children__c  = 0;
    serv_Cal.servicecal__Applicant_1_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Applicant_2_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_TNMI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_TNM__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Company_1_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_GFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_GFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_NFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_AGI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_TNMI__c = 1000;
    serv_Cal.servicecal__Total_GFI__c = 1000;
    serv_Cal.servicecal__Total_NFI__c = 1000;
    serv_Cal.servicecal__Total_AGI__c = 1000;
    serv_Cal.servicecal__Total_Gross_Income__c = 1000;
    serv_Cal.servicecal__Total_Net_Income__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_AUD__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_FC__c = 1000;
    serv_Cal.servicecal__Living_Expenses_Used__c = 1000;
    serv_Cal.servicecal__Total_income_available_for_debt__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_ADL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_AMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_D_L__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCDL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_MP__c = 1000;
    serv_Cal.servicecal__Overdraft_ADL__c = 1000;
    serv_Cal.servicecal__Overdraft_AMP__c = 1000;
    serv_Cal.servicecal__Overdraft_D_L__c = 1000;
    serv_Cal.servicecal__Overdraft_FCDL__c = 1000;
    serv_Cal.servicecal__Overdraft_FCMP__c = 1000;
    serv_Cal.servicecal__Overdraft_MP__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Lease_Hp_ADL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_AMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_D_L__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCDL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_MP__c = 1000;
    serv_Cal.servicecal__Other_ADL__c = 1000;
    serv_Cal.servicecal__Other_AMP__c = 1000;
    serv_Cal.servicecal__Other_D_L__c = 1000;
    serv_Cal.servicecal__Other_FCDL__c = 1000;
    serv_Cal.servicecal__Other_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_AMP__c = 1000;
    serv_Cal.servicecal__Child_Support_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_MP__c = 1000;
    serv_Cal.servicecal__Rent_Board_AMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_FCMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_MP__c = 1000;
    serv_Cal.servicecal__Total_FCMP__c = 1000;
    serv_Cal.servicecal__Total_AMP__c = 1000;
    serv_Cal.servicecal__Total_Commitments_AUD__c = 1000;
    serv_Cal.servicecal__Total_Commitments_Foreign_Currency__c = 1000;
    serv_Cal.servicecal__Total_Net_Commitments__c = 1000;
    serv_Cal.servicecal__Interest_Only_Term_Years__c ='5';
    serv_Cal.servicecal__Net_Disposable_Income__c = 1000;
    serv_Cal.servicecal__Loan_Assesment_Rate_minimum_7__c = 1000;
    serv_Cal.servicecal__minus_Existing_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__Single_Adult__c = 1000;
    serv_Cal.servicecal__Total_Expenses__c = 1000;
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR_t__c = 'True';
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR__c = 1000;
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_1__c ='True';
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_2__c  = 1000;
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_1__c = 'True';
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_2__c = 1000;
    serv_Cal.servicecal__Overall_Result__c = 'True';
    Database.SaveResult res3 = Database.insert(serv_Cal,false);

    servicecal__Amortization_Result__c ammort_result1 = new servicecal__Amortization_Result__c();
    ammort_result1.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result1.servicecal__Interest__c = 1000;
    ammort_result1.servicecal__Opening_Balance__c  = 1000;
    ammort_result1.servicecal__Closing_Balance__c = 1000;
    ammort_result1.servicecal__Payment__c = 1887.12;
    ammort_result1.servicecal__Principal__c = 1000;
    ammort_result1.servicecal__Payment_Number__c = 1;
    ammort_result1.servicecal__Remaining__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    servicecal__Amortization_Result__c ammort_result2 = new servicecal__Amortization_Result__c();
    ammort_result2.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result2.servicecal__Interest__c = 1000;
    ammort_result2.servicecal__Opening_Balance__c  = 1000;
    ammort_result2.servicecal__Closing_Balance__c = 1000;
    ammort_result2.servicecal__Payment__c = 1887.12;
    ammort_result2.servicecal__Principal__c = 1000;
    ammort_result2.servicecal__Payment_Number__c = 2;
    ammort_result2.servicecal__Remaining__c = 4;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);

    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 0;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 1887.12;
    pt.lms2__Loan__c = loan.Id;

    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(serv_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'false');
    Test.stopTest();

  }

  static testMethod void doPaymentCondition3() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
    serv_Cal.servicecal__New_Loan_Amount__c = 100000;
    serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
    serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
    serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
    serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1887.12;
    serv_Cal.servicecal__Country_of_Residence__c = 'India';
    serv_Cal.servicecal__Foreign_Currency__c = '0';
    serv_Cal.servicecal__Foreign_Currency_Exchange_Rate__c = 0;
    serv_Cal.servicecal__Couples__c = 0;
    serv_Cal.servicecal__Children__c  = 0;
    serv_Cal.servicecal__Applicant_1_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Applicant_2_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_TNMI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_TNM__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Company_1_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_GFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_GFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_NFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_AGI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_TNMI__c = 1000;
    serv_Cal.servicecal__Total_GFI__c = 1000;
    serv_Cal.servicecal__Total_NFI__c = 1000;
    serv_Cal.servicecal__Total_AGI__c = 1000;
    serv_Cal.servicecal__Total_Gross_Income__c = 1000;
    serv_Cal.servicecal__Total_Net_Income__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_AUD__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_FC__c = 1000;
    serv_Cal.servicecal__Living_Expenses_Used__c = 1000;
    serv_Cal.servicecal__Total_income_available_for_debt__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_ADL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_AMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_D_L__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCDL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_MP__c = 1000;
    serv_Cal.servicecal__Overdraft_ADL__c = 1000;
    serv_Cal.servicecal__Overdraft_AMP__c = 1000;
    serv_Cal.servicecal__Overdraft_D_L__c = 1000;
    serv_Cal.servicecal__Overdraft_FCDL__c = 1000;
    serv_Cal.servicecal__Overdraft_FCMP__c = 1000;
    serv_Cal.servicecal__Overdraft_MP__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Lease_Hp_ADL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_AMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_D_L__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCDL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_MP__c = 1000;
    serv_Cal.servicecal__Other_ADL__c = 1000;
    serv_Cal.servicecal__Other_AMP__c = 1000;
    serv_Cal.servicecal__Other_D_L__c = 1000;
    serv_Cal.servicecal__Other_FCDL__c = 1000;
    serv_Cal.servicecal__Other_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_AMP__c = 1000;
    serv_Cal.servicecal__Child_Support_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_MP__c = 1000;
    serv_Cal.servicecal__Rent_Board_AMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_FCMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_MP__c = 1000;
    serv_Cal.servicecal__Total_FCMP__c = 1000;
    serv_Cal.servicecal__Total_AMP__c = 1000;
    serv_Cal.servicecal__Total_Commitments_AUD__c = 1000;
    serv_Cal.servicecal__Total_Commitments_Foreign_Currency__c = 1000;
    serv_Cal.servicecal__Total_Net_Commitments__c = 1000;
    serv_Cal.servicecal__Interest_Only_Term_Years__c ='5';
    serv_Cal.servicecal__Net_Disposable_Income__c = 1000;
    serv_Cal.servicecal__Loan_Assesment_Rate_minimum_7__c = 1000;
    serv_Cal.servicecal__minus_Existing_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__Single_Adult__c = 1000;
    serv_Cal.servicecal__Total_Expenses__c = 1000;
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR_t__c = 'True';
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR__c = 1000;
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_1__c ='True';
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_2__c  = 1000;
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_1__c = 'True';
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_2__c = 1000;
    serv_Cal.servicecal__Overall_Result__c = 'True';
    Database.SaveResult res3 = Database.insert(serv_Cal,false);

    servicecal__Amortization_Result__c ammort_result1 = new servicecal__Amortization_Result__c();
    ammort_result1.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result1.servicecal__Interest__c = 1000;
    ammort_result1.servicecal__Opening_Balance__c  = 1000;
    ammort_result1.servicecal__Closing_Balance__c = 1000;
    ammort_result1.servicecal__Payment__c = 1000;
    ammort_result1.servicecal__Principal__c = 1000;
    ammort_result1.servicecal__Payment_Number__c = 1;
    ammort_result1.servicecal__Remaining__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    servicecal__Amortization_Result__c ammort_result2 = new servicecal__Amortization_Result__c();
    ammort_result2.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result2.servicecal__Interest__c = 1000;
    ammort_result2.servicecal__Opening_Balance__c  = 1000;
    ammort_result2.servicecal__Closing_Balance__c = 1000;
    ammort_result2.servicecal__Payment__c = 1000;
    ammort_result2.servicecal__Principal__c = 1000;
    ammort_result2.servicecal__Payment_Number__c = 2;
    ammort_result2.servicecal__Remaining__c = 4;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);
    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 0;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 200;
    pt.lms2__Loan__c = loan.Id;


    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(serv_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'false');
    Test.stopTest();

  }

  static testMethod void doPaymentCondition4() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
    quote_Cal.quoteCal__Amount_Financed__c = 100000;
    quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
    quote_Cal.quoteCal__Term_months__c = 60;
    quote_Cal.quoteCal__Desired_Base_Rate__c = 6;
    quote_Cal.quoteCal__Repayment_Expected_c__c = 1887.12;
    Database.SaveResult res3 = Database.insert(quote_Cal,false);

    quoteCal__Amortization_Schedule__c ammort_result1 = new quoteCal__Amortization_Schedule__c();
    ammort_result1.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result1.quoteCal__Interest__c = 1000;
    ammort_result1.quoteCal__Opening_Balance__c  = 1000;
    ammort_result1.quoteCal__Closing_Balance__c = 1000;
    ammort_result1.quoteCal__Payment__c = 1000;
    ammort_result1.quoteCal__Principal__c = 1000;
    ammort_result1.quoteCal__Repayment_Number__c = 1;
    ammort_result1.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    quoteCal__Amortization_Schedule__c ammort_result2 = new quoteCal__Amortization_Schedule__c();
    ammort_result2.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result2.quoteCal__Interest__c = 1000;
    ammort_result2.quoteCal__Opening_Balance__c  = 1000;
    ammort_result2.quoteCal__Closing_Balance__c = 1000;
    ammort_result2.quoteCal__Payment__c = 1000;
    ammort_result2.quoteCal__Principal__c = 1000;
    ammort_result2.quoteCal__Repayment_Number__c = 2;
    ammort_result2.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);

    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 0;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 1887.20;
    pt.lms2__Loan__c = loan.Id;

    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(quote_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'true');
    Test.stopTest();

  }

  static testMethod void doPaymentCondition5() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
    quote_Cal.quoteCal__Amount_Financed__c = 100000;
    quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
    quote_Cal.quoteCal__Term_months__c = 60;
    quote_Cal.quoteCal__Desired_Base_Rate__c = 6;
    quote_Cal.quoteCal__Repayment_Expected_c__c = 1887.12;
    Database.SaveResult res3 = Database.insert(quote_Cal,false);

    quoteCal__Amortization_Schedule__c ammort_result1 = new quoteCal__Amortization_Schedule__c();
    ammort_result1.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result1.quoteCal__Interest__c = 1000;
    ammort_result1.quoteCal__Opening_Balance__c  = 1000;
    ammort_result1.quoteCal__Closing_Balance__c = 1000;
    ammort_result1.quoteCal__Payment__c = 3000;
    ammort_result1.quoteCal__Principal__c = 1000;
    ammort_result1.quoteCal__Repayment_Number__c = 1;
    ammort_result1.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    quoteCal__Amortization_Schedule__c ammort_result2 = new quoteCal__Amortization_Schedule__c();
    ammort_result2.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result2.quoteCal__Interest__c = 1000;
    ammort_result2.quoteCal__Opening_Balance__c  = 1000;
    ammort_result2.quoteCal__Closing_Balance__c = 1000;
    ammort_result2.quoteCal__Payment__c = 3000;
    ammort_result2.quoteCal__Principal__c = 1000;
    ammort_result2.quoteCal__Repayment_Number__c = 2;
    ammort_result2.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);

    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 2000;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 1887.20;
    pt.lms2__Loan__c = loan.Id;

    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(quote_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'false');
    Test.stopTest();

  }

  static testMethod void doPaymentCondition6() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
    serv_Cal.servicecal__New_Loan_Amount__c = 100000;
    serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
    serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
    serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
    serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1887.12;
    serv_Cal.servicecal__Country_of_Residence__c = 'India';
    serv_Cal.servicecal__Foreign_Currency__c = '0';
    serv_Cal.servicecal__Foreign_Currency_Exchange_Rate__c = 0;
    serv_Cal.servicecal__Couples__c = 0;
    serv_Cal.servicecal__Children__c  = 0;
    serv_Cal.servicecal__Applicant_1_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_1_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Applicant_2_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_2_Income_TNMI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_3_Income_TNM__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_AGI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_GFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_NFI__c = 1000;
    serv_Cal.servicecal__Applicant_4_Income_TNMI__c  = 1000;
    serv_Cal.servicecal__Company_1_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_GFI__c = 1000;
    serv_Cal.servicecal__Company_1_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_AGI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_NFI__c = 1000;
    serv_Cal.servicecal__Company_2_Profit__c = 1000;
    serv_Cal.servicecal__Company_2_Profit_TNMI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_GFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_NFI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_AGI__c = 1000;
    serv_Cal.servicecal__Anual_Rental_Income_s_TNMI__c = 1000;
    serv_Cal.servicecal__Total_GFI__c = 1000;
    serv_Cal.servicecal__Total_NFI__c = 1000;
    serv_Cal.servicecal__Total_AGI__c = 1000;
    serv_Cal.servicecal__Total_Gross_Income__c = 1000;
    serv_Cal.servicecal__Total_Net_Income__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_AUD__c = 1000;
    serv_Cal.servicecal__Monthly_Living_Expenses_FC__c = 1000;
    serv_Cal.servicecal__Living_Expenses_Used__c = 1000;
    serv_Cal.servicecal__Total_income_available_for_debt__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_ADL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_AMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_D_L__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCDL__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_FCMP__c = 1000;
    serv_Cal.servicecal__Credit_Card_Limit_not_debt_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_ADL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_AMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_D_L__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCDL__c = 1000;
    serv_Cal.servicecal__Personal_loan_Fixed_FCMP__c = 1000;
    serv_Cal.servicecal__Personal_Loan_Fixed_MP__c = 1000;
    serv_Cal.servicecal__Overdraft_ADL__c = 1000;
    serv_Cal.servicecal__Overdraft_AMP__c = 1000;
    serv_Cal.servicecal__Overdraft_D_L__c = 1000;
    serv_Cal.servicecal__Overdraft_FCDL__c = 1000;
    serv_Cal.servicecal__Overdraft_FCMP__c = 1000;
    serv_Cal.servicecal__Overdraft_MP__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_ADL__c = 1000;
    serv_Cal.servicecal__Housing_loan_Variable_AMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_D_L__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCDL__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_FCMP__c = 1000;
    serv_Cal.servicecal__Housing_Loan_Variable_MP__c = 1000;
    serv_Cal.servicecal__Lease_Hp_ADL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_AMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_D_L__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCDL__c = 1000;
    serv_Cal.servicecal__Lease_Hp_FCMP__c = 1000;
    serv_Cal.servicecal__Lease_HP_MP__c = 1000;
    serv_Cal.servicecal__Other_ADL__c = 1000;
    serv_Cal.servicecal__Other_AMP__c = 1000;
    serv_Cal.servicecal__Other_D_L__c = 1000;
    serv_Cal.servicecal__Other_FCDL__c = 1000;
    serv_Cal.servicecal__Other_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_AMP__c = 1000;
    serv_Cal.servicecal__Child_Support_FCMP__c = 1000;
    serv_Cal.servicecal__Child_Support_MP__c = 1000;
    serv_Cal.servicecal__Rent_Board_AMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_FCMP__c = 1000;
    serv_Cal.servicecal__Rent_Board_MP__c = 1000;
    serv_Cal.servicecal__Total_FCMP__c = 1000;
    serv_Cal.servicecal__Total_AMP__c = 1000;
    serv_Cal.servicecal__Total_Commitments_AUD__c = 1000;
    serv_Cal.servicecal__Total_Commitments_Foreign_Currency__c = 1000;
    serv_Cal.servicecal__Total_Net_Commitments__c = 1000;
    serv_Cal.servicecal__Interest_Only_Term_Years__c ='5';
    serv_Cal.servicecal__Net_Disposable_Income__c = 1000;
    serv_Cal.servicecal__Loan_Assesment_Rate_minimum_7__c = 1000;
    serv_Cal.servicecal__minus_Existing_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c = 1000;
    serv_Cal.servicecal__Single_Adult__c = 1000;
    serv_Cal.servicecal__Total_Expenses__c = 1000;
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR_t__c = 'True';
    serv_Cal.servicecal__Interest_Coverage_Ratio_ICR__c = 1000;
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_1__c ='True';
    serv_Cal.servicecal__Test_1_Must_Be_Possitive_2__c  = 1000;
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_1__c = 'True';
    serv_Cal.servicecal__Test_2_Must_NOT_exceed_35_2__c = 1000;
    serv_Cal.servicecal__Overall_Result__c = 'True';
    Database.SaveResult res3 = Database.insert(serv_Cal,false);

    servicecal__Amortization_Result__c ammort_result1 = new servicecal__Amortization_Result__c();
    ammort_result1.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result1.servicecal__Interest__c = 1000;
    ammort_result1.servicecal__Opening_Balance__c  = 1000;
    ammort_result1.servicecal__Closing_Balance__c = 1000;
    ammort_result1.servicecal__Payment__c = 1000;
    ammort_result1.servicecal__Principal__c = 1000;
    ammort_result1.servicecal__Payment_Number__c = 1;
    ammort_result1.servicecal__Remaining__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    servicecal__Amortization_Result__c ammort_result2 = new servicecal__Amortization_Result__c();
    ammort_result2.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
    ammort_result2.servicecal__Interest__c = 1000;
    ammort_result2.servicecal__Opening_Balance__c  = 1000;
    ammort_result2.servicecal__Closing_Balance__c = 1000;
    ammort_result2.servicecal__Payment__c = 1000;
    ammort_result2.servicecal__Principal__c = 1000;
    ammort_result2.servicecal__Payment_Number__c = 2;
    ammort_result2.servicecal__Remaining__c = 4;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);
    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 0;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 200;
    pt.lms2__Loan__c = loan.Id;


    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(serv_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'true');
    Test.stopTest();

  }
    
  static testMethod void doPaymentCondition7() {

    Account acc = new Account();
    acc.name = 'Test Account';
    Database.SaveResult res1 = Database.insert(acc,false);

    Opportunity opp_Record = new Opportunity();
    opp_Record.name = 'Test Record';
    opp_Record.StageName = 'Settled';
    opp_Record.CloseDate = date.today();
    opp_Record.AccountId = acc.Id;
    opp_Record.lms2__Application_Number1__c = '1';
    Database.SaveResult res2 = Database.insert(opp_Record,false);

    String Opportunity_Rec = JSON.serialize(opp_Record);

    quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
    quote_Cal.quoteCal__Amount_Financed__c = 100000;
    quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
    quote_Cal.quoteCal__Term_months__c = 60;
    quote_Cal.quoteCal__Desired_Base_Rate__c = 6;
    quote_Cal.quoteCal__Repayment_Expected_c__c = 1887.12;
    Database.SaveResult res3 = Database.insert(quote_Cal,false);

    quoteCal__Amortization_Schedule__c ammort_result1 = new quoteCal__Amortization_Schedule__c();
    ammort_result1.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result1.quoteCal__Interest__c = 1000;
    ammort_result1.quoteCal__Opening_Balance__c  = 1000;
    ammort_result1.quoteCal__Closing_Balance__c = 1000;
    ammort_result1.quoteCal__Payment__c = 1000;
    ammort_result1.quoteCal__Principal__c = 1000;
    ammort_result1.quoteCal__Repayment_Number__c = 1;
    ammort_result1.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res4 = Database.insert(ammort_result1,false);

    quoteCal__Amortization_Schedule__c ammort_result2 = new quoteCal__Amortization_Schedule__c();
    ammort_result2.quoteCal__Calculator_Result__c = quote_Cal.Id;
    ammort_result2.quoteCal__Interest__c = 1000;
    ammort_result2.quoteCal__Opening_Balance__c  = 1000;
    ammort_result2.quoteCal__Closing_Balance__c = 1000;
    ammort_result2.quoteCal__Payment__c = 3000;
    ammort_result2.quoteCal__Principal__c = 1000;
    ammort_result2.quoteCal__Repayment_Number__c = 2;
    ammort_result2.quoteCal__Remaining_Months__c = 1;
    Database.SaveResult res5 = Database.insert(ammort_result2,false);

    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;

    lms2__Payment_Transaction__c pt = new lms2__Payment_Transaction__c();
    pt.lms2__Amount_Requested__c = 2000;
    pt.lms2__Loan_Account_No__c = '1';
    pt.lms2__Payer_ID__c = 'B';
    pt.lms2__Payment_Amount__c = 1887.20;
    pt.lms2__Loan__c = loan.Id;

    String pt_data = JSON.serialize(pt);
    Test.startTest();
    LMS.ConvertToLoan(quote_Cal.Id);
    PaymentTransactionController.doPayment(pt_data,'false');
    Test.stopTest();

  }
    
  static testMethod void getLoanAccountNumber() {

    lms2__Loan__c loan = new lms2__Loan__c();
    insert loan;
      
    Test.startTest();
    LMSPayRepaymentButtonController.getLoanAccountNumber(loan.Id);
    Test.stopTest();

  }

}