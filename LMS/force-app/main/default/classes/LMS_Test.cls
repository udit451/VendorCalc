/**
 * Created by krapy on 23/4/18.
 */

@isTest
private with sharing class LMS_Test {


     static testMethod void getCalculator() {

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.lms2__Application_Number1__c = '1';

        Database.SaveResult res1 = Database.insert(opp_Record,false);

        servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
        serv_Cal.servicecal__New_Loan_Amount__c = 100000;
        serv_Cal.servicecal__Opportunity__c = opp_Record.Id;
        serv_Cal.servicecal__New_Loan_Term_Years__c = '5';
        serv_Cal.servicecal__Intrest_Rate_on_new_Loan__c = 5;
         serv_Cal.servicecal__New_Monthly_Loan_Repayment_s__c = 1200;

        Database.SaveResult res2 = Database.insert(serv_Cal,false);
         
        quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
        quote_Cal.quoteCal__Amount_Financed__c = 100000;
        quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
        quote_Cal.quoteCal__Term_months__c = 60;
        quote_Cal.quoteCal__Customer_Rate_Non_Published__c = 6;
        quote_Cal.quoteCal__Repayment_Non_Published__c = 1887.12;
        Database.SaveResult res3 = Database.insert(quote_Cal,false);
         
        MortgageCalc__Financial_Calculator__c fin_Cal = new MortgageCalc__Financial_Calculator__c();
        fin_Cal.MortgageCalc__Loan_Amount__c = 100000;
        fin_Cal.MortgageCalc__Opportunity__c = opp_Record.Id;
        fin_Cal.MortgageCalc__Loan_Period__c = 5;
        fin_Cal.MortgageCalc__Annual_Interest_Rate__c = 5;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1887.12;
         Database.SaveResult res4 = Database.insert(fin_Cal,false);

        Test.startTest();
        List<LMS.getCalculatorWrapper> obj_list =new List<LMS.getCalculatorWrapper>();
        obj_list = LMS.getCalculatorsList(opp_Record.Id);
        obj_list = LMS.getCalculatorsList(null);
        Test.stopTest();

    }

     static testMethod void convertLoan1() {

        Account acc = new Account();
        acc.name = 'Test Account';
        String acc_rec = LMS.saveAccountData_Apex(JSON.serialize(acc));
        System.assertEquals(acc_rec, 'success');

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.lms2__Application_Number1__c = '1';
        String Opportunity_Rec = JSON.serialize(opp_Record);
        LMS.OpportunityWrapper opp_rec=LMS.saveOpportunityData_Apex(Opportunity_Rec);
        LMS.OpportunityWrapper opp_rec1=LMS.saveOpportunityData_Apex(null);
        System.assert(opp_rec.opp.Id != null);
        servicecal__Non_Resident__c serv_Cal = new servicecal__Non_Resident__c();
        serv_Cal.servicecal__New_Loan_Amount__c = 100000;
        serv_Cal.servicecal__Opportunity__c = opp_rec.opp.Id;
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
        insert serv_Cal;

        servicecal__Amortization_Result__c ammort_result = new servicecal__Amortization_Result__c();
        ammort_result.servicecal__Serviceability_Calculator__c = serv_Cal.Id;
        ammort_result.servicecal__Interest__c = 1000;
 		ammort_result.servicecal__Opening_Balance__c  = 1000;
        ammort_result.servicecal__Closing_Balance__c = 1000;
        ammort_result.servicecal__Payment__c = 1000;
        ammort_result.servicecal__Principal__c = 1000;
	    ammort_result.servicecal__Payment_Number__c = 1000;
        ammort_result.servicecal__Remaining__c = 1;

        Database.SaveResult res3 = Database.insert(ammort_result,false);

        Test.startTest();
         system.debug('serv_Cal>>>'+serv_Cal);
         system.debug('serv_Cal>>>'+serv_Cal.Id);
        LMS.ConvertToLoan(serv_Cal.Id);
        Test.stopTest();

    }

     static testMethod void convertLoan2() {

        Account acc = new Account();
        acc.name = 'Test Account';
        Database.SaveResult res1 = Database.insert(acc,false);

        Contact con = new Contact();
        con.lastname = 'Test Contact';
        con.AccountId = acc.Id;
        Database.SaveResult res2 = Database.insert(con,false);

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.lms2__Application_Number1__c = '1';

        Database.SaveResult res3 = Database.insert(opp_Record,false);

        String Opportunity_Rec = JSON.serialize(opp_Record);
         lms2__Loan__c  loanObject = new lms2__Loan__c();
         loanObject.lms2__Application_Related_To__c = opp_Record.Id;
         insert  loanObject;
        MortgageCalc__Financial_Calculator__c fin_Cal = new MortgageCalc__Financial_Calculator__c();
        fin_Cal.MortgageCalc__Loan_Amount__c = 100000;
        fin_Cal.MortgageCalc__Opportunity__c = opp_Record.Id;
        fin_Cal.MortgageCalc__Loan_Period__c = 5;
        fin_Cal.MortgageCalc__Annual_Interest_Rate__c = 5;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1887.12;
        fin_Cal.MortgageCalc__Account__c = acc.Id;
        fin_Cal.MortgageCalc__Additional_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Fortnight__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Month__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Week__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Year__c = 1000;
        fin_Cal.MortgageCalc__Annual_Interest_Rate_Sensitivity__c = 5;
        fin_Cal.MortgageCalc__Average_Annual_Inflation_Rate__c = 5;
        fin_Cal.MortgageCalc__Capitalized_Cost__c = 1000;
        fin_Cal.MortgageCalc__Contact__c = con.Id;
        fin_Cal.MortgageCalc__Description__c = 'Description it is';
        fin_Cal.MortgageCalc__Down_Payment__c = 1000;
        fin_Cal.MortgageCalc__First_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Fixed_Monthly_Repayments__c = 10000;
        fin_Cal.MortgageCalc__Fixed_Rate__c = 5;
        fin_Cal.MortgageCalc__Fixed_Term__c = 5;
        fin_Cal.MortgageCalc__Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Increased_Instalment_Repayment_Amount__c = 1000;
        fin_Cal.MortgageCalc__Interest_Rate_Safety__c = 5;
        fin_Cal.MortgageCalc__Interest_Saving__c = 1000 ;
        fin_Cal.MortgageCalc__Lease_Price__c = 1000;
        fin_Cal.MortgageCalc__Maximum_Loan_Qualification_Amount__c = 1000;
        fin_Cal.MortgageCalc__Minimum_Required_Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Depreciation_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Difference__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Lease_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Sales_Tax_Payment__c = 1000;
        fin_Cal.MortgageCalc__Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Present_Value_of_Interest_Saving__c  = 1000;
        fin_Cal.MortgageCalc__Pre_Tax_Monthly_Payment__c = 1000;
        fin_Cal.MortgageCalc__Residual_Value__c = 1000;
        fin_Cal.MortgageCalc__Sales_Tax__c = 1000;
        fin_Cal.MortgageCalc__Scenario__c ='Demo' ;
        fin_Cal.MortgageCalc__Second_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Second_Monthly_Loan_Repayment__c = 1000 ;
        fin_Cal.MortgageCalc__Second_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Total_Adjusted_Interest_over_Loan_Pe__c = 1000;
        fin_Cal.MortgageCalc__Total_Interest_over_Loan_Period__c = 1000;
        fin_Cal.MortgageCalc__Total_Loan_Repayment_over_Loan_P__c = 1000;
        fin_Cal.MortgageCalc__Trade_in_Allowance__c = 1000;
        fin_Cal.MortgageCalc__Weekly_Loan_Repayment__c = 1000;

        Database.SaveResult res4 = Database.insert(fin_Cal,false);

        MortgageCalc__Month_Amort__c month_amort_list = new MortgageCalc__Month_Amort__c();
        month_amort_list.MortgageCalc__Loan_Calculator__c = fin_Cal.Id;
        month_amort_list.MortgageCalc__Repayment_Number__c = 1;
        month_amort_list.MortgageCalc__Capitalized_cost__c = 1000;
        month_amort_list.MortgageCalc__Capital_Outstanding__c = 1000;
        month_amort_list.MortgageCalc__Capital_Repaid__c = 1000;
        month_amort_list.MortgageCalc__Closing_Balance__c = 1000;
        month_amort_list.MortgageCalc__Fixed_Monthly_Repayments__c = 1000;
        month_amort_list.MortgageCalc__Interest_Charged__c = 1000;
        month_amort_list.MortgageCalc__Lease_price__c = 1000;
        month_amort_list.MortgageCalc__Loan_Repayment__c = 1000;
        month_amort_list.MortgageCalc__Monthly_depreciation_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_lease_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_payment__c = 1000;
        month_amort_list.MortgageCalc__Montlhy_sales_tax_payment__c = 1000;
        month_amort_list.MortgageCalc__Opening_Balance__c = 1000;
        month_amort_list.MortgageCalc__Pre_tax_montlhy_payment__c = 1000;
        month_amort_list.MortgageCalc__Residual_value__c= 1000;
        Database.SaveResult res5 = Database.insert(month_amort_list,false);

        Test.startTest();
        LMS.ConvertToLoan(fin_Cal.Id);
        Test.stopTest();

    }
    
    static testMethod void convertLoan3() {

        Account acc = new Account();
        acc.name = 'Test Account';
        Database.SaveResult res1 = Database.insert(acc,false);

        Contact con = new Contact();
        con.lastname = 'Test Contact';
        con.AccountId = acc.Id;
        Database.SaveResult res2 = Database.insert(con,false);

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.lms2__Application_Number1__c = '1';
        
        Database.SaveResult res3 = Database.insert(opp_Record,false);

        String Opportunity_Rec = JSON.serialize(opp_Record);
         lms2__Loan__c  loanObject = new lms2__Loan__c();
         loanObject.lms2__Application_Related_To__c = opp_Record.Id;
         insert  loanObject;
        
        quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
        quote_Cal.quoteCal__Amount_Financed__c = 100000;
        quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
        quote_Cal.quoteCal__Term_months__c = 60;
        quote_Cal.quoteCal__Desired_Base_Rate__c = 6;
        quote_Cal.quoteCal__Repayment_Expected_c__c = 1887.12;
        Database.SaveResult res6 = Database.insert(quote_Cal,false);
        
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
        Test.startTest();
        LMS.ConvertToLoan(quote_Cal.Id);
        Test.stopTest();

    }
    static testMethod void convertLoan4() {

        Account acc = new Account();
        acc.name = 'Test Account';
        Database.SaveResult res1 = Database.insert(acc,false);

        Contact con = new Contact();
        con.lastname = 'Test Contact';
        con.AccountId = acc.Id;
        Database.SaveResult res2 = Database.insert(con,false);

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.lms2__Application_Number1__c = '1';
        
        Database.SaveResult res3 = Database.insert(opp_Record,false);

        String Opportunity_Rec = JSON.serialize(opp_Record);
         
        
        quoteCal__Quote_Calculator__c quote_Cal = new quoteCal__Quote_Calculator__c();
        quote_Cal.quoteCal__Amount_Financed__c = 100000;
        quote_Cal.quoteCal__Opportunity__c = opp_Record.Id;
        quote_Cal.quoteCal__Term_months__c = 60;
        quote_Cal.quoteCal__Desired_Base_Rate__c = 6;
        quote_Cal.quoteCal__Repayment_Expected_c__c = 1887.12;
        Database.SaveResult res6 = Database.insert(quote_Cal,false);
        
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
        
        SObjectType snc = Schema.getGlobalDescribe().get('servicecal__Non_Resident__c');
		SObject addressObj = snc.newSObject();
        addressObj.put('servicecal__Opportunity__c',opp_Record.Id);
        Database.SaveResult res7 = Database.insert(addressObj,false);
    
        
        Test.startTest();
        LMS.ConvertToLoan(quote_Cal.Id);
        Test.stopTest();

    }

    static testMethod void getLoanDetails1() {
    Account acc = new Account();
        acc.name = 'Test Account';
        insert acc;

        Contact con = new Contact();
        con.lastname = 'Test Contact';
        con.AccountId = acc.Id;
        insert con;

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.Amount = 50000;
        opp_Record.lms2__Application_Number1__c = '1';
        insert opp_Record;
        
        String Opportunity_Rec = JSON.serialize(opp_Record.Id);
        
       
        MortgageCalc__Financial_Calculator__c fin_Cal = new MortgageCalc__Financial_Calculator__c();
        fin_Cal.MortgageCalc__Loan_Amount__c = 100000;
        fin_Cal.MortgageCalc__Opportunity__c = opp_Record.Id;
        fin_Cal.MortgageCalc__Loan_Period__c = 5;
        fin_Cal.MortgageCalc__Annual_Interest_Rate__c = 5;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1887.12;
        fin_Cal.MortgageCalc__Account__c = acc.Id;
        fin_Cal.MortgageCalc__Additional_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Fortnight__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Month__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Week__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Year__c = 1000;
        fin_Cal.MortgageCalc__Annual_Interest_Rate_Sensitivity__c = 5;
        fin_Cal.MortgageCalc__Average_Annual_Inflation_Rate__c = 5;
        fin_Cal.MortgageCalc__Capitalized_Cost__c = 1000;
        fin_Cal.MortgageCalc__Contact__c = con.Id;
        fin_Cal.MortgageCalc__Description__c = 'Description it is';
        fin_Cal.MortgageCalc__Down_Payment__c = 1000;
        fin_Cal.MortgageCalc__First_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Fixed_Monthly_Repayments__c = 10000;
        fin_Cal.MortgageCalc__Fixed_Rate__c = 5;
        fin_Cal.MortgageCalc__Fixed_Term__c = 5;
        fin_Cal.MortgageCalc__Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Increased_Instalment_Repayment_Amount__c = 1000;
        fin_Cal.MortgageCalc__Interest_Rate_Safety__c = 5;
        fin_Cal.MortgageCalc__Interest_Saving__c = 1000 ;
        fin_Cal.MortgageCalc__Lease_Price__c = 1000;
        fin_Cal.MortgageCalc__Maximum_Loan_Qualification_Amount__c = 1000;
        fin_Cal.MortgageCalc__Minimum_Required_Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Depreciation_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Difference__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Lease_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Sales_Tax_Payment__c = 1000;
        fin_Cal.MortgageCalc__Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Present_Value_of_Interest_Saving__c  = 1000;
        fin_Cal.MortgageCalc__Pre_Tax_Monthly_Payment__c = 1000;
        fin_Cal.MortgageCalc__Residual_Value__c = 1000;
        fin_Cal.MortgageCalc__Sales_Tax__c = 1000;
        fin_Cal.MortgageCalc__Scenario__c ='Demo' ;
        fin_Cal.MortgageCalc__Second_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Second_Monthly_Loan_Repayment__c = 1000 ;
        fin_Cal.MortgageCalc__Second_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Total_Adjusted_Interest_over_Loan_Pe__c = 1000;
        fin_Cal.MortgageCalc__Total_Interest_over_Loan_Period__c = 1000;
        fin_Cal.MortgageCalc__Total_Loan_Repayment_over_Loan_P__c = 1000;
        fin_Cal.MortgageCalc__Trade_in_Allowance__c = 1000;
        fin_Cal.MortgageCalc__Weekly_Loan_Repayment__c = 1000;
		insert fin_Cal;

        MortgageCalc__Month_Amort__c month_amort_list = new MortgageCalc__Month_Amort__c();
        month_amort_list.MortgageCalc__Loan_Calculator__c = fin_Cal.Id;
        month_amort_list.MortgageCalc__Repayment_Number__c = 1;
        month_amort_list.MortgageCalc__Capitalized_cost__c = 1000;
        month_amort_list.MortgageCalc__Capital_Outstanding__c = 1000;
        month_amort_list.MortgageCalc__Capital_Repaid__c = 1000;
        month_amort_list.MortgageCalc__Closing_Balance__c = 1000;
        month_amort_list.MortgageCalc__Fixed_Monthly_Repayments__c = 1000;
        month_amort_list.MortgageCalc__Interest_Charged__c = 1000;
        month_amort_list.MortgageCalc__Lease_price__c = 1000;
        month_amort_list.MortgageCalc__Loan_Repayment__c = 1000;
        month_amort_list.MortgageCalc__Monthly_depreciation_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_lease_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_payment__c = 1000;
        month_amort_list.MortgageCalc__Montlhy_sales_tax_payment__c = 1000;
        month_amort_list.MortgageCalc__Opening_Balance__c = 1000;
        month_amort_list.MortgageCalc__Pre_tax_montlhy_payment__c = 1000;
        month_amort_list.MortgageCalc__Residual_value__c= 1000;
        insert month_amort_list;

        Test.startTest();
        String result=LMS.ConvertToLoan(fin_Cal.Id);
        LMS.getLoanDetails_Apex(opp_Record.Id);
        LMS.getLoanDetails_Apex(null);
       	Test.stopTest();

    }
     static testMethod void getLoanDetails_else_If() {
        Account acc = new Account();
        acc.name = 'Test Account';
        insert acc;

        Contact con = new Contact();
        con.lastname = 'Test Contact';
        con.AccountId = acc.Id;
        insert con;

        Opportunity opp_Record = new Opportunity();
        opp_Record.name = 'Test Record';
        opp_Record.StageName = 'Settled';
        opp_Record.CloseDate = date.today();
        opp_Record.AccountId = acc.Id;
        opp_Record.Amount = 50000;
        opp_Record.lms2__Application_Number1__c = '1';
        insert opp_Record;
        
        String Opportunity_Rec = JSON.serialize(opp_Record.Id);
       
       
        MortgageCalc__Financial_Calculator__c fin_Cal = new MortgageCalc__Financial_Calculator__c();
        fin_Cal.MortgageCalc__Loan_Amount__c = 100000;
        fin_Cal.MortgageCalc__Opportunity__c = opp_Record.Id;
        fin_Cal.MortgageCalc__Loan_Period__c = 5;
        fin_Cal.MortgageCalc__Annual_Interest_Rate__c = 5;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1887.12;
        fin_Cal.MortgageCalc__Account__c = acc.Id;
        fin_Cal.MortgageCalc__Additional_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Fortnight__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Month__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Week__c = 1000;
        fin_Cal.MortgageCalc__Adjusted_Repayment_Period_In_Year__c = 1000;
        fin_Cal.MortgageCalc__Annual_Interest_Rate_Sensitivity__c = 5;
        fin_Cal.MortgageCalc__Average_Annual_Inflation_Rate__c = 5;
        fin_Cal.MortgageCalc__Capitalized_Cost__c = 1000;
        fin_Cal.MortgageCalc__Contact__c = con.Id;
        fin_Cal.MortgageCalc__Description__c = 'Description it is';
        fin_Cal.MortgageCalc__Down_Payment__c = 1000;
        fin_Cal.MortgageCalc__First_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__First_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Fixed_Monthly_Repayments__c = 10000;
        fin_Cal.MortgageCalc__Fixed_Rate__c = 5;
        fin_Cal.MortgageCalc__Fixed_Term__c = 5;
        fin_Cal.MortgageCalc__Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Increased_Instalment_Repayment_Amount__c = 1000;
        fin_Cal.MortgageCalc__Interest_Rate_Safety__c = 5;
        fin_Cal.MortgageCalc__Interest_Saving__c = 1000 ;
        fin_Cal.MortgageCalc__Lease_Price__c = 1000;
        fin_Cal.MortgageCalc__Maximum_Loan_Qualification_Amount__c = 1000;
        fin_Cal.MortgageCalc__Minimum_Required_Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Depreciation_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Difference__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Lease_Fee__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Monthly_Sales_Tax_Payment__c = 1000;
        fin_Cal.MortgageCalc__Net_Disposable_Income__c = 1000;
        fin_Cal.MortgageCalc__Present_Value_of_Interest_Saving__c  = 1000;
        fin_Cal.MortgageCalc__Pre_Tax_Monthly_Payment__c = 1000;
        fin_Cal.MortgageCalc__Residual_Value__c = 1000;
        fin_Cal.MortgageCalc__Sales_Tax__c = 1000;
        fin_Cal.MortgageCalc__Scenario__c ='Demo' ;
        fin_Cal.MortgageCalc__Second_Fortnightly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Second_Monthly_Loan_Repayment__c = 1000 ;
        fin_Cal.MortgageCalc__Second_Weekly_Loan_Repayment__c = 1000;
        fin_Cal.MortgageCalc__Total_Adjusted_Interest_over_Loan_Pe__c = 1000;
        fin_Cal.MortgageCalc__Total_Interest_over_Loan_Period__c = 1000;
        fin_Cal.MortgageCalc__Total_Loan_Repayment_over_Loan_P__c = 1000;
        fin_Cal.MortgageCalc__Trade_in_Allowance__c = 1000;
        fin_Cal.MortgageCalc__Weekly_Loan_Repayment__c = 1000;
		insert fin_Cal;

        MortgageCalc__Month_Amort__c month_amort_list = new MortgageCalc__Month_Amort__c();
        month_amort_list.MortgageCalc__Loan_Calculator__c = fin_Cal.Id;
        month_amort_list.MortgageCalc__Repayment_Number__c = 1;
        month_amort_list.MortgageCalc__Capitalized_cost__c = 1000;
        month_amort_list.MortgageCalc__Capital_Outstanding__c = 1000;
        month_amort_list.MortgageCalc__Capital_Repaid__c = 1000;
        month_amort_list.MortgageCalc__Closing_Balance__c = 1000;
        month_amort_list.MortgageCalc__Fixed_Monthly_Repayments__c = 1000;
        month_amort_list.MortgageCalc__Interest_Charged__c = 1000;
        month_amort_list.MortgageCalc__Lease_price__c = 1000;
        month_amort_list.MortgageCalc__Loan_Repayment__c = 1000;
        month_amort_list.MortgageCalc__Monthly_depreciation_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_lease_fee__c = 1000;
        month_amort_list.MortgageCalc__Monthly_payment__c = 1000;
        month_amort_list.MortgageCalc__Montlhy_sales_tax_payment__c = 1000;
        month_amort_list.MortgageCalc__Opening_Balance__c = 1000;
        month_amort_list.MortgageCalc__Pre_tax_montlhy_payment__c = 1000;
        month_amort_list.MortgageCalc__Residual_value__c= 1000;
        insert month_amort_list;
        
        Test.startTest();
        String result=LMS.ConvertToLoan(fin_Cal.Id);
        LMS.getLoanDetails_Apex(opp_Record.Id);
        LMS.getLoanDetails_Apex(null);
       	Test.stopTest();

    }
    
    

}