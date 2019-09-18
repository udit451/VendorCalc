/**
 * Created by krapy on 30/3/18.
 */

public with sharing class Convert_To_Loan_Button_Controller_Helper {

    public static List<lms2__Loan_Repayment_Option__c> Map_FinCal_To_LoanRO(MortgageCalc__Financial_Calculator__c Fincal, List<Id> LoadIds) {

        List<lms2__Loan_Repayment_Option__c> LoanRo_To_Return_List = new List<lms2__Loan_Repayment_Option__c>();
        lms2__Loan_Repayment_Option__c LoanRo_To_Return = new lms2__Loan_Repayment_Option__c ();

        RecordType rt = new RecordType();
        rt = [select Id,name from RecordType where Name = 'Mortgage Calculator' and SobjectType = 'lms2__Loan_Repayment_Option__c'];
        System.debug('>>>>>>>>>>>>>>>>>>' + rt);

        LoanRo_To_Return.RecordTypeId = rt.Id;
        LoanRo_To_Return.lms2__Active__c = true;
        System.debug(LoanRo_To_Return.RecordType);

        if (LoadIds.size() > 0) {
            LoanRo_To_Return.lms2__Loan__c = LoadIds[0];
        }

        if (Fincal.MortgageCalc__Account__c != NULL) {
            LoanRo_To_Return.lms2__Account__c = Fincal.MortgageCalc__Account__c;
        }
        if (Fincal.MortgageCalc__Additional_Monthly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__AdditionalMonthlyLoanRepayment__c = Fincal.MortgageCalc__Additional_Monthly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Fortnight__c != NULL) {
            LoanRo_To_Return.lms2__Adjusted_Repayment_Period_in_Fortnight__c = Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Fortnight__c;
        }
        if (Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Month__c != NULL) {
            LoanRo_To_Return.lms2__Adjusted_Repayment_Period_In_Month__c = Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Month__c;
        }
        if (Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Week__c != NULL) {
            LoanRo_To_Return.lms2__Adjusted_Repayment_Period_In_Week__c = Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Week__c;
        }
        if (Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Year__c != NULL) {
            LoanRo_To_Return.lms2__Adjusted_Repayment_Period_In_Year__c = Fincal.MortgageCalc__Adjusted_Repayment_Period_In_Year__c;
        }
        if (Fincal.MortgageCalc__Annual_Interest_Rate__c != NULL) {
            LoanRo_To_Return.lms2__Intrest_Rate_on_new_Loan__c = Fincal.MortgageCalc__Annual_Interest_Rate__c;
        }
        if (Fincal.MortgageCalc__Annual_Interest_Rate_Sensitivity__c != NULL) {
            LoanRo_To_Return.lms2__Annual_Interest_Rate_Sensitivity__c = Fincal.MortgageCalc__Annual_Interest_Rate_Sensitivity__c;
        }
        if (Fincal.MortgageCalc__Average_Annual_Inflation_Rate__c != NULL) {
            LoanRo_To_Return.lms2__AverageAnnual_Inflation_Rate__c = Fincal.MortgageCalc__Average_Annual_Inflation_Rate__c;
        }
        if (Fincal.MortgageCalc__Capitalized_Cost__c != NULL) {
            LoanRo_To_Return.lms2__Capitalized_cost__c = Fincal.MortgageCalc__Capitalized_Cost__c;
        }
        if (Fincal.MortgageCalc__Contact__c != NULL) {
            LoanRo_To_Return.lms2__Contact__c = Fincal.MortgageCalc__Contact__c;
        }
        if (Fincal.MortgageCalc__Description__c != NULL) {
            LoanRo_To_Return.lms2__Description__c = Fincal.MortgageCalc__Description__c;
        }
        if (Fincal.MortgageCalc__Down_Payment__c != NULL) {
            LoanRo_To_Return.lms2__Down_Payment__c = Fincal.MortgageCalc__Down_Payment__c;
        }
        if (Fincal.MortgageCalc__First_Fortnightly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__First_Fortnightly_Loan_Repayment__c = Fincal.MortgageCalc__First_Fortnightly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__First_Monthly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__First_Monthly_Loan_Repayment__c = Fincal.MortgageCalc__First_Monthly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__First_Weekly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__First_Weekly_Loan_Repayment__c = Fincal.MortgageCalc__First_Weekly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Fixed_Monthly_Repayments__c != NULL) {
            LoanRo_To_Return.lms2__Fixed_Monthly_Repayments__c = Fincal.MortgageCalc__Fixed_Monthly_Repayments__c;
        }
        if (Fincal.MortgageCalc__Fixed_Rate__c != NULL) {
            LoanRo_To_Return.lms2__Fixed_Rate__c = Fincal.MortgageCalc__Fixed_Rate__c;
        }
        if (Fincal.MortgageCalc__Fixed_Term__c != NULL) {
            LoanRo_To_Return.lms2__Fixed_Term__c = Fincal.MortgageCalc__Fixed_Term__c;
        }
        if (Fincal.MortgageCalc__Fortnightly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Fortnightly_Loan_Repayment__c = Fincal.MortgageCalc__Fortnightly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Increased_Instalment_Repayment_Amount__c != NULL) {
            LoanRo_To_Return.lms2__Increased_Instalment_Repayment_Amount__c = Fincal.MortgageCalc__Increased_Instalment_Repayment_Amount__c;
        }
        if (Fincal.MortgageCalc__Interest_Rate_Safety__c != NULL) {
            LoanRo_To_Return.lms2__Interest_Rate_Safety__c = Fincal.MortgageCalc__Interest_Rate_Safety__c;
        }
        if (Fincal.MortgageCalc__Interest_Saving__c != NULL) {
            LoanRo_To_Return.lms2__Interest_Saving__c = Fincal.MortgageCalc__Interest_Saving__c;
        }
        if (Fincal.MortgageCalc__Lease_Price__c != NULL) {
            LoanRo_To_Return.lms2__Lease_price__c = Fincal.MortgageCalc__Lease_Price__c;
        }
        if (Fincal.MortgageCalc__Loan_Amount__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Amount__c = Fincal.MortgageCalc__Loan_Amount__c;
        }
        if (Fincal.MortgageCalc__Loan_Period__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Term_Years__c = String.valueOf(Fincal.MortgageCalc__Loan_Period__c);
        }
        if (Fincal.MortgageCalc__Loan_Type__c != NULL) {
            LoanRo_To_Return.lms2__Loan_Type__c = Fincal.MortgageCalc__Loan_Type__c;
        }
        if (Fincal.MortgageCalc__Maximum_Loan_Qualification_Amount__c != NULL) {
            LoanRo_To_Return.lms2__Maximum_Loan_Qualification_Amount__c = Fincal.MortgageCalc__Maximum_Loan_Qualification_Amount__c;
        }
        if (Fincal.MortgageCalc__Minimum_Required_Net_Disposable_Income__c != NULL) {
            LoanRo_To_Return.lms2__Minimum_Required_Net_Disposable_Income__c = Fincal.MortgageCalc__Minimum_Required_Net_Disposable_Income__c;
        }
        if (Fincal.MortgageCalc__Monthly_Depreciation_Fee__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_depreciation_fee__c = Fincal.MortgageCalc__Monthly_Depreciation_Fee__c;
        }
        if (Fincal.MortgageCalc__Monthly_Difference__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_Difference__c = Fincal.MortgageCalc__Monthly_Difference__c;
        }
        if (Fincal.MortgageCalc__Monthly_Lease_Fee__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_lease_fee__c = Fincal.MortgageCalc__Monthly_Lease_Fee__c;
        }
        if (Fincal.MortgageCalc__Monthly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_Loan_Repayment__c = Fincal.MortgageCalc__Monthly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Monthly_Sales_Tax_Payment__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_Sales_Tax_Payment__c = Fincal.MortgageCalc__Monthly_Sales_Tax_Payment__c;
        }
        if (Fincal.MortgageCalc__Net_Disposable_Income__c != NULL) {
            LoanRo_To_Return.lms2__Net_Disposable_Income__c = Fincal.MortgageCalc__Net_Disposable_Income__c;
        }
        if (Fincal.MortgageCalc__Opportunity__c != NULL) {
            LoanRo_To_Return.lms2__Opportunity__c = Fincal.MortgageCalc__Opportunity__c;
        }
        if (Fincal.MortgageCalc__Present_Value_of_Interest_Saving__c != NULL) {
            LoanRo_To_Return.lms2__Present_Value_of_Interest_Saving__c = Fincal.MortgageCalc__Present_Value_of_Interest_Saving__c;
        }
        if (Fincal.MortgageCalc__Pre_Tax_Monthly_Payment__c != NULL) {
            LoanRo_To_Return.lms2__Pre_Tax_Monthly_Payment__c = Fincal.MortgageCalc__Pre_Tax_Monthly_Payment__c;
        }
        if (Fincal.MortgageCalc__Repayment_Frequency__c != NULL) {
            LoanRo_To_Return.lms2__Repayment_Frequency__c = Fincal.MortgageCalc__Repayment_Frequency__c;
        }
        if (Fincal.MortgageCalc__Repayment_Type__c != NULL) {
            LoanRo_To_Return.lms2__Repayment_Type__c = Fincal.MortgageCalc__Repayment_Type__c;
        }
        if (Fincal.MortgageCalc__Residual_Value__c != NULL) {
            LoanRo_To_Return.lms2__Residual_value__c = Fincal.MortgageCalc__Residual_Value__c;
        }
        if (Fincal.MortgageCalc__Sales_Tax__c != NULL) {
            LoanRo_To_Return.lms2__Sales_Tax__c = Fincal.MortgageCalc__Sales_Tax__c;
        }
        if (Fincal.MortgageCalc__Scenario__c != NULL) {
            LoanRo_To_Return.lms2__Scenario__c = Fincal.MortgageCalc__Scenario__c;
        }
        if (Fincal.MortgageCalc__Second_Fortnightly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Second_Fortnightly_Loan_Repayment__c = Fincal.MortgageCalc__Second_Fortnightly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Second_Monthly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Second_Monthly_Loan_Repayment__c = Fincal.MortgageCalc__Second_Monthly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Second_Weekly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Second_Weekly_Loan_Repayment__c = Fincal.MortgageCalc__Second_Weekly_Loan_Repayment__c;
        }
        if (Fincal.MortgageCalc__Total_Adjusted_Interest_over_Loan_Pe__c != NULL) {
            LoanRo_To_Return.lms2__Total_Adjusted_Interest_over_Loan_Pe__c = Fincal.MortgageCalc__Total_Adjusted_Interest_over_Loan_Pe__c;
        }
        if (Fincal.MortgageCalc__Total_Interest_over_Loan_Period__c != NULL) {
            LoanRo_To_Return.lms2__Total_Interest_over_Loan_Period__c = Fincal.MortgageCalc__Total_Interest_over_Loan_Period__c;
        }
        if (Fincal.MortgageCalc__Total_Loan_Repayment_over_Loan_P__c != NULL) {
            LoanRo_To_Return.lms2__Total_Loan_Repayment_over_Loan_P__c = Fincal.MortgageCalc__Total_Loan_Repayment_over_Loan_P__c;
        }
        if (Fincal.MortgageCalc__Trade_in_Allowance__c != NULL) {
            LoanRo_To_Return.lms2__Trade_in_Allowance__c = Fincal.MortgageCalc__Trade_in_Allowance__c;
        }
        if (Fincal.MortgageCalc__Weekly_Loan_Repayment__c != NULL) {
            LoanRo_To_Return.lms2__Weekly_Loan_Repayment__c = Fincal.MortgageCalc__Weekly_Loan_Repayment__c;
        }

        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>' + LoanRo_To_Return);
        LoanRo_To_Return_List.add(LoanRo_To_Return);
        return LoanRo_To_Return_List;
    }

    public static List<lms2__Loan_Repayment_Option__c> Map_QuoteCal_To_LoanRO(quoteCal__Quote_Calculator__c quote, List<Id> LoadIds) {

        List<lms2__Loan_Repayment_Option__c> LoanRo_To_Return_List = new List<lms2__Loan_Repayment_Option__c>();
        lms2__Loan_Repayment_Option__c LoanRo_To_Return = new lms2__Loan_Repayment_Option__c ();

        RecordType rt = new RecordType();
        rt = [select Id,name from RecordType where Name = 'Quote Calculator' and SobjectType = 'lms2__Loan_Repayment_Option__c'];
        System.debug('>>>>>>>>>>>>>>>>>>' + rt);

        LoanRo_To_Return.RecordTypeId = rt.Id;
        LoanRo_To_Return.lms2__Active__c = true;
        System.debug(LoanRo_To_Return.RecordType);

        if (LoadIds.size() > 0) {
            LoanRo_To_Return.lms2__Loan__c = LoadIds[0];
            List<lms2__Loan__c> Loan = [select lms2__Total_Loan_Repayment__c from lms2__Loan__c where Id =: LoadIds[0]];
            system.debug('Loan.lms2__Total_Loan_Repayment__c>>>>'+Loan[0].lms2__Total_Loan_Repayment__c);
            if(Loan[0].lms2__Total_Loan_Repayment__c != null){
                system.debug('Loan.lms2__Total_Loan_Repayment__c>>>>'+Loan[0].lms2__Total_Loan_Repayment__c);
                LoanRo_To_Return.lms2__Loan_Repayment__c = Loan[0].lms2__Total_Loan_Repayment__c; 
            }
        }

        if (quote.quoteCal__Amount_Financed__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Amount__c = quote.quoteCal__Amount_Financed__c;
        }
        if (quote.quoteCal__Desired_Base_Rate__c != NULL) {
            LoanRo_To_Return.lms2__Intrest_Rate_on_new_Loan__c = quote.quoteCal__Desired_Base_Rate__c;
        }
        if (quote.quoteCal__Opportunity__c != NULL) {
            LoanRo_To_Return.lms2__Opportunity__c = quote.quoteCal__Opportunity__c;
        }
            LoanRo_To_Return.lms2__Repayment_Frequency__c = 'Monthly';
        if (quote.quoteCal__Repayment_Type__c != NULL) {
            LoanRo_To_Return.lms2__Repayment_Type__c = quote.quoteCal__Repayment_Type__c;
        }
        if (quote.quoteCal__Repayment_Non_Published__c != NULL) {
            LoanRo_To_Return.lms2__Total_Loan_Repayment_over_Loan_P__c = quote.quoteCal__Repayment_Non_Published__c;
        }
        if (quote.quoteCal__Term_months__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Term_Years__c = String.valueOf(quote.quoteCal__Term_months__c);
        }

        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>' + LoanRo_To_Return);
        LoanRo_To_Return_List.add(LoanRo_To_Return);
        return LoanRo_To_Return_List;
    }

    public static List<lms2__Loan_Repayent_Schedule__c> Map_MonthAmort_To_LoanRS(List<MortgageCalc__Month_Amort__c> Month_Amort_List, Decimal ServicingAmount, List<Id> Loan_Ids, List<Id> LoanRO_Ids, Date Term_Start_date) {

        List<lms2__Loan_Repayent_Schedule__c> LoanRS_To_Return_List = new List<lms2__Loan_Repayent_Schedule__c>();
        if (Month_Amort_List.size() > 0) {
            System.debug('Month_Amort_List' + Month_Amort_List);
            for (MortgageCalc__Month_Amort__c MA : Month_Amort_List) {
                lms2__Loan_Repayent_Schedule__c LoanRS_To_Return = new lms2__Loan_Repayent_Schedule__c ();
                LoanRS_To_Return.lms2__Payment_Status__c = 'Pending';
                if (LoanRO_Ids.size() > 0) {
                    LoanRS_To_Return.lms2__Loan_Repayment_Option__c = LoanRO_Ids[0];
                }
                if(Loan_Ids.size()>0){
                    LoanRS_To_Return.lms2__Loan_Account_2__c = Loan_Ids[0];
                }
                if (MA.Name != NULL) {
                    //LoanRS_To_Return.Name = MA.Name;
                }
                if (MA.MortgageCalc__Capitalized_cost__c != NULL) {
                    LoanRS_To_Return.lms2__Capitalized_cost_del__c = MA.MortgageCalc__Capitalized_cost__c;
                }
                if (MA.MortgageCalc__Capital_Outstanding__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Outstanding__c = MA.MortgageCalc__Capital_Outstanding__c;
                }
                if (ServicingAmount != NULL) {
                    LoanRS_To_Return.lms2__Servicing_Fee__c = ServicingAmount;
                }
                if (MA.MortgageCalc__Capital_Repaid__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Repaid_del__c = MA.MortgageCalc__Capital_Repaid__c;
                }
                if (MA.MortgageCalc__Closing_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Closing_Balance__c = MA.MortgageCalc__Closing_Balance__c;
                }
                if (MA.MortgageCalc__Fixed_Monthly_Repayments__c != NULL) {
                    LoanRS_To_Return.lms2__Fixed_Monthly_Repayments_del__c = MA.MortgageCalc__Fixed_Monthly_Repayments__c;
                }
                if (MA.MortgageCalc__Interest_Charged__c != NULL) {
                    LoanRS_To_Return.lms2__Interest__c = MA.MortgageCalc__Interest_Charged__c;
                }
                if (MA.MortgageCalc__Lease_price__c != NULL) {
                    LoanRS_To_Return.lms2__Lease_price_del__c = MA.MortgageCalc__Lease_price__c;
                }
                if (MA.MortgageCalc__Loan_Repayment__c != NULL) {
                    LoanRS_To_Return.lms2__Payment__c = MA.MortgageCalc__Loan_Repayment__c;
                    LoanRS_To_Return.lms2__Loan_Repayment_del__c = MA.MortgageCalc__Loan_Repayment__c;
                }
                if (MA.MortgageCalc__Monthly_depreciation_fee__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_depreciation_fee_del__c = MA.MortgageCalc__Monthly_depreciation_fee__c;
                }
                if (MA.MortgageCalc__Monthly_lease_fee__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_lease_fee_del__c = MA.MortgageCalc__Monthly_lease_fee__c;
                }
                if (MA.MortgageCalc__Monthly_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_payment_del__c = MA.MortgageCalc__Monthly_payment__c;
                }
                if (MA.MortgageCalc__Montlhy_sales_tax_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Montlhy_sales_tax_payment_del__c = MA.MortgageCalc__Montlhy_sales_tax_payment__c;
                }
                if (MA.MortgageCalc__Opening_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Opening_Balance__c = MA.MortgageCalc__Opening_Balance__c;
                }
                if (MA.MortgageCalc__Pre_tax_montlhy_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Pre_tax_montlhy_payment_del__c = MA.MortgageCalc__Pre_tax_montlhy_payment__c;
                }
                if (MA.MortgageCalc__Repayment_Number__c != NULL) {
                    LoanRS_To_Return.lms2__Repayment_Number_del__c = MA.MortgageCalc__Repayment_Number__c;
                    LoanRS_To_Return.lms2__Remaining__c = ((MA.MortgageCalc__Loan_Calculator__r.MortgageCalc__Annual_Interest_Rate__c) * 12) - LoanRS_To_Return.lms2__Repayment_Number_del__c;
                    if (Term_Start_date != NULL && LoanRS_To_Return.lms2__Repayment_Number_del__c != NULL) {
                        LoanRS_To_Return.lms2__Estimated_Repayment_Date__c = Term_Start_date.addMonths(Integer.valueOf(LoanRS_To_Return.lms2__Repayment_Number_del__c));
                    }
                }
                if (MA.MortgageCalc__Residual_value__c != NULL) {
                    LoanRS_To_Return.lms2__Residual_value_del__c = MA.MortgageCalc__Residual_value__c;
                }

                LoanRS_To_Return_List.add(LoanRS_To_Return);
                System.debug('LRS>>>>>>>>>>>>>>>>' + LoanRS_To_Return_List);
            }
        }
        return LoanRS_To_Return_List;
    }
    //(new)
    /*public static List<lms2__Loan_Repayment__c> Map_MonthAmort_To_LoanR(List<MortgageCalc__Month_Amort__c> Month_Amort_List, List<Id> Loan_Ids, List<Id> LoanRO_Ids, List<Id> LoanRS_Id, Date Term_Start_date) {
       system.debug('Map_MonthAmort_To_LoanR>>'+Month_Amort_List);
        List<lms2__Loan_Repayment__c> LoanRS_To_Return_List = new List<lms2__Loan_Repayment__c>();
         Integer i = 0;
        if (Month_Amort_List.size() > 0) {
            System.debug('Month_Amort_List' + Month_Amort_List);
            for (MortgageCalc__Month_Amort__c MA : Month_Amort_List) {
                lms2__Loan_Repayment__c LoanRS_To_Return = new lms2__Loan_Repayment__c ();
                LoanRS_To_Return.lms2__Payment_Status__c = 'Pending';
                if (LoanRO_Ids.size() > 0) {
                    LoanRS_To_Return.lms2__Loan_Repayment_Option__c = LoanRO_Ids[0];
                }
                if(LoanRS_Id.size() > 0){
                    LoanRS_To_Return.lms2__Loan_Repayment_Schedule__c = LoanRS_Id[i];
                    i++;
                }
                if(Loan_Ids.size()>0){
                    LoanRS_To_Return.lms2__Loan_Account_2__c = Loan_Ids[0];
                } 
                if (MA.MortgageCalc__Capitalized_cost__c != NULL) {
                    LoanRS_To_Return.lms2__Capitalized_cost__c = MA.MortgageCalc__Capitalized_cost__c;
                }
                if (MA.MortgageCalc__Capital_Outstanding__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Outstanding__c = MA.MortgageCalc__Capital_Outstanding__c;
                }
                if (MA.MortgageCalc__Capital_Repaid__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Repaid__c = MA.MortgageCalc__Capital_Repaid__c;
                }
                if (MA.MortgageCalc__Closing_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Closing_Balance__c = MA.MortgageCalc__Closing_Balance__c;
                }
                if (MA.MortgageCalc__Fixed_Monthly_Repayments__c != NULL) {
                    LoanRS_To_Return.lms2__Fixed_Monthly_Repayments__c = MA.MortgageCalc__Fixed_Monthly_Repayments__c;
                }
                if (MA.MortgageCalc__Interest_Charged__c != NULL) {
                    LoanRS_To_Return.lms2__Interest__c = MA.MortgageCalc__Interest_Charged__c;
                }
                if (MA.MortgageCalc__Lease_price__c != NULL) {
                    LoanRS_To_Return.lms2__Lease_price__c = MA.MortgageCalc__Lease_price__c;
                }
                if (MA.MortgageCalc__Loan_Repayment__c != NULL) {
                    LoanRS_To_Return.lms2__Payment__c = MA.MortgageCalc__Loan_Repayment__c;
                }
                if (MA.MortgageCalc__Monthly_depreciation_fee__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_depreciation_fee__c = MA.MortgageCalc__Monthly_depreciation_fee__c;
                }
                if (MA.MortgageCalc__Monthly_lease_fee__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_lease_fee__c = MA.MortgageCalc__Monthly_lease_fee__c;
                }
                if (MA.MortgageCalc__Monthly_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_payment__c = MA.MortgageCalc__Monthly_payment__c;
                }
                if (MA.MortgageCalc__Montlhy_sales_tax_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Montlhy_sales_tax_payment__c = MA.MortgageCalc__Montlhy_sales_tax_payment__c;
                }
                if (MA.MortgageCalc__Opening_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Opening_Balance__c = MA.MortgageCalc__Opening_Balance__c;
                }
                if (MA.MortgageCalc__Pre_tax_montlhy_payment__c != NULL) {
                    LoanRS_To_Return.lms2__Pre_tax_montlhy_payment__c = MA.MortgageCalc__Pre_tax_montlhy_payment__c;
                }
                if (MA.MortgageCalc__Repayment_Number__c != NULL) {
                    LoanRS_To_Return.lms2__Repayment_Number__c = MA.MortgageCalc__Repayment_Number__c;
                    LoanRS_To_Return.lms2__Remaining__c = ((MA.MortgageCalc__Loan_Calculator__r.MortgageCalc__Annual_Interest_Rate__c) * 12) - LoanRS_To_Return.lms2__Repayment_Number__c;
                    if (Term_Start_date != NULL && LoanRS_To_Return.lms2__Repayment_Number__c != NULL) {
                        LoanRS_To_Return.lms2__Estimated_Repayment_Date__c = Term_Start_date.addMonths(Integer.valueOf(LoanRS_To_Return.lms2__Repayment_Number__c));
                    }
                }
                if (MA.MortgageCalc__Residual_value__c != NULL) {
                    LoanRS_To_Return.lms2__Residual_value__c = MA.MortgageCalc__Residual_value__c;
                }

                LoanRS_To_Return_List.add(LoanRS_To_Return);
                System.debug('LRS>>>>>>>>>>>>>>>>' + LoanRS_To_Return_List);
            }
        }
        return LoanRS_To_Return_List;
    }*/

    public static List<lms2__Loan_Repayment_Option__c> Map_ServCal_To_LoanRO(servicecal__Non_Resident__c Servcal, List<Id> LoadIds) {

        List<lms2__Loan_Repayment_Option__c> LoanRo_To_Return_List = new List<lms2__Loan_Repayment_Option__c>();
        lms2__Loan_Repayment_Option__c LoanRo_To_Return = new lms2__Loan_Repayment_Option__c ();

        RecordType rt = new RecordType();
        rt = [select Id,name from RecordType where Name = 'Servicability Calculator' and SobjectType = 'lms2__Loan_Repayment_Option__c'];
        System.debug('>>>>>>>>>>>>>>>>>>' + rt);

        LoanRo_To_Return.RecordTypeId = rt.Id;
        LoanRo_To_Return.lms2__Active__c = true;
        System.debug(LoanRo_To_Return.RecordType);

        if (LoadIds.size() > 0) {
            LoanRo_To_Return.lms2__Loan__c = LoadIds[0];
        }
        if (Servcal.servicecal__Country_of_Residence__c != NULL) {
            LoanRo_To_Return.lms2__Country_of_Residence__c = Servcal.servicecal__Country_of_Residence__c;
        }
        if (Servcal.servicecal__Foreign_Currency__c != NULL) {
            LoanRo_To_Return.lms2__Foreign_Currency__c = Servcal.servicecal__Foreign_Currency__c;
        }
        if (Servcal.servicecal__Foreign_Currency_Exchange_Rate__c != NULL) {
            LoanRo_To_Return.lms2__Foreign_Currency_Exchange_Rate__c = Servcal.servicecal__Foreign_Currency_Exchange_Rate__c;
        }
        if (Servcal.servicecal__Couples__c != NULL) {
            LoanRo_To_Return.lms2__Couples__c = Servcal.servicecal__Couples__c;
        }
        if (Servcal.servicecal__Children__c != NULL) {
            LoanRo_To_Return.lms2__Children__c = Servcal.servicecal__Children__c;
        }
        if (Servcal.servicecal__Applicant_1_Income_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_1_Income_AGI__c = Servcal.servicecal__Applicant_1_Income_AGI__c;
        }
        if (Servcal.servicecal__Applicant_1_Income_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_1_Income_GFI__c = Servcal.servicecal__Applicant_1_Income_GFI__c;
        }
        if (Servcal.servicecal__Applicant_1_Income_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_1_Income_NFI__c = Servcal.servicecal__Applicant_1_Income_NFI__c;
        }
        if (Servcal.servicecal__Applicant_1_Income_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_1_Income_TNMI__c = Servcal.servicecal__Applicant_1_Income_TNMI__c;
        }
        if (Servcal.servicecal__Applicant_2_Income_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_2_Income_AGI__c = Servcal.servicecal__Applicant_2_Income_AGI__c;
        }
        if (Servcal.servicecal__Applicant_2_Income_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_2_Income_GFI__c = Servcal.servicecal__Applicant_2_Income_GFI__c;
        }
        if (Servcal.servicecal__Applicant_2_Income_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_2_Income_NFI__c = Servcal.servicecal__Applicant_2_Income_NFI__c;
        }
        if (Servcal.servicecal__Applicant_2_Income_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_2_Income_TNMI__c = Servcal.servicecal__Applicant_2_Income_TNMI__c;
        }
        if (Servcal.servicecal__Applicant_3_Income_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_3_Income_AGI__c = Servcal.servicecal__Applicant_3_Income_AGI__c;
        }
        if (Servcal.servicecal__Applicant_3_Income_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_3_Income_GFI__c = Servcal.servicecal__Applicant_3_Income_GFI__c;
        }
        if (Servcal.servicecal__Applicant_3_Income_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_3_Income_NFI__c = Servcal.servicecal__Applicant_3_Income_NFI__c;
        }
        if (Servcal.servicecal__Applicant_3_Income_TNM__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_3_Income_TNM__c = Servcal.servicecal__Applicant_3_Income_TNM__c;
        }
        if (Servcal.servicecal__Applicant_4_Income_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_4_Income_AGI__c = Servcal.servicecal__Applicant_4_Income_AGI__c;
        }
        if (Servcal.servicecal__Applicant_4_Income_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_4_Income_GFI__c = Servcal.servicecal__Applicant_4_Income_GFI__c;
        }
        if (Servcal.servicecal__Applicant_4_Income_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_4_Income_NFI__c = Servcal.servicecal__Applicant_4_Income_NFI__c;
        }
        if (Servcal.servicecal__Applicant_4_Income_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Applicant_4_Income_TNMI__c = Servcal.servicecal__Applicant_4_Income_TNMI__c;
        }
        if (Servcal.servicecal__Company_1_Profit_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Company_1_Profit_AGI__c = Servcal.servicecal__Company_1_Profit_AGI__c;
        }
        if (Servcal.servicecal__Company_1_Profit_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Company_1_Profit_NFI__c = Servcal.servicecal__Company_1_Profit_NFI__c;
        }
        if (Servcal.servicecal__Company_1_Profit_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Company_1_Profit_GFI__c = Servcal.servicecal__Company_1_Profit_GFI__c;
        }
        if (Servcal.servicecal__Company_1_Profit_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Company_1_Profit_TNMI__c = Servcal.servicecal__Company_1_Profit_TNMI__c;
        }
        if (Servcal.servicecal__Company_2_Profit_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Company_2_Profit_AGI__c = Servcal.servicecal__Company_2_Profit_AGI__c;
        }
        if (Servcal.servicecal__Company_2_Profit_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Company_2_Profit_NFI__c = Servcal.servicecal__Company_2_Profit_NFI__c;
        }
        if (Servcal.servicecal__Company_2_Profit__c != NULL) {
            LoanRo_To_Return.lms2__Company_2_Profit__c = Servcal.servicecal__Company_2_Profit__c;
        }
        if (Servcal.servicecal__Company_2_Profit_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Company_2_Profit_TNMI__c = Servcal.servicecal__Company_2_Profit_TNMI__c;
        }
        if (Servcal.servicecal__Anual_Rental_Income_s_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Anual_Rental_Income_s_GFI__c = Servcal.servicecal__Anual_Rental_Income_s_GFI__c;
        }
        if (Servcal.servicecal__Anual_Rental_Income_s_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Anual_Rental_Income_s_NFI__c = Servcal.servicecal__Anual_Rental_Income_s_NFI__c;
        }
        if (Servcal.servicecal__Anual_Rental_Income_s_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Anual_Rental_Income_s_AGI__c = Servcal.servicecal__Anual_Rental_Income_s_AGI__c;
        }
        if (Servcal.servicecal__Anual_Rental_Income_s_TNMI__c != NULL) {
            LoanRo_To_Return.lms2__Anual_Rental_Income_s_TNMI__c = Servcal.servicecal__Anual_Rental_Income_s_TNMI__c;
        }
        if (Servcal.servicecal__Total_GFI__c != NULL) {
            LoanRo_To_Return.lms2__Total_GFI__c = Servcal.servicecal__Total_GFI__c;
        }
        if (Servcal.servicecal__Total_NFI__c != NULL) {
            LoanRo_To_Return.lms2__Total_NFI__c = Servcal.servicecal__Total_NFI__c;
        }
        if (Servcal.servicecal__Total_AGI__c != NULL) {
            LoanRo_To_Return.lms2__Total_AGI__c = Servcal.servicecal__Total_AGI__c;
        }
        if (Servcal.servicecal__Total_Gross_Income__c != NULL) {
            LoanRo_To_Return.lms2__Total_Gross_Income__c = Servcal.servicecal__Total_Gross_Income__c;
        }
        if (Servcal.servicecal__Total_Net_Income__c != NULL) {
            LoanRo_To_Return.lms2__Total_Net_Income__c = Servcal.servicecal__Total_Net_Income__c;
        }
        if (Servcal.servicecal__Monthly_Living_Expenses_AUD__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_Living_Expenses_AUD__c = Servcal.servicecal__Monthly_Living_Expenses_AUD__c;
        }
        if (Servcal.servicecal__Monthly_Living_Expenses_FC__c != NULL) {
            LoanRo_To_Return.lms2__Monthly_Living_Expenses_FC__c = Servcal.servicecal__Monthly_Living_Expenses_FC__c;
        }
        if (Servcal.servicecal__Living_Expenses_Used__c != NULL) {
            LoanRo_To_Return.lms2__Living_Expenses_Used__c = Servcal.servicecal__Living_Expenses_Used__c;
        }
        if (Servcal.servicecal__Total_income_available_for_debt__c != NULL) {
            LoanRo_To_Return.lms2__Total_income_available_for_debt__c = Servcal.servicecal__Total_income_available_for_debt__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_ADL__c = Servcal.servicecal__Credit_Card_Limit_not_debt_ADL__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_AMP__c = Servcal.servicecal__Credit_Card_Limit_not_debt_AMP__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_D_L__c = Servcal.servicecal__Credit_Card_Limit_not_debt_D_L__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_FCDL__c = Servcal.servicecal__Credit_Card_Limit_not_debt_FCDL__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_FCMP__c = Servcal.servicecal__Credit_Card_Limit_not_debt_FCMP__c;
        }
        if (Servcal.servicecal__Credit_Card_Limit_not_debt_MP__c != NULL) {
            LoanRo_To_Return.lms2__Credit_Card_Limit_not_debt_MP__c = Servcal.servicecal__Credit_Card_Limit_not_debt_MP__c;
        }
        if (Servcal.servicecal__Personal_loan_Variable_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Variable_ADL__c = Servcal.servicecal__Personal_loan_Variable_ADL__c;
        }
        if (Servcal.servicecal__Personal_loan_Variable_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Variable_AMP__c = Servcal.servicecal__Personal_loan_Variable_AMP__c;
        }
        if (Servcal.servicecal__Personal_Loan_Variable_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Personal_Loan_Variable_D_L__c = Servcal.servicecal__Personal_Loan_Variable_D_L__c;
        }
        if (Servcal.servicecal__Personal_loan_Variable_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Variable_FCDL__c = Servcal.servicecal__Personal_loan_Variable_FCDL__c;
        }
        if (Servcal.servicecal__Personal_loan_Variable_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Variable_FCMP__c = Servcal.servicecal__Personal_loan_Variable_FCMP__c;
        }
        if (Servcal.servicecal__Personal_Loan_Variable_MP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_Loan_Variable_MP__c = Servcal.servicecal__Personal_Loan_Variable_MP__c;
        }
        if (Servcal.servicecal__Personal_loan_Fixed_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Fixed_ADL__c = Servcal.servicecal__Personal_loan_Fixed_ADL__c;
        }
        if (Servcal.servicecal__Personal_loan_Fixed_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Fixed_AMP__c = Servcal.servicecal__Personal_loan_Fixed_AMP__c;
        }
        if (Servcal.servicecal__Personal_Loan_Fixed_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Personal_Loan_Fixed_D_L__c = Servcal.servicecal__Personal_Loan_Fixed_D_L__c;
        }
        if (Servcal.servicecal__Personal_loan_Fixed_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Fixed_FCDL__c = Servcal.servicecal__Personal_loan_Fixed_FCDL__c;
        }
        if (Servcal.servicecal__Personal_loan_Fixed_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_loan_Fixed_FCMP__c = Servcal.servicecal__Personal_loan_Fixed_FCMP__c;
        }
        if (Servcal.servicecal__Personal_Loan_Fixed_MP__c != NULL) {
            LoanRo_To_Return.lms2__Personal_Loan_Fixed_MP__c = Servcal.servicecal__Personal_Loan_Fixed_MP__c;
        }
        if (Servcal.servicecal__Overdraft_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_ADL__c = Servcal.servicecal__Overdraft_ADL__c;
        }
        if (Servcal.servicecal__Overdraft_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_AMP__c = Servcal.servicecal__Overdraft_AMP__c;
        }
        if (Servcal.servicecal__Overdraft_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_D_L__c = Servcal.servicecal__Overdraft_D_L__c;
        }
        if (Servcal.servicecal__Overdraft_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_FCDL__c = Servcal.servicecal__Overdraft_FCDL__c;
        }
        if (Servcal.servicecal__Overdraft_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_FCMP__c = Servcal.servicecal__Overdraft_FCMP__c;
        }
        if (Servcal.servicecal__Overdraft_MP__c != NULL) {
            LoanRo_To_Return.lms2__Overdraft_MP__c = Servcal.servicecal__Overdraft_MP__c;
        }
        if (Servcal.servicecal__Housing_loan_Variable_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Housing_loan_Variable_ADL__c = Servcal.servicecal__Housing_loan_Variable_ADL__c;
        }
        if (Servcal.servicecal__Housing_loan_Variable_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Housing_loan_Variable_AMP__c = Servcal.servicecal__Housing_loan_Variable_AMP__c;
        }
        if (Servcal.servicecal__Housing_Loan_Variable_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Housing_Loan_Variable_D_L__c = Servcal.servicecal__Housing_Loan_Variable_D_L__c;
        }
        if (Servcal.servicecal__Housing_Loan_Variable_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Housing_Loan_Variable_FCDL__c = Servcal.servicecal__Housing_Loan_Variable_FCDL__c;
        }
        if (Servcal.servicecal__Housing_Loan_Variable_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Housing_Loan_Variable_FCMP__c = Servcal.servicecal__Housing_Loan_Variable_FCMP__c;
        }
        if (Servcal.servicecal__Housing_Loan_Variable_MP__c != NULL) {
            LoanRo_To_Return.lms2__Housing_Loan_Variable_MP__c = Servcal.servicecal__Housing_Loan_Variable_MP__c;
        }
        if (Servcal.servicecal__Lease_Hp_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Lease_Hp_ADL__c = Servcal.servicecal__Lease_Hp_ADL__c;
        }
        if (Servcal.servicecal__Lease_Hp_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Lease_Hp_AMP__c = Servcal.servicecal__Lease_Hp_AMP__c;
        }
        if (Servcal.servicecal__Lease_HP_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Lease_HP_D_L__c = Servcal.servicecal__Lease_HP_D_L__c;
        }
        if (Servcal.servicecal__Lease_Hp_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Lease_Hp_FCDL__c = Servcal.servicecal__Lease_Hp_FCDL__c;
        }
        if (Servcal.servicecal__Lease_Hp_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Lease_Hp_FCMP__c = Servcal.servicecal__Lease_Hp_FCMP__c;
        }
        if (Servcal.servicecal__Lease_HP_MP__c != NULL) {
            LoanRo_To_Return.lms2__Lease_HP_MP__c = Servcal.servicecal__Lease_HP_MP__c;
        }
        if (Servcal.servicecal__Other_ADL__c != NULL) {
            LoanRo_To_Return.lms2__Other_ADL__c = Servcal.servicecal__Other_ADL__c;
        }
        if (Servcal.servicecal__Other_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Other_AMP__c = Servcal.servicecal__Other_AMP__c;
        }
        if (Servcal.servicecal__Other_D_L__c != NULL) {
            LoanRo_To_Return.lms2__Other_D_L__c = Servcal.servicecal__Other_D_L__c;
        }
        if (Servcal.servicecal__Other_FCDL__c != NULL) {
            LoanRo_To_Return.lms2__Other_FCDL__c = Servcal.servicecal__Other_FCDL__c;
        }
        if (Servcal.servicecal__Other_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Other_FCMP__c = Servcal.servicecal__Other_FCMP__c;
        }
        if (Servcal.servicecal__Child_Support_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Child_Support_AMP__c = Servcal.servicecal__Child_Support_AMP__c;
        }
        if (Servcal.servicecal__Child_Support_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Child_Support_FCMP__c = Servcal.servicecal__Child_Support_FCMP__c;
        }
        if (Servcal.servicecal__Child_Support_MP__c != NULL) {
            LoanRo_To_Return.lms2__Child_Support_MP__c = Servcal.servicecal__Child_Support_MP__c;
        }
        if (Servcal.servicecal__Rent_Board_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Rent_Board_AMP__c = Servcal.servicecal__Rent_Board_AMP__c;
        }
        if (Servcal.servicecal__Rent_Board_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Rent_Board_FCMP__c = Servcal.servicecal__Rent_Board_FCMP__c;
        }
        if (Servcal.servicecal__Rent_Board_MP__c != NULL) {
            LoanRo_To_Return.lms2__Rent_Board_MP__c = Servcal.servicecal__Rent_Board_MP__c;
        }
        if (Servcal.servicecal__Total_FCMP__c != NULL) {
            LoanRo_To_Return.lms2__Total_FCMP__c = Servcal.servicecal__Total_FCMP__c;
        }
        if (Servcal.servicecal__Total_AMP__c != NULL) {
            LoanRo_To_Return.lms2__Total_AMP__c = Servcal.servicecal__Total_AMP__c;
        }
        if (Servcal.servicecal__Total_Commitments_AUD__c != NULL) {
            LoanRo_To_Return.lms2__Total_Commitments_AUD__c = Servcal.servicecal__Total_Commitments_AUD__c;
        }
        if (Servcal.servicecal__Total_Commitments_Foreign_Currency__c != NULL) {
            LoanRo_To_Return.lms2__Total_Commitments_Foreign_Currency__c = Servcal.servicecal__Total_Commitments_Foreign_Currency__c;
        }
        if (Servcal.servicecal__Total_Net_Commitments__c != NULL) {
            LoanRo_To_Return.lms2__Total_Net_Commitments__c = Servcal.servicecal__Total_Net_Commitments__c;
        }
        if (Servcal.servicecal__Repayment_Type__c != NULL) {
            LoanRo_To_Return.lms2__Repayment_Type__c = Servcal.servicecal__Repayment_Type__c;
        }
        if (Servcal.servicecal__New_Loan_Term_Years__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Term_Years__c = Servcal.servicecal__New_Loan_Term_Years__c;
        }
        if (Servcal.servicecal__Interest_Only_Term_Years__c != NULL) {
            LoanRo_To_Return.lms2__Interest_Only_Term_Years__c = Servcal.servicecal__Interest_Only_Term_Years__c;
        }
        if (Servcal.servicecal__New_Loan_Amount__c != NULL) {
            LoanRo_To_Return.lms2__New_Loan_Amount__c = Servcal.servicecal__New_Loan_Amount__c;
        }
        if (Servcal.servicecal__Intrest_Rate_on_new_Loan__c != NULL) {
            LoanRo_To_Return.lms2__Intrest_Rate_on_new_Loan__c = Servcal.servicecal__Intrest_Rate_on_new_Loan__c;
        }
        if (Servcal.servicecal__New_Monthly_Loan_Repayment_s__c != NULL) {
            LoanRo_To_Return.lms2__New_Monthly_Loan_Repayment_s__c = Servcal.servicecal__New_Monthly_Loan_Repayment_s__c;
        }
        if (Servcal.servicecal__Net_Disposable_Income__c != NULL) {
            LoanRo_To_Return.lms2__Net_Disposable_Income__c = Servcal.servicecal__Net_Disposable_Income__c;
        }
        if (Servcal.servicecal__Loan_Assesment_Rate_minimum_7__c != NULL) {
            LoanRo_To_Return.lms2__Loan_Assesment_Rate_minimum_7__c = Servcal.servicecal__Loan_Assesment_Rate_minimum_7__c;
        }
        if (Servcal.servicecal__minus_Existing_Commitment_Sensitivity_2__c != NULL) {
            LoanRo_To_Return.lms2__minus_Existing_Commitment_Sensitivity_2__c = Servcal.servicecal__minus_Existing_Commitment_Sensitivity_2__c;
        }
        if (Servcal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c != NULL) {
            LoanRo_To_Return.lms2__minus_New_loan_Commitment_Sensitivity_2__c = Servcal.servicecal__minus_New_loan_Commitment_Sensitivity_2__c;
        }
        if (Servcal.servicecal__Single_Adult__c != null) {
            LoanRo_To_Return.lms2__Single_Adult__c = Servcal.servicecal__Single_Adult__c;
        }
        if (Servcal.servicecal__Total_Expenses__c != NULL) {
            LoanRo_To_Return.lms2__Total_Expenses__c = Servcal.servicecal__Total_Expenses__c;
        }
        if (Servcal.servicecal__Interest_Coverage_Ratio_ICR_t__c != NULL) {
            LoanRo_To_Return.lms2__Interest_Coverage_Ratio_ICR_t__c = Servcal.servicecal__Interest_Coverage_Ratio_ICR_t__c;
        }
        if (Servcal.servicecal__Interest_Coverage_Ratio_ICR__c != NULL) {
            LoanRo_To_Return.lms2__Interest_Coverage_Ratio_ICR__c = Servcal.servicecal__Interest_Coverage_Ratio_ICR__c;
        }
        if (Servcal.servicecal__Test_1_Must_Be_Possitive_1__c != NULL) {
            LoanRo_To_Return.lms2__Test_1_Must_Be_Possitive_1__c = Servcal.servicecal__Test_1_Must_Be_Possitive_1__c;
        }
        if (Servcal.servicecal__Test_1_Must_Be_Possitive_2__c != NULL) {
            LoanRo_To_Return.lms2__Test_1_Must_Be_Possitive_2__c = Servcal.servicecal__Test_1_Must_Be_Possitive_2__c;
        }
        if (Servcal.servicecal__Test_2_Must_NOT_exceed_35_1__c != NULL) {
            LoanRo_To_Return.lms2__Test_2_Must_NOT_exceed_35_1__c = Servcal.servicecal__Test_2_Must_NOT_exceed_35_1__c;
        }
        if (Servcal.servicecal__Test_2_Must_NOT_exceed_35_2__c != NULL) {
            LoanRo_To_Return.lms2__Test_2_Must_NOT_exceed_35_2__c = Servcal.servicecal__Test_2_Must_NOT_exceed_35_2__c;
        }
        if (Servcal.servicecal__Overall_Result__c != NULL) {
            LoanRo_To_Return.lms2__Overall_Result__c = Servcal.servicecal__Overall_Result__c;
        }
        if (Servcal.servicecal__Opportunity__c != NULL) {
            LoanRo_To_Return.lms2__Opportunity__c = Servcal.servicecal__Opportunity__c;
        }


        system.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>' + LoanRo_To_Return);
        LoanRo_To_Return_List.add(LoanRo_To_Return);
        return LoanRo_To_Return_List;
    }

    public static List<lms2__Loan_Repayent_Schedule__c> Map_AmortResult_To_LoanRS(List<servicecal__Amortization_Result__c> Amort_Result_list,Decimal ServicingAmount, List<Id>Loan_Ids ,List<Id> LoanRO_Ids, Date Term_Start_date) {

        System.debug(Amort_Result_list);
        System.debug(Term_Start_date);
        List<lms2__Loan_Repayent_Schedule__c> LoanRS_To_Return_List = new List<lms2__Loan_Repayent_Schedule__c>();
        if (Amort_Result_list.size() > 0) {
            System.debug('TermStartDate' + Term_Start_date);
            for (servicecal__Amortization_Result__c MA : Amort_Result_list) {
                lms2__Loan_Repayent_Schedule__c LoanRS_To_Return = new lms2__Loan_Repayent_Schedule__c ();
                LoanRS_To_Return.lms2__Payment_Status__c = 'Pending';
                if (LoanRO_Ids.size() > 0) {
                    LoanRS_To_Return.lms2__Loan_Repayment_Option__c = LoanRO_Ids[0];
                }
                if(Loan_Ids.size()>0){
                    LoanRS_To_Return.lms2__Loan_Account_2__c = Loan_Ids[0];
                }
                if (MA.Name != NULL) {
                    //LoanRS_To_Return.Name = MA.Name;
                }

                if (MA.servicecal__Interest__c != NULL) {
                    LoanRS_To_Return.lms2__Interest__c = MA.servicecal__Interest__c;
                }
                if (ServicingAmount != NULL) {
                    LoanRS_To_Return.lms2__Servicing_Fee__c = ServicingAmount;
                }
                if (MA.servicecal__Opening_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Opening_Balance__c = MA.servicecal__Opening_Balance__c;
                }
                if (MA.servicecal__Closing_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Closing_Balance__c = MA.servicecal__Closing_Balance__c;
                }
                if (MA.servicecal__Payment__c != NULL) {
                    LoanRS_To_Return.lms2__Payment__c = MA.servicecal__Payment__c;
                    LoanRS_To_Return.lms2__Loan_Repayment_del__c = MA.servicecal__Payment__c;
                }
                if (MA.servicecal__Principal__c != NULL) {
                    LoanRS_To_Return.lms2__Principal__c = MA.servicecal__Principal__c;
                }

                if (MA.servicecal__Remaining__c != NULL) {
                    LoanRS_To_Return.lms2__Remaining__c = MA.servicecal__Remaining__c;
                }

                if (MA.servicecal__Payment_Number__c != NULL) {
                    LoanRS_To_Return.lms2__Repayment_Number_del__c = MA.servicecal__Payment_Number__c;
                    if (Term_Start_date != NULL && LoanRS_To_Return.lms2__Repayment_Number_del__c != NULL) {
                        LoanRS_To_Return.lms2__Estimated_Repayment_Date__c = Term_Start_date.addMonths(Integer.valueOf(LoanRS_To_Return.lms2__Repayment_Number_del__c));
                    }
                }

                LoanRS_To_Return_List.add(LoanRS_To_Return);
                System.debug(LoanRS_To_Return_List);
            }
        }
        return LoanRS_To_Return_List;
    }
    public static List<Fee_Expense__c> Map_AmortResult_To_LoanR(List<servicecal__Amortization_Result__c> Amort_Result_list,List<Id>Loan_Ids ,List<Id> LoanRO_Ids, List<Id> LoanRS_Id, Date Term_Start_date) {

        List<Fee_Expense__c> FeeAndExpenseInstanceList = new List<Fee_Expense__c>();
        for(Id LRS : LoanRS_Id){
        List<quoteCal__Quote_Calculator__c> calculatorInstanceFunderForFee = new List<quoteCal__Quote_Calculator__c>();
        List<Loan__c> LoanList = new List<Loan__c>();
        LoanList = [select Id, lms2__Quote_Calculator__c from Loan__c where Id =:Loan_Ids];
        calculatorInstanceFunderForFee = [Select Id, quoteCal__Servicing_Fee__c  from quoteCal__Quote_Calculator__c where Id =: LoanList[0].Quote_Calculator__c ];
        
        Fee_Expense__c FeeAndExpenseInstance = new Fee_Expense__c();
        FeeAndExpenseInstance.Loan_Repayment_Schedule__c = LRS;
        FeeAndExpenseInstance.Quote_Calculator__c = calculatorInstanceFunderForFee[0].Id;

         if(calculatorInstanceFunderForFee[0].quoteCal__Servicing_Fee__c != null){
            FeeAndExpenseInstance.Value__c = calculatorInstanceFunderForFee[0].quoteCal__Servicing_Fee__c;
        }else{
            FeeAndExpenseInstance.Value__c = 0;
        }
        FeeAndExpenseInstanceList.add(FeeAndExpenseInstance);
        }
       
          return FeeAndExpenseInstanceList;
        
       
    }

    public static List<lms2__Loan_Repayent_Schedule__c> Map_QuoteAmortResult_To_LoanRS(List<quoteCal__Amortization_Schedule__c> Amort_Result_list, Decimal ServicingAmount, List<Id> Loan_Ids, List<Id> LoanRO_Ids, Date Term_Start_date) {

        List<lms2__Loan_Repayent_Schedule__c> LoanRS_To_Return_List = new List<lms2__Loan_Repayent_Schedule__c>();
        if (Amort_Result_list.size() > 0) {
            for (quoteCal__Amortization_Schedule__c MA : Amort_Result_list) {
                lms2__Loan_Repayent_Schedule__c LoanRS_To_Return = new lms2__Loan_Repayent_Schedule__c ();
                LoanRS_To_Return.lms2__Payment_Status__c = 'Pending';
                if (LoanRO_Ids.size() > 0) {
                    LoanRS_To_Return.lms2__Loan_Repayment_Option__c = LoanRO_Ids[0];
                }
                if(Loan_Ids.size()>0){
                    LoanRS_To_Return.lms2__Loan_Account_2__c = Loan_Ids[0];
                }
                if (MA.Name != NULL) {
                    //LoanRS_To_Return.Name = MA.Name;
                }

                if (MA.quoteCal__Interest__c != NULL) {
                    LoanRS_To_Return.lms2__Interest__c = MA.quoteCal__Interest__c;
                }

                if (ServicingAmount != NULL) {
                    LoanRS_To_Return.lms2__Servicing_Fee__c = ServicingAmount;
                }

                if (MA.quoteCal__Opening_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Opening_Balance__c = MA.quoteCal__Opening_Balance__c;
                }
                if (MA.quoteCal__Closing_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Closing_Balance__c = MA.quoteCal__Closing_Balance__c;
                }
                if (MA.quoteCal__Payment__c != NULL) {
                    LoanRS_To_Return.lms2__Payment__c = MA.quoteCal__Payment__c;
                    LoanRS_To_Return.lms2__Loan_Repayment_del__c = MA.quoteCal__Payment__c; 
                }
                if (MA.quoteCal__Principal__c != NULL) {
                    LoanRS_To_Return.lms2__Principal__c = MA.quoteCal__Principal__c;
                }

                if (MA.quoteCal__Remaining_Months__c != NULL) {
                    LoanRS_To_Return.lms2__Remaining__c = MA.quoteCal__Remaining_Months__c;
                }

                if (MA.quoteCal__Repayment_Number__c != NULL) {
                    LoanRS_To_Return.lms2__Repayment_Number_del__c = MA.quoteCal__Repayment_Number__c;
                    if (Term_Start_date != NULL && LoanRS_To_Return.lms2__Repayment_Number_del__c != NULL) {
                        LoanRS_To_Return.lms2__Estimated_Repayment_Date__c = Term_Start_date.addMonths(Integer.valueOf(LoanRS_To_Return.lms2__Repayment_Number_del__c));
                    }
                }

                LoanRS_To_Return_List.add(LoanRS_To_Return);
                System.debug(LoanRS_To_Return_List);
            }
        }
        return LoanRS_To_Return_List;
    }
    
}