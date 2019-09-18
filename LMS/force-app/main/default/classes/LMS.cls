public with sharing class LMS {

    @AuraEnabled
    public static String saveAccountData_Apex(String accountRecord) {
        Account acc = new Account();
        try {
            acc = (Account) JSON.deserialize(accountRecord, Account.class);
            if (acc != null) {
                upsert acc;
                System.debug(acc);
                return 'success';
            }
        } catch (Exception e) {
            System.debug(e);
            return e.getMessage();
        }
        return null;
    }

    @AuraEnabled
    public static OpportunityWrapper saveOpportunityData_Apex(String opportunityRecord) {
        OpportunityWrapper oppWrapper = new OpportunityWrapper();
        Opportunity opp = new Opportunity();
        try {
            opp = (Opportunity) JSON.deserialize(opportunityRecord, Opportunity.class);
            if (opp != null) {
                upsert opp;
                oppWrapper.opp = opp;
                oppWrapper.status = 'success';
                return oppWrapper;
            }
        } catch (Exception e) {
            System.debug(e);
            oppWrapper.status = e.getMessage();
            return oppWrapper;
        }
        return null;
    }

    @AuraEnabled
    public static LMS_Wrapper.LMSFinalWrapper getLoanDetails_Apex(String appId) {


        LMS_Wrapper.LMSFinalWrapper loan_complete_data = new LMS_Wrapper.LMSFinalWrapper();
        LMS_Wrapper.LoanDetail_Wrapper loan_detail = new LMS_Wrapper.LoanDetail_Wrapper();
        LMS_Wrapper.LoanRO_Wrapper loan_RO_detail = new LMS_Wrapper.LoanRO_Wrapper();
        LMS_Wrapper.Contract_Wrapper loan_Contract_detail = new LMS_Wrapper.Contract_Wrapper();
        List<LMS_Wrapper.LoanRS_Wrapper> loan_RS_detail = new List<LMS_Wrapper.LoanRS_Wrapper>();
        lms2__Loan__c loan_detail_list = new lms2__Loan__c();
        lms2__Loan_Repayment_Option__c loan_repayment_option_list = new lms2__Loan_Repayment_Option__c();
        List<lms2__Loan_Repayent_Schedule__c> loan_repayment_schedule_list = new List<lms2__Loan_Repayent_Schedule__c>();
        Opportunity opp = new Opportunity();

        try {
            if (appId != null) {

                //opp = (Opportunity) JSON.deserialize(appId, Opportunity.class);

                loan_detail_list = [
                        Select id,Name,lms2__Account_Name__c,lms2__Application_Related_To__c,lms2__Current_Monthly_Loan_Repayment_c__c,lms2__Financial_Calculator_Scenario__c,
                                lms2__Serviceability_Calculator_Scenario__c,lms2__Contract__c,lms2__Loan_Account_No__c,lms2__Loan_Amount_c__c,lms2__Quote_Calculator__c, lms2__Loan_Repayment_Option__c,lms2__Term_of_Loan_N__c,
                                lms2__Term_End_Date__c,lms2__Term_Start_Date__c
                        from lms2__Loan__c
                        where lms2__Application_Related_To__c = :appId
                ];

                System.debug(loan_detail_list.id);
                System.debug(loan_detail_list.lms2__Serviceability_Calculator_Scenario__c);
                System.debug(loan_detail_list.lms2__Financial_Calculator_Scenario__c);

                if (loan_detail_list != null) {

                    Account acc_obj = new Account();
                    Opportunity opp_obj = new Opportunity();
                    servicecal__Non_Resident__c serv_cal = new servicecal__Non_Resident__c();
                    MortgageCalc__Financial_Calculator__c morg_cal = new MortgageCalc__Financial_Calculator__c();
                    quoteCal__Quote_Calculator__c quote_cal = new quoteCal__Quote_Calculator__c();
                    Contract contractobj = new Contract();

                    if (loan_detail_list.lms2__Application_Related_To__c != null) {
                        opp_obj = [select id,name from Opportunity where id = :loan_detail_list.lms2__Application_Related_To__c];
                        System.debug(opp_obj);
                    }

                    if (loan_detail_list.lms2__Account_Name__c != null) {
                        acc_obj = [select id,name from Account where id = :loan_detail_list.lms2__Account_Name__c];
                        System.debug(acc_obj);
                    }

                    if (loan_detail_list.lms2__Serviceability_Calculator_Scenario__c != null) {
                        System.debug(loan_detail_list.lms2__Financial_Calculator_Scenario__c);
                        System.debug(serv_cal);
                        serv_cal = [select id,name from servicecal__Non_Resident__c where id = :loan_detail_list.lms2__Serviceability_Calculator_Scenario__c];
                        System.debug(serv_cal);
                    }

                    if (loan_detail_list.lms2__Financial_Calculator_Scenario__c != null) {
                        morg_cal = [select id,name from MortgageCalc__Financial_Calculator__c where id = :loan_detail_list.lms2__Financial_Calculator_Scenario__c];
                        System.debug(morg_cal);
                    }

                    if (loan_detail_list.lms2__Quote_Calculator__c != null) {
                        quote_cal = [select id,name from quoteCal__Quote_Calculator__c where id = :loan_detail_list.lms2__Quote_Calculator__c];
                    }

                    if (loan_detail_list.lms2__Contract__c != null) {
                        contractobj = [select id,ContractNumber,StartDate,EndDate,ContractTerm from Contract where id = :loan_detail_list.lms2__Contract__c];
                        System.debug(contractobj);
                    }

                    loan_detail.Id = loan_detail_list.Id;
                    loan_detail.Name = loan_detail_list.Name;

                    if (acc_obj != null) {
                        loan_detail.AccountName = acc_obj.name;
                    }
                    if (opp_obj != null) {
                        loan_detail.ApplicationRelatedTo = opp_obj.name ;
                    }
                    if (serv_cal != null) {
                        loan_detail.ServiceabilityCalculatorScenario = serv_cal.name;
                    }

                    if (morg_cal != null) {
                        loan_detail.FinancialCalculatorScenario = morg_cal.name;
                    }
                    if (quote_cal != null) {
                        loan_detail.QuoteCalculatorScenario = 'Quote';
                    }

                    if (contractobj.id != null) {
                        loan_Contract_detail.id = contractobj.id;
                        loan_Contract_detail.ContractNumber = contractobj.ContractNumber;
                        loan_Contract_detail.StartDate = contractobj.StartDate;
                        loan_Contract_detail.EndDate = contractobj.EndDate;
                        loan_Contract_detail.Term = contractobj.ContractTerm;
                        loan_complete_data.ContractObj = loan_Contract_detail;

                    }

                    loan_detail.LoanAccountNo = loan_detail_list.lms2__Loan_Account_No__c;
                    loan_detail.LoanAmount = loan_detail_list.lms2__Loan_Amount_c__c;
                    loan_detail.TermEndDate = loan_detail_list.lms2__Term_End_Date__c;
                    loan_detail.TermofLoan = loan_detail_list.lms2__Term_of_Loan_N__c;
                    loan_detail.TermStartDate = loan_detail_list.lms2__Term_Start_Date__c;
                    loan_detail.CurrentMonthlyLoanRepayment = loan_detail_list.lms2__Current_Monthly_Loan_Repayment_c__c;

                    loan_complete_data.Loan_Details = loan_detail;


                    Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.lms2__Loan_Repayment_Option__c.fields.getMap();
                    Set<String> All_Fields = mapOfFields.keySet();
                    String Fieldz_To_Query = 'Select ';
                    for (String Fld : All_Fields) {
                        Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                    }
                    Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                    //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                    Fieldz_To_Query += ' ' + 'From lms2__Loan_Repayment_Option__c Order By LastModifiedDate DESC LIMIT 1';
                    loan_repayment_option_list = Database.Query(Fieldz_To_Query);


                    if (loan_repayment_option_list != null) {
                        loan_RO_detail.id = loan_repayment_option_list.Id;
                        loan_RO_detail.Name = loan_repayment_option_list.Name;
                        loan_RO_detail.Account = loan_repayment_option_list.lms2__Account__c;
                        loan_RO_detail.AdditionalMonthlyLoanRepayment = loan_repayment_option_list.lms2__AdditionalMonthlyLoanRepayment__c;
                        loan_RO_detail.Annual_Interest_Rate = loan_repayment_option_list.lms2__Annual_Interest_Rate__c;
                        loan_RO_detail.Annual_Interest_Rate_Sensitivity = loan_repayment_option_list.lms2__Annual_Interest_Rate_Sensitivity__c;
                        loan_RO_detail.Annual_Rental_Income_s_GAI = loan_repayment_option_list.lms2__Annual_Rental_Income_s_GAI__c;
                        loan_RO_detail.Annual_Rental_Income_s_NMI = loan_repayment_option_list.lms2__Annual_Rental_Income_s_NMI__c;
                        loan_RO_detail.Anual_Rental_Income_s_AGI = loan_repayment_option_list.lms2__Anual_Rental_Income_s_AGI__c;
                        loan_RO_detail.Anual_Rental_Income_s_GFI = loan_repayment_option_list.lms2__Anual_Rental_Income_s_GFI__c;
                        loan_RO_detail.Anual_Rental_Income_s_NFI = loan_repayment_option_list.lms2__Anual_Rental_Income_s_NFI__c;
                        loan_RO_detail.Anual_Rental_Income_s_TNMI = loan_repayment_option_list.lms2__Anual_Rental_Income_s_TNMI__c;
                        loan_RO_detail.Applicant_1_Income_AGI = loan_repayment_option_list.lms2__Applicant_1_Income_AGI__c;
                        loan_RO_detail.Applicant_1_Income_GFI = loan_repayment_option_list.lms2__Applicant_1_Income_GFI__c;
                        loan_RO_detail.Applicant_1_Income_NFI = loan_repayment_option_list.lms2__Applicant_1_Income_NFI__c ;
                        loan_RO_detail.Applicant_1_Income_TNMI = loan_repayment_option_list.lms2__Applicant_1_Income_TNMI__c;
                        loan_RO_detail.Applicant_2_Income_AGI = loan_repayment_option_list.lms2__Applicant_2_Income_AGI__c;
                        loan_RO_detail.Applicant_2_Income_GFI = loan_repayment_option_list.lms2__Applicant_2_Income_GFI__c;
                        loan_RO_detail.Applicant_2_Income_NFI = loan_repayment_option_list.lms2__Applicant_2_Income_NFI__c;
                        loan_RO_detail.Applicant_2_Income_TNMI = loan_repayment_option_list.lms2__Applicant_2_Income_TNMI__c;
                        loan_RO_detail.Applicant_3_Income_AGI = loan_repayment_option_list.lms2__Applicant_3_Income_AGI__c;
                        loan_RO_detail.Applicant_3_Income_GFI = loan_repayment_option_list.lms2__Applicant_3_Income_GFI__c;
                        loan_RO_detail.Applicant_3_Income_NFI = loan_repayment_option_list.lms2__Applicant_3_Income_NFI__c;
                        loan_RO_detail.Applicant_3_Income_TNM = loan_repayment_option_list.lms2__Applicant_3_Income_TNM__c;
                        loan_RO_detail.Applicant_4_Income_AGI = loan_repayment_option_list.lms2__Applicant_4_Income_AGI__c;
                        loan_RO_detail.Applicant_4_Income_GFI = loan_repayment_option_list.lms2__Applicant_4_Income_GFI__c;
                        loan_RO_detail.Applicant_4_Income_NFI = loan_repayment_option_list.lms2__Applicant_4_Income_NFI__c;
                        loan_RO_detail.Applicant_4_Income_TNMI = loan_repayment_option_list.lms2__Applicant_4_Income_TNMI__c;
                        loan_RO_detail.AverageAnnual_Inflation_Rate = loan_repayment_option_list.lms2__AverageAnnual_Inflation_Rate__c;
                        loan_RO_detail.Capitalized_cost = loan_repayment_option_list.lms2__Capitalized_cost__c;
                        loan_RO_detail.Capital_Outstanding = loan_repayment_option_list.lms2__Capital_Outstanding__c;
                        loan_RO_detail.Capital_Repaid = loan_repayment_option_list.lms2__Capital_Repaid__c;
                        loan_RO_detail.Children = loan_repayment_option_list.lms2__Children__c;
                        loan_RO_detail.Closing_Balance = loan_repayment_option_list.lms2__Closing_Balance__c;
                        loan_RO_detail.Company_1_Profit_AGI = loan_repayment_option_list.lms2__Company_1_Profit_AGI__c;
                        loan_RO_detail.Company_1_Profit_NFI = loan_repayment_option_list.lms2__Company_1_Profit_NFI__c;
                        loan_RO_detail.Company_1_Profit_TNMI = loan_repayment_option_list.lms2__Company_1_Profit_TNMI__c;
                        loan_RO_detail.Company_1_Profit_c = loan_repayment_option_list.lms2__Company_1_Profit_GFI__c;
                        loan_RO_detail.Company_2_Profit = loan_repayment_option_list.lms2__Company_2_Profit__c;
                        loan_RO_detail.Company_2_Profit_AGI = loan_repayment_option_list.lms2__Company_2_Profit_AGI__c;
                        loan_RO_detail.Company_2_Profit_NFI = loan_repayment_option_list.lms2__Company_2_Profit_NFI__c;
                        loan_RO_detail.Company_2_Profit_TNMI = loan_repayment_option_list.lms2__Company_2_Profit_TNMI__c;
                        loan_RO_detail.Country_of_Residence = loan_repayment_option_list.lms2__Country_of_Residence__c;
                        loan_RO_detail.Couples = loan_repayment_option_list.lms2__Couples__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_ADL = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_ADL__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_AMP = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_AMP__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_D_L = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_D_L__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_FCDL = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_FCDL__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_FCMP = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_FCMP__c;
                        loan_RO_detail.Credit_Card_Limit_not_debt_MP = loan_repayment_option_list.lms2__Credit_Card_Limit_not_debt_MP__c;
                        loan_RO_detail.Debt_Service_Ratio_DSR = loan_repayment_option_list.lms2__Debt_Service_Ratio_DSR__c;
                        loan_RO_detail.Debt_Service_Ratio_t_DSR = loan_repayment_option_list.lms2__Debt_Service_Ratio_t_DSR__c;
                        loan_RO_detail.Estimated_Repayment_Date = loan_repayment_option_list.lms2__Estimated_Repayment_Date__c;
                        loan_RO_detail.Fixed_Monthly_Repayments = loan_repayment_option_list.lms2__Fixed_Monthly_Repayments__c;
                        loan_RO_detail.Fixed_Rate = loan_repayment_option_list.lms2__Fixed_Rate__c;
                        loan_RO_detail.Fixed_Term = loan_repayment_option_list.lms2__Fixed_Term__c;
                        loan_RO_detail.Foreign_Currency = loan_repayment_option_list.lms2__Foreign_Currency__c;
                        loan_RO_detail.Foreign_Currency_Exchange_Rate = loan_repayment_option_list.lms2__Foreign_Currency_Exchange_Rate__c;
                        loan_RO_detail.Child_Support_AMP = loan_repayment_option_list.lms2__Child_Support_AMP__c;
                        loan_RO_detail.Child_Support_FCMP = loan_repayment_option_list.lms2__Child_Support_FCMP__c;
                        loan_RO_detail.Housing_loan_Variable_ADL = loan_repayment_option_list.lms2__Housing_loan_Variable_ADL__c;
                        loan_RO_detail.Housing_loan_Variable_AMP = loan_repayment_option_list.lms2__Housing_loan_Variable_AMP__c;
                        loan_RO_detail.Housing_Loan_Variable_D_L = loan_repayment_option_list.lms2__Housing_Loan_Variable_D_L__c ;
                        loan_RO_detail.Housing_Loan_Variable_FCDL = loan_repayment_option_list.lms2__Housing_Loan_Variable_FCDL__c;
                        loan_RO_detail.Housing_Loan_Variable_FCMP = loan_repayment_option_list.lms2__Housing_Loan_Variable_FCMP__c;
                        loan_RO_detail.Housing_Loan_Variable_MP = loan_repayment_option_list.lms2__Housing_Loan_Variable_MP__c;
                        loan_RO_detail.Interest_Charged = loan_repayment_option_list.lms2__Interest_Charged__c;
                        loan_RO_detail.Interest_Coverage_Ratio_ICR = loan_repayment_option_list.lms2__Interest_Coverage_Ratio_ICR__c;
                        loan_RO_detail.Interest_Coverage_Ratio_ICR_t = loan_repayment_option_list.lms2__Interest_Coverage_Ratio_ICR_t__c;
                        loan_RO_detail.Interest_Only_Term_Years = loan_repayment_option_list.lms2__Interest_Only_Term_Years__c;
                        loan_RO_detail.Intrest_Rate_on_new_Loan = loan_repayment_option_list.lms2__Intrest_Rate_on_new_Loan__c;
                        loan_RO_detail.Lease_Hp_ADL = loan_repayment_option_list.lms2__Lease_Hp_ADL__c;
                        loan_RO_detail.Lease_Hp_AMP = loan_repayment_option_list.lms2__Lease_Hp_AMP__c;
                        loan_RO_detail.Lease_HP_D_L = loan_repayment_option_list.lms2__Lease_HP_D_L__c;
                        loan_RO_detail.Lease_Hp_FCDL = loan_repayment_option_list.lms2__Lease_Hp_FCDL__c;
                        loan_RO_detail.Lease_Hp_FCMP = loan_repayment_option_list.lms2__Lease_Hp_FCMP__c;
                        loan_RO_detail.Lease_HP_MP = loan_repayment_option_list.lms2__Lease_HP_MP__c;
                        loan_RO_detail.Lease_price = loan_repayment_option_list.lms2__Lease_price__c;
                        loan_RO_detail.Living_Expenses_Used = loan_repayment_option_list.lms2__Living_Expenses_Used__c;
                        loan_RO_detail.Loan = loan_repayment_option_list.lms2__Loan__c;
                        loan_RO_detail.Loan_Amount = loan_repayment_option_list.lms2__New_Loan_Amount__c;
                        loan_RO_detail.Loan_Assesment_Rate_minimum_7 = loan_repayment_option_list.lms2__Loan_Assesment_Rate_minimum_7__c;
                        loan_RO_detail.Loan_Period = loan_repayment_option_list.lms2__Loan_Period__c;
                        loan_RO_detail.Loan_Repayment = loan_repayment_option_list.lms2__Loan_Repayment__c;
                        loan_RO_detail.Loan_Type = loan_repayment_option_list.lms2__Loan_Type__c;
                        loan_RO_detail.minus_Existing_Commitment_Sensitivity_2 = loan_repayment_option_list.lms2__minus_Existing_Commitment_Sensitivity_2__c;
                        loan_RO_detail.minus_New_loan_Commitment_Sensitivity_2 = loan_repayment_option_list.lms2__minus_New_loan_Commitment_Sensitivity_2__c;
                        loan_RO_detail.Monthly_depreciation_fee = loan_repayment_option_list.lms2__Monthly_depreciation_fee__c;
                        loan_RO_detail.Monthly_Difference = loan_repayment_option_list.lms2__Monthly_Difference__c;
                        loan_RO_detail.Monthly_Living_Expenses_AUD = loan_repayment_option_list.lms2__Monthly_Living_Expenses_AUD__c;
                        loan_RO_detail.Monthly_Living_Expenses_FC = loan_repayment_option_list.lms2__Monthly_Living_Expenses_FC__c;
                        loan_RO_detail.Monthly_Loan_Repayment = loan_repayment_option_list.lms2__Monthly_Loan_Repayment__c;
                        loan_RO_detail.Monthly_payment = loan_repayment_option_list.lms2__Monthly_payment__c;
                        loan_RO_detail.Net_Disposable_Income = loan_repayment_option_list.lms2__Net_Disposable_Income__c;
                        loan_RO_detail.New_Loan_Term_Years = loan_repayment_option_list.lms2__New_Loan_Term_Years__c;
                        loan_RO_detail.New_Monthly_Loan_Repayment_s = loan_repayment_option_list.lms2__New_Monthly_Loan_Repayment_s__c;
                        loan_RO_detail.Opportunity = loan_repayment_option_list.lms2__Opportunity__c;
                        loan_RO_detail.Other_ADL = loan_repayment_option_list.lms2__Other_ADL__c;
                        loan_RO_detail.Other_AMP = loan_repayment_option_list.lms2__Other_AMP__c;
                        loan_RO_detail.Other_D_L = loan_repayment_option_list.lms2__Other_D_L__c;
                        loan_RO_detail.Other_FCDL = loan_repayment_option_list.lms2__Other_FCDL__c;
                        loan_RO_detail.Other_FCMP = loan_repayment_option_list.lms2__Other_FCMP__c;
                        loan_RO_detail.Overall_Result = loan_repayment_option_list.lms2__Overall_Result__c;
                        loan_RO_detail.Overdraft_ADL = loan_repayment_option_list.lms2__Overdraft_ADL__c;
                        loan_RO_detail.Overdraft_AMP = loan_repayment_option_list.lms2__Overdraft_AMP__c;
                        loan_RO_detail.Overdraft_D_L = loan_repayment_option_list.lms2__Overdraft_D_L__c;
                        loan_RO_detail.Overdraft_FCDL = loan_repayment_option_list.lms2__Overdraft_FCDL__c;
                        loan_RO_detail.Overdraft_FCMP = loan_repayment_option_list.lms2__Overdraft_FCMP__c;
                        loan_RO_detail.Overdraft_MP = loan_repayment_option_list.lms2__Overdraft_MP__c;
                        loan_RO_detail.Personal_loan_Fixed_ADL = loan_repayment_option_list.lms2__Personal_loan_Fixed_ADL__c;
                        loan_RO_detail.Personal_loan_Fixed_AMP = loan_repayment_option_list.lms2__Personal_loan_Fixed_AMP__c;
                        loan_RO_detail.Personal_Loan_Fixed_D_L = loan_repayment_option_list.lms2__Personal_Loan_Fixed_D_L__c;
                        loan_RO_detail.Personal_loan_Fixed_FCDL = loan_repayment_option_list.lms2__Personal_loan_Fixed_FCDL__c;
                        loan_RO_detail.Personal_loan_Fixed_FCMP = loan_repayment_option_list.lms2__Personal_loan_Fixed_FCMP__c;
                        loan_RO_detail.Personal_loan_Fixed_MP = loan_repayment_option_list.lms2__Personal_Loan_Fixed_MP__c;
                        loan_RO_detail.Personal_loan_Variable_ADL = loan_repayment_option_list.lms2__Personal_loan_Variable_ADL__c;
                        loan_RO_detail.Personal_loan_Variable_AMP = loan_repayment_option_list.lms2__Personal_loan_Variable_AMP__c;
                        loan_RO_detail.Personal_Loan_Variable_D_L = loan_repayment_option_list.lms2__Personal_Loan_Variable_D_L__c;
                        loan_RO_detail.Personal_loan_Variable_FCDL = loan_repayment_option_list.lms2__Personal_loan_Variable_FCDL__c;
                        loan_RO_detail.Personal_loan_Variable_FCMP = loan_repayment_option_list.lms2__Personal_loan_Variable_FCMP__c;
                        loan_RO_detail.Personal_Loan_Variable_MP = loan_repayment_option_list.lms2__Personal_Loan_Variable_MP__c;
                        loan_RO_detail.Rent_Board_AMP = loan_repayment_option_list.lms2__Rent_Board_AMP__c;
                        loan_RO_detail.Rent_Board_FCMP = loan_repayment_option_list.lms2__Rent_Board_FCMP__c;
                        loan_RO_detail.Rent_Board_MP = loan_repayment_option_list.lms2__Rent_Board_MP__c;
                        loan_RO_detail.Repayment_Type = loan_repayment_option_list.lms2__Repayment_Type__c;
                        loan_RO_detail.Residual_value = loan_repayment_option_list.lms2__Residual_value__c;
                        loan_RO_detail.Repayment_Frequency = loan_repayment_option_list.lms2__Repayment_Frequency__c;
                        loan_RO_detail.Single_Adult = loan_repayment_option_list.lms2__Single_Adult__c;
                        loan_RO_detail.Test_1_Must_Be_Possitive_1 = loan_repayment_option_list.lms2__Test_1_Must_Be_Possitive_1__c;
                        loan_RO_detail.Test_1_Must_Be_Possitive_2 = loan_repayment_option_list.lms2__Test_1_Must_Be_Possitive_2__c;
                        loan_RO_detail.Test_2_Must_NOT_exceed_35_1 = loan_repayment_option_list.lms2__Test_2_Must_NOT_exceed_35_1__c;
                        loan_RO_detail.Test_2_Must_NOT_exceed_35_2 = loan_repayment_option_list.lms2__Test_2_Must_NOT_exceed_35_2__c;
                        loan_RO_detail.Total_AGI = loan_repayment_option_list.lms2__Total_AGI__c;
                        loan_RO_detail.Total_AMP = loan_repayment_option_list.lms2__Total_AMP__c;
                        loan_RO_detail.Total_Commitments_AUD = loan_repayment_option_list.lms2__Total_Commitments_AUD__c;
                        loan_RO_detail.Total_Commitments_Foreign_Currency = loan_repayment_option_list.lms2__Total_Commitments_Foreign_Currency__c;
                        loan_RO_detail.Total_Expenses = loan_repayment_option_list.lms2__Total_Expenses__c;
                        loan_RO_detail.Total_FCMP = loan_repayment_option_list.lms2__Total_FCMP__c;
                        loan_RO_detail.Total_GFI = loan_repayment_option_list.lms2__Total_GFI__c;
                        loan_RO_detail.Total_Gross_Income = loan_repayment_option_list.lms2__Total_Gross_Income__c;
                        loan_RO_detail.Total_income_available_for_debt = loan_repayment_option_list.lms2__Total_income_available_for_debt__c;
                        loan_RO_detail.Total_Income_GAI = loan_repayment_option_list.lms2__Total_Income_GAI__c;
                        loan_RO_detail.Total_Income = loan_repayment_option_list.lms2__Total_Income__c;
                        loan_RO_detail.Total_Interest_over_Loan_Period = loan_repayment_option_list.lms2__Total_Interest_over_Loan_Period__c;
                        loan_RO_detail.Total_Living_Expenses = loan_repayment_option_list.lms2__Total_Living_Expenses__c;
                        loan_RO_detail.Total_Loan_Repayment_over_Loan_P = loan_repayment_option_list.lms2__Total_Loan_Repayment_over_Loan_P__c;
                        loan_RO_detail.Total_Net_Commitments = loan_repayment_option_list.lms2__Total_Net_Commitments__c;
                        loan_RO_detail.Total_Net_Income = loan_repayment_option_list.lms2__Total_Net_Income__c;
                        loan_RO_detail.Total_NFI = loan_repayment_option_list.lms2__Total_NFI__c;


                        loan_complete_data.LoanRO = loan_RO_detail;

                        loan_repayment_schedule_list = [
                                Select id,Name,lms2__Capitalized_cost_del__c,lms2__Capital_Outstanding__c,lms2__Capital_Repaid_del__c,lms2__Servicing_Fee__c,
                                        lms2__Closing_Balance__c,lms2__Loan_Calculator__c,lms2__Estimated_Repayment_Date__c,lms2__Fixed_Monthly_Repayments_del__c,
                                        lms2__Interest__c,lms2__Lease_price_del__c,lms2__Loan_Repayment_del__c,lms2__Loan_Repayment_Option__c,
                                        lms2__Monthly_depreciation_fee_del__c,lms2__Monthly_lease_fee_del__c,lms2__Monthly_payment_del__c,
                                        lms2__Montlhy_sales_tax_payment_del__c,lms2__Opening_Balance__c,lms2__Payment_Date__c,lms2__Payment__c,
                                        lms2__Payment_Number__c,lms2__Payment_Status__c,lms2__Pre_tax_montlhy_payment_del__c,lms2__Principal__c,
                                        lms2__Remaining__c,lms2__Repayment_Number_del__c,lms2__Residual_value_del__c
                                from lms2__Loan_Repayent_Schedule__c
                                where lms2__Loan_Repayment_Option__c = :loan_repayment_option_list.Id
                                order by lms2__Estimated_Repayment_Date__c
                        ];

                        if (loan_repayment_schedule_list.size() > 0) {
                            for (lms2__Loan_Repayent_Schedule__c LRS : loan_repayment_schedule_list) {

                                LMS_Wrapper.LoanRS_Wrapper loan_RS_detail_Obj = new LMS_Wrapper.LoanRS_Wrapper();

                                loan_RS_detail_Obj.id = LRS.id;
                                loan_RS_detail_Obj.Name = LRS.Name;
                                loan_RS_detail_Obj.Capitalizedcost = LRS.lms2__Capitalized_cost_del__c;
                                loan_RS_detail_Obj.CapitalOutstanding = Double.valueOf(LRS.lms2__Capital_Outstanding__c);
                                loan_RS_detail_Obj.CapitalRepaid = LRS.lms2__Capital_Repaid_del__c;
                                loan_RS_detail_Obj.ClosingBalance = Double.valueOf(LRS.lms2__Closing_Balance__c);
                                loan_RS_detail_Obj.ServicingAmount = Double.valueOf(LRS.lms2__Servicing_Fee__c);
                                loan_RS_detail_Obj.Loan_Calculator = LRS.lms2__Loan_Calculator__c;
                                loan_RS_detail_Obj.EstimatedRepaymentDate = LRS.lms2__Estimated_Repayment_Date__c;
                                loan_RS_detail_Obj.FixedMonthlyRepayments = LRS.lms2__Fixed_Monthly_Repayments_del__c;
                                loan_RS_detail_Obj.Interest = Double.valueOf(LRS.lms2__Interest__c);
                                loan_RS_detail_Obj.Payment = Double.valueOf(LRS.lms2__Payment__c);
                                loan_RS_detail_Obj.Leaseprice = LRS.lms2__Lease_price_del__c;
                                loan_RS_detail_Obj.LoanRepayment = LRS.lms2__Loan_Repayment_del__c;
                                loan_RS_detail_Obj.LoanRepaymentOption = LRS.lms2__Loan_Repayment_Option__c;
                                loan_RS_detail_Obj.Monthlydepreciationfee = LRS.lms2__Monthly_depreciation_fee_del__c;
                                loan_RS_detail_Obj.Monthlyleasefee = LRS.lms2__Monthly_lease_fee_del__c;
                                loan_RS_detail_Obj.Monthlypayment = LRS.lms2__Monthly_payment_del__c;
                                loan_RS_detail_Obj.Montlhysalestaxpayment = LRS.lms2__Montlhy_sales_tax_payment_del__c;
                                loan_RS_detail_Obj.OpeningBalance = LRS.lms2__Opening_Balance__c;
                                loan_RS_detail_Obj.PaymentDate = LRS.lms2__Payment_Date__c;
                                loan_RS_detail_Obj.PaymentNumber = LRS.lms2__Payment_Number__c;
                                loan_RS_detail_Obj.PaymentStatus = LRS.lms2__Payment_Status__c;
                                loan_RS_detail_Obj.Pretaxmontlhypayment = LRS.lms2__Pre_tax_montlhy_payment_del__c;
                                loan_RS_detail_Obj.Principal = Double.valueOf(LRS.lms2__Principal__c);
                                loan_RS_detail_Obj.Remaining = LRS.lms2__Remaining__c;
                                loan_RS_detail_Obj.RepaymentNumber = LRS.lms2__Repayment_Number_del__c;
                                loan_RS_detail_Obj.Residualvalue = LRS.lms2__Residual_value_del__c;

                                loan_RS_detail.add(loan_RS_detail_Obj);

                            }
                            loan_complete_data.LoanRS_List = loan_RS_detail;


                            return loan_complete_data;
                        }

                        return null;
                    }

                    return null;

                }

                return null;

            }
        } catch (Exception e) {
            System.debug(e);
        }
        return null;

    }

    @AuraEnabled
    public static List<getCalculatorWrapper> getCalculatorsList(String oppId) {

        List<servicecal__Non_Resident__c> ServCalList = new List<servicecal__Non_Resident__c>();
        List<MortgageCalc__Financial_Calculator__c> MortCalList = new List<MortgageCalc__Financial_Calculator__c>();
        List<quoteCal__Quote_Calculator__c> quoteCalList = new List<quoteCal__Quote_Calculator__c>();
        //List<Sobject> CalcList = new List<Sobject>();
        List<getCalculatorWrapper> CalcListFinal = new List<getCalculatorWrapper>();
        try {
            System.debug(oppId);
            if (oppId != null) {
                ServCalList = [Select Id, Name, CreatedDate,servicecal__New_Monthly_Loan_Repayment_s__c, servicecal__Opportunity__c,servicecal__Opportunity__r.CloseDate,servicecal__New_Loan_Term_Years__c,servicecal__New_Loan_Amount__c,servicecal__Intrest_Rate_on_new_Loan__c from servicecal__Non_Resident__c where servicecal__Opportunity__c = :oppId];
                MortCalList = [Select Id, Name, CreatedDate,MortgageCalc__Monthly_Loan_Repayment__c, MortgageCalc__Account__c, MortgageCalc__Contact__c,MortgageCalc__Annual_Interest_Rate__c,MortgageCalc__Loan_Amount__c,MortgageCalc__Loan_Period__c, MortgageCalc__Opportunity__c,MortgageCalc__Opportunity__r.CloseDate from MortgageCalc__Financial_Calculator__c where MortgageCalc__Opportunity__c = :oppId];
                quoteCalList = [Select Id, Name, CreatedDate,quoteCal__Customer_Rate_Expected__c,quoteCal__Customer_Rate_Non_Published__c,quoteCal__Repayment_Non_Published__c, quoteCal__Desired_Base_Rate__c,quoteCal__Amount_Financed__c,quoteCal__Term_months__c, quoteCal__Opportunity__c,quoteCal__Opportunity__r.CloseDate from quoteCal__Quote_Calculator__c where quoteCal__Opportunity__c = :oppId];
                //CalcList.addAll(ServCalList);
                //CalcList.addAll(MortCalList);
               // System.debug('MortCalList>>'+MortCalList);
               // System.debug('ServCalList>>'+ServCalList);
               // System.debug('quoteCalList>>'+quoteCalList);

                if (ServCalList.size() > 0) {

                    for (servicecal__Non_Resident__c calcRecord : ServCalList) {

                        getCalculatorWrapper wrap_obj = new getCalculatorWrapper();

                        wrap_obj.Id = calcRecord.Id;
                        wrap_obj.Name = calcRecord.Name;
                        wrap_obj.TermStartDate = calcRecord.servicecal__Opportunity__r.CloseDate;
                        //wrap_obj.CreatedDate = calcRecord.CreatedDate.date();
                        wrap_obj.LoanAmount = calcRecord.servicecal__New_Loan_Amount__c;
                        wrap_obj.LoanPeriod = Integer.valueof(calcRecord.servicecal__New_Loan_Term_Years__c);
                        //wrap_obj.Interest = calcRecord.servicecal__Intrest_Rate_on_new_Loan__c;
                        wrap_obj.FinalRate = calcRecord.servicecal__Intrest_Rate_on_new_Loan__c.setScale(2);
                        wrap_obj.Repayment = calcRecord.servicecal__New_Monthly_Loan_Repayment_s__c.setScale(2);
                        CalcListFinal.add(wrap_obj);

                    }
                }

                if (MortCalList.size() > 0) {

                    for (MortgageCalc__Financial_Calculator__c calcRecord : MortCalList) {

                        getCalculatorWrapper wrap_obj = new getCalculatorWrapper();

                        wrap_obj.Id = calcRecord.Id;
                        wrap_obj.Name = calcRecord.Name;
                        wrap_obj.TermStartDate = calcRecord.MortgageCalc__Opportunity__r.CloseDate;
                        //wrap_obj.CreatedDate = calcRecord.CreatedDate.date();
                        wrap_obj.LoanAmount = calcRecord.MortgageCalc__Loan_Amount__c;
                        wrap_obj.LoanPeriod = Integer.valueof(calcRecord.MortgageCalc__Loan_Period__c);
                        //wrap_obj.Interest = calcRecord.MortgageCalc__Annual_Interest_Rate__c;
                        wrap_obj.FinalRate = calcRecord.MortgageCalc__Annual_Interest_Rate__c.setScale(2);
                        wrap_obj.Repayment = calcRecord.MortgageCalc__Monthly_Loan_Repayment__c.setScale(2);
                        CalcListFinal.add(wrap_obj);

                    }
                }

                if (quoteCalList.size() > 0) {

                    for (quoteCal__Quote_Calculator__c calcRecord : quoteCalList) {

                        getCalculatorWrapper wrap_obj = new getCalculatorWrapper();

                        wrap_obj.Id = calcRecord.Id;
                        wrap_obj.Name = calcRecord.Name;
                        wrap_obj.TermStartDate = calcRecord.quoteCal__Opportunity__r.CloseDate;
                        // wrap_obj.CreatedDate = calcRecord.CreatedDate.date();
                        wrap_obj.LoanAmount = calcRecord.quoteCal__Amount_Financed__c;
                        wrap_obj.LoanPeriod = Integer.valueof(calcRecord.quoteCal__Term_months__c);
                        // wrap_obj.Interest = calcRecord.quoteCal__Desired_Base_Rate__c;
                        wrap_obj.FinalRate = calcRecord.quoteCal__Customer_Rate_Non_Published__c.setScale(2);
                        wrap_obj.Repayment = calcRecord.quoteCal__Repayment_Non_Published__c.setScale(2);
                        CalcListFinal.add(wrap_obj);

                    }
                }

                if (CalcListFinal.size() > 0) {
                    System.debug(CalcListFinal);
                    return CalcListFinal;
                } else {
                    return null;
                }

            } else {
                return null;
            }


        } catch (Exception e) {
            //throw new AuraHandledException('Error ' + e.getMessage() + ' Line number ' + e.getLineNumber());
            System.debug(e.getMessage());
        }

        return null;

    }

    @AuraEnabled
    public static String ConvertToLoan(String appId) {

       // System.debug(appId);
        Set<Id> Opp_Ids = new Set<Id>();
        Set<Id> Fin_Cals_Ids = new Set<Id>();
        Set<Id> Serv_Cals_Ids = new Set<Id>();
        Set<Id> quote_Cals_Ids = new Set<Id>();
        List<lms2__Loan__c> Existing_loan_List = new List<lms2__Loan__c >();
        List<MortgageCalc__Financial_Calculator__c> Fin_Cals_List = new List<MortgageCalc__Financial_Calculator__c>();
        List<servicecal__Non_Resident__c> Serv_Cals_List = new List<servicecal__Non_Resident__c>();
        List<MortgageCalc__Month_Amort__c> Month_Amort_List = new List<MortgageCalc__Month_Amort__c>();
        List<servicecal__Amortization_Result__c> Amort_Result_list = new List<servicecal__Amortization_Result__c>();
        List<quoteCal__Quote_Calculator__c> quoteCalList = new List<quoteCal__Quote_Calculator__c>();
        List<quoteCal__Amortization_Schedule__c> quoteAmortList = new List<quoteCal__Amortization_Schedule__c>();

        Id id_app = Id.valueOf(appId);
        Schema.SObjectType sobjectType = id_app.getSObjectType();
        String sobjectName = sobjectType.getDescribe().getName();

        Set<Id> oppId = new Set<Id>();
        String Message_To_Return = 'Something mishappened';
        List<Id> Loan_Id = new List<Id>();
        Boolean create_task = True;
        List<Id> LoanRO_Id = new List<Id>();
        List<Id> LoanRS_Id = new List<Id>();
        List<lms2__Loan_Repayment_Option__c> LoanRO_List = new List<lms2__Loan_Repayment_Option__c>();
        List<lms2__Loan_Repayent_Schedule__c> LoanRS_List = new List<lms2__Loan_Repayent_Schedule__c>();
        List<lms2__Loan_Repayment__c> LoanR_List = new List<lms2__Loan_Repayment__c>();

        if (sobjectName == 'servicecal__Non_Resident__c') {
            Serv_Cals_List = Database.query('Select Id, Name, servicecal__Opportunity__c From ' + sobjectName + ' Where Id = :id_app');
            System.debug(Serv_Cals_List);
            oppId.add(Serv_Cals_List[0].servicecal__Opportunity__c);
        }

        else if (sobjectName == 'MortgageCalc__Financial_Calculator__c') {
            Fin_Cals_List = Database.query('Select Id, Name,MortgageCalc__Monthly_Loan_Repayment__c,MortgageCalc__Loan_Amount__c,MortgageCalc__Loan_Period__c,MortgageCalc__Opportunity__c From ' + sobjectName + ' Where Id = :id_app');
            System.debug(Fin_Cals_List);
            oppId.add(Fin_Cals_List[0].MortgageCalc__Opportunity__c);
        }

        else if (sobjectName == 'quoteCal__Quote_Calculator__c') {
            quoteCalList = Database.query('Select Id, quoteCal__Desired_Base_Rate__c,quoteCal__Servicing_Fee__c,quoteCal__Amount_Financed__c,quoteCal__Term_months__c, quoteCal__Opportunity__c, quoteCal__Repayment_Non_Published__c From ' + sobjectName + ' Where Id = :id_app');
            System.debug(quoteCalList);
            oppId.add(quoteCalList[0].quoteCal__Opportunity__c);
        }
        System.debug(oppId);

        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [Select Id,AccountId,StageName,lms2__Application_Number1__c,lms2__Lender__c,lms2__Term_Start_Date__c,CloseDate,Amount From Opportunity Where Id = :oppId LIMIT 1];
        system.debug('oppList==========='+oppList);
        try {
            if (oppList.size() > 0) {

                Opportunity opp = new Opportunity();
                opp = oppList[0];
                system.debug('>>>>>Opp -->' + opp);
                system.debug('>>>>>sobjectName -->' + sobjectName);
                //Check whether this Application already had a Loan ?

                Existing_loan_List = [Select Id From lms2__Loan__c Where lms2__Application_Related_To__c = :oppId];
                if (Existing_loan_List.size() > 0) {
                    Message_To_Return = 'Loan already exist! Can\'t proceed further.';
                    return Message_To_Return;
                }
                //If Stage is not settled, return the required Message.
                if (opp.StageName != 'Settled') {
                    Message_To_Return = 'Sorry! This Application is not Applicable for Loan as it is not "Settled" yet.';
                    return Message_To_Return;
                }
                //Check for Term Start Date
                if (opp.CloseDate == NULL) {
                    Message_To_Return = 'Please fill Term Start Date before converting to a Loan.';
                    return Message_To_Return;
                }
                //Initialize the Loan Record
                lms2__Loan__c loan_To_Insert = new lms2__Loan__c();
                if (opp.Id != NULL) {
                    Opp_Ids.add(opp.Id);
                }

                if (sobjectName == 'MortgageCalc__Financial_Calculator__c') {
                    if (Opp_Ids.size() > 0) {


                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.MortgageCalc__Financial_Calculator__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select ';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }
                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        Fieldz_To_Query += ' ' + 'From MortgageCalc__Financial_Calculator__c Where MortgageCalc__Opportunity__c In : Opp_Ids AND Id =: id_app Order By LastModifiedDate DESC LIMIT 1';
                        Fin_Cals_List = Database.Query(Fieldz_To_Query);

                    }

                    System.debug('if Check');
                    if (Fin_Cals_List.size() > 0) {
                        Fin_Cals_Ids.add(Fin_Cals_List[0].Id);

                        //Check whether Month Amort Records exist or not
                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.MortgageCalc__Month_Amort__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select MortgageCalc__Loan_Calculator__r.MortgageCalc__Annual_Interest_Rate__c,';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }

                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                        Fieldz_To_Query += ' ' + 'From MortgageCalc__Month_Amort__c Where MortgageCalc__Loan_Calculator__c In : Fin_Cals_Ids';

                        //get all Month Amorts related to this Financial Calculator
                        Month_Amort_List = Database.query(Fieldz_To_Query);

                        System.debug(Month_Amort_List);
                        //Check whether Month Amorts exist or not
                        if (Month_Amort_List.size() == 0) {
                            System.debug('MonthAmort Empty');
                            Message_To_Return = 'Sorry! There is no Month Amorts for this Application.';
                            return Message_To_Return;
                        }

                        if (Month_Amort_List.size() > 0) {

                            System.debug('Not Empty');
                            //Loan record fields mapping
                            loan_To_Insert.Application_Related_To__c = opp.Id;
                            loan_To_Insert.Financial_Calculator_Scenario__c = Fin_Cals_List[0].Id;
                            if (opp.AccountId != NULL) {
                                loan_To_Insert.Account_Name__c = opp.AccountId;
                            }
                            if (String.isNotBlank(opp.lms2__Lender__c) && String.isNotEmpty(opp.lms2__Lender__c)) {
                                loan_To_Insert.Lender_Funder__c = opp.lms2__Lender__c;
                            }
                            if (opp.lms2__Application_Number1__c != NULL) {
                                loan_To_Insert.Loan_Account_No__c = opp.lms2__Application_Number1__c;
                            }
                            if (Fin_Cals_List[0].MortgageCalc__Loan_Amount__c != NULL) {
                                loan_To_Insert.lms2__Loan_Amount_c__c = Fin_Cals_List[0].MortgageCalc__Loan_Amount__c;
                            }
                            if (Fin_Cals_List[0].MortgageCalc__Monthly_Loan_Repayment__c != NULL) {
                                loan_To_Insert.lms2__Current_Monthly_Loan_Repayment_c__c = Fin_Cals_List[0].MortgageCalc__Monthly_Loan_Repayment__c;
                            }
                            if (Fin_Cals_List[0].MortgageCalc__Loan_Period__c != NULL) {
                                loan_To_Insert.lms2__Term_of_Loan_N__c = Fin_Cals_List[0].MortgageCalc__Loan_Period__c;
                                //opp.lms2__Term_of_Loan__c = Fin_Cals_List[0].MortgageCalc__Loan_Period__c * 12;
                            }
                            if (Fin_Cals_List[0].MortgageCalc__Annual_Interest_Rate__c != NULL) {
                                loan_To_Insert.lms2__Interest_Rate__c = Fin_Cals_List[0].MortgageCalc__Annual_Interest_Rate__c;
                                //opp.lms2__Term_of_Loan__c = Fin_Cals_List[0].MortgageCalc__Loan_Period__c * 12;
                            }

                            System.debug(loan_To_Insert);
                        }
                    }

                    //Create a SAVEPOINT to rollback database if any error occurs
                    Savepoint RooBack_Here = Database.setSavepoint();

                    //Perform insertion of Records


                    System.debug(loan_To_Insert);
                    if (loan_To_Insert != NULL) {
                        Database.saveResult var_Result = Database.insert (loan_To_Insert, False);
                        if (var_Result.isSuccess()) {
                            opp.lms2__Term_of_Loan__c = (loan_To_Insert.lms2__Term_of_Loan_N__c) * 12;
                            update opp;
                            Loan_Id.add(var_Result.getId());
                            system.debug('>>>>>Loan id -->' + var_Result.getId());
                        } else {
                            Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                            create_task = False;
                            Database.rollback(RooBack_Here);
                            return Message_To_Return;
                        }
                    }

                    if (Loan_Id.size() > 0) {
                        if (Fin_Cals_List.size() > 0) {
                            LoanRO_List = Convert_To_Loan_Button_Controller_Helper.Map_FinCal_To_LoanRO(Fin_Cals_List[0], Loan_Id);
                            system.debug('>>>>>LoanRO_List -->' + LoanRO_List);
                            if (LoanRO_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRO_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        system.debug('>>>>>>New Loan Repayment Option Id -->' + var_result.getId());
                                        LoanRO_Id.add(var_result.getId());
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Option Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }

                        if (Month_Amort_List.size() > 0 && LoanRO_Id.size() > 0) {
                             Decimal ServicingAmount = 0;
                            if(quoteCalList.size() > 0 && quoteCalList[0].quoteCal__Servicing_Fee__c != null){
                                ServicingAmount = quoteCalList[0].quoteCal__Servicing_Fee__c;
                            }
                            LoanRS_List = Convert_To_Loan_Button_Controller_Helper.Map_MonthAmort_To_LoanRS(Month_Amort_List, ServicingAmount, Loan_Id, LoanRO_Id, opp.CloseDate);
                            system.debug('>>>>>LoanRS_List 3-->' + LoanRS_List);
                            if (LoanRS_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRS_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        Decimal totalInterest = 0.0;
                                        for (lms2__Loan_Repayent_Schedule__c LRS : LoanRS_List) {
                                            totalInterest += LRS.lms2__Interest__c;
                                        }
                                        loan_To_Insert.lms2__Total_Interest__c = totalInterest;
                                        system.debug('totalInterest>>>'+totalInterest);
                                        loan_To_Insert.lms2__Total_Loan_Repayment__c = loan_To_Insert.lms2__Loan_Amount_c__c + totalInterest;
                                        system.debug('loan_To_Insert.lms2__Total_Loan_Repayment__c'+loan_To_Insert.lms2__Total_Loan_Repayment__c);
                                        system.debug('opp.Amount'+opp.Amount);
                                        loan_To_Insert.lms2__Outstanding_Amount__c = opp.Amount + totalInterest;
                                        system.debug('loan_To_Insert.lms2__Outstanding_Amount__c>>>'+loan_To_Insert.lms2__Outstanding_Amount__c);
                                        update loan_To_Insert;
                                        system.debug('>>>>>>New Loan Repayment Schedule Id -->' + var_result.getId());
                                        LoanRS_Id.add(var_result.getId());
                                        Message_To_Return = 'The Application is converted to Loan Successfully.';
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Schedule Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }
                        /*if (Month_Amort_List.size() > 0 && LoanRO_Id.size() > 0) {//(new)
                            LoanR_List = Convert_To_Loan_Button_Controller_Helper.Map_MonthAmort_To_LoanR(Month_Amort_List, Loan_Id, LoanRO_Id, LoanRS_Id, opp.CloseDate);
                            system.debug('>>>>>LoanR_List ==-->' + LoanR_List[0]);
                            if (LoanR_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanR_List, False);
                               
                            }
                        }*/
                        
                    }


                    //Insert  Task to show that the Loan is Applied successfully.
                    List<Task> Task_List = new List<Task>();
                    if (create_task) {
                        Task tsk = new Task();
                        tsk.WhatId = opp.Id;
                        tsk.Subject = 'Loan Applied';
                        tsk.Status = 'Completed';
                        tsk.Priority = 'Normal';
                        Task_List.add(tsk);

                    }
                    if (Task_List.size() > 0) {
                        insert Task_List;
                        lms2__Loan__c loan = [Select Id,Name,lms2__Account_Name__c,lms2__Term_Start_Date__c,lms2__Term_of_Loan_N__c from lms2__Loan__c where Id = :Loan_Id[0]];
                        if (loan.lms2__Account_Name__c != null) {
                            System.debug('LA' + loan.lms2__Account_Name__c);
                            Account acc = [Select Id,Name from Account where Id = :loan.lms2__Account_Name__c];
                            System.debug('A' + acc);

                            Contract con = new Contract();
                            con.AccountId = acc.Id;
                            con.StartDate = loan.lms2__Term_Start_Date__c;
                            con.ContractTerm = (Integer.valueof(loan.lms2__Term_of_Loan_N__c)) * 12;
                            System.debug('con' + con);
                            insert con;

                            loan.lms2__Contract__c = con.id;
                            loan.lms2__Outstanding_Amount__c = opp.Amount;
                            system.debug('loan.lms2__Outstanding_Amount__c>>>'+loan.lms2__Outstanding_Amount__c);
                            update loan;
                        }
                    }

                    return Message_To_Return;


                } else if (sobjectName == 'servicecal__Non_Resident__c') {
                    if (Opp_Ids.size() > 0) {
                       

                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.servicecal__Non_Resident__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select ';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }
                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                        Fieldz_To_Query += ' ' + 'From servicecal__Non_Resident__c Where servicecal__Opportunity__c In : Opp_Ids AND Id =: id_app Order By LastModifiedDate DESC LIMIT 1';
                        Serv_Cals_List = Database.Query(Fieldz_To_Query);

                    }

                    System.debug('if Check');
                    if (Serv_Cals_List.size() > 0) {
                        Serv_Cals_Ids.add(Serv_Cals_List[0].Id);

                        //Check whether Amortization Result exist or not
                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.servicecal__Amortization_Result__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select ';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }
                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                        Fieldz_To_Query += ' ' + 'From servicecal__Amortization_Result__c Where servicecal__Serviceability_Calculator__c In : Serv_Cals_Ids';

                        //get all Amortization Result related to this Servicability Calculator
                        Amort_Result_list = Database.query(Fieldz_To_Query);

                        System.debug(Amort_Result_list);
                        //Check whether Amortization Result exist or not
                        /*if (Amort_Result_list.size() == 0) {
                            System.debug('Amortization Result Empty');
                            Message_To_Return = 'Sorry! There is no Amortization Result for this Application.';
                            return Message_To_Return;
                        }

                        if (Amort_Result_list.size() > 0) {
                         */
                        System.debug('Not Empty');
                        //Loan record fields mapping
                        loan_To_Insert.Application_Related_To__c = opp.Id;
                        loan_To_Insert.lms2__Serviceability_Calculator_Scenario__c = Serv_Cals_List[0].Id;
                        if (opp.AccountId != NULL) {
                            loan_To_Insert.Account_Name__c = opp.AccountId;
                        }
                        if (String.isNotBlank(opp.lms2__Lender__c) && String.isNotEmpty(opp.lms2__Lender__c)) {
                            loan_To_Insert.Lender_Funder__c = opp.lms2__Lender__c;
                        }
                        if (opp.lms2__Application_Number1__c != NULL) {
                            loan_To_Insert.Loan_Account_No__c = opp.lms2__Application_Number1__c;
                        }
                        if (Serv_Cals_List[0].servicecal__New_Loan_Amount__c != NULL) {
                            loan_To_Insert.lms2__Loan_Amount_c__c = Serv_Cals_List[0].servicecal__New_Loan_Amount__c;
                        }
                        if (Serv_Cals_List[0].servicecal__New_Monthly_Loan_Repayment_s__c != NULL) {
                            loan_To_Insert.lms2__Current_Monthly_Loan_Repayment_c__c = Serv_Cals_List[0].servicecal__New_Monthly_Loan_Repayment_s__c;
                        }
                        if (Serv_Cals_List[0].servicecal__New_Loan_Term_Years__c != NULL) {
                            loan_To_Insert.lms2__Term_of_Loan_N__c = decimal.valueOf(Serv_Cals_List[0].servicecal__New_Loan_Term_Years__c);
                            //opp.lms2__Term_of_Loan__c = Integer.valueof(Serv_Cals_List[0].servicecal__New_Loan_Term_Years__c * 12);
                        }
                        if (Serv_Cals_List[0].servicecal__Intrest_Rate_on_new_Loan__c != NULL) {
                            loan_To_Insert.lms2__Interest_Rate__c = Serv_Cals_List[0].servicecal__Intrest_Rate_on_new_Loan__c;
                        }


                        System.debug(loan_To_Insert);
                    }


                    //Create a SAVEPOINT to rollback database if any error occurs
                    Savepoint RooBack_Here = Database.setSavepoint();

                    //Perform insertion of Records
                    System.debug(loan_To_Insert);
                    if (loan_To_Insert != NULL) {
                        Database.saveResult var_Result = Database.insert (loan_To_Insert, False);
                        if (var_Result.isSuccess()) {
                            opp.lms2__Term_of_Loan__c = (loan_To_Insert.lms2__Term_of_Loan_N__c) * 12;
                            update opp;
                            Loan_Id.add(var_Result.getId());
                            system.debug('>>>>>Loan id -->' + var_Result.getId());
                        } else {
                            Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                            create_task = False;
                            Database.rollback(RooBack_Here);
                            return Message_To_Return;
                        }
                    }

                    if (Loan_Id.size() > 0) {
                        if (Serv_Cals_List.size() > 0) {
                            LoanRO_List = Convert_To_Loan_Button_Controller_Helper.Map_ServCal_To_LoanRO(Serv_Cals_List[0], Loan_Id);
                            system.debug('>>>>>LoanRO_List -->' + LoanRO_List);
                            if (LoanRO_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRO_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        system.debug('>>>>>>New Loan Repayment Option Id -->' + var_result.getId());
                                        LoanRO_Id.add(var_result.getId());
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Option Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }

                        if (Amort_Result_list.size() > 0 && LoanRO_Id.size() > 0) {
                            Decimal ServicingAmount = 0;
                            if(quoteCalList.size() > 0 && quoteCalList[0].quoteCal__Servicing_Fee__c != null){
                                ServicingAmount = quoteCalList[0].quoteCal__Servicing_Fee__c;
                            }
                            LoanRS_List = Convert_To_Loan_Button_Controller_Helper.Map_AmortResult_To_LoanRS(Amort_Result_list, ServicingAmount, Loan_Id, LoanRO_Id, opp.CloseDate);
                            system.debug('>>>>>LoanRS_List 1-->' + LoanRS_List[0]);
                            if (LoanRS_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRS_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        Decimal totalInterest = 0.0;
                                        for (lms2__Loan_Repayent_Schedule__c LRS : LoanRS_List) {
                                            totalInterest += LRS.lms2__Interest__c;
                                        }
                                        loan_To_Insert.lms2__Total_Interest__c = totalInterest;
                                        loan_To_Insert.lms2__Total_Loan_Repayment__c = loan_To_Insert.lms2__Loan_Amount_c__c + totalInterest;
                                        loan_To_Insert.lms2__Outstanding_Amount__c = opp.Amount + totalInterest;
                                        system.debug('loan_To_Insert.lms2__Outstanding_Amount__c>>>'+loan_To_Insert.lms2__Outstanding_Amount__c);
                                        update loan_To_Insert;
                                        system.debug('>>>>>>New Loan Repayment Schedule Id -->' + var_result.getId());
                                        LoanRS_Id.add(var_result.getId());
                                        Message_To_Return = 'The Application is converted to Loan Successfully.';
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Schedule Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }
                        //(new)
                        List<Fee_Expense__c> FEList = new List<Fee_Expense__c>();
                        if (Amort_Result_list.size() > 0 && LoanRO_Id.size() > 0) {//(new)
                            FEList = Convert_To_Loan_Button_Controller_Helper.Map_AmortResult_To_LoanR(Amort_Result_list, Loan_Id, LoanRO_Id, LoanRS_Id, opp.CloseDate);
                            
                            if (FEList.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(FEList, False);
                                
                            }
                        }
                        
                    }


                    //Insert  Task to show that the Loan is Applied successfully.
                    List<Task> Task_List = new List<Task>();
                    if (create_task) {
                        Task tsk = new Task();
                        tsk.WhatId = opp.Id;
                        tsk.Subject = 'Loan Applied';
                        tsk.Status = 'Completed';
                        tsk.Priority = 'Normal';
                        Task_List.add(tsk);

                    }
                    if (Task_List.size() > 0) {
                        insert Task_List;
                        lms2__Loan__c loan = [Select Id,Name,lms2__Account_Name__c,lms2__Term_Start_Date__c,lms2__Term_of_Loan_N__c from lms2__Loan__c where Id = :Loan_Id[0]];
                        if (loan.lms2__Account_Name__c != null) {
                            System.debug('LA' + loan.lms2__Account_Name__c);
                            Account acc = [Select Id,Name from Account where Id = :loan.lms2__Account_Name__c];
                            System.debug('A' + acc);

                            Contract con = new Contract();
                            con.AccountId = acc.Id;
                            con.StartDate = loan.lms2__Term_Start_Date__c;
                            con.ContractTerm = (Integer.valueof(loan.lms2__Term_of_Loan_N__c)) * 12;
                            System.debug('con' + con);
                            insert con;

                            loan.lms2__Contract__c = con.id;
                           // loan.lms2__Outstanding_Amount__c = opp.Amount;
                            system.debug('loan.lms2__Outstanding_Amount__c>>>'+loan.lms2__Outstanding_Amount__c);
                            update loan;
                        }
                    }

                    return Message_To_Return;

                } else if (sobjectName == 'quoteCal__Quote_Calculator__c') {
                    if (Opp_Ids.size() > 0) {
                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.quoteCal__Quote_Calculator__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select ';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }
                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                        Fieldz_To_Query += ' ' + 'From quoteCal__Quote_Calculator__c Where quoteCal__Opportunity__c In : Opp_Ids AND Id =: id_app Order By LastModifiedDate DESC LIMIT 1';
                        quoteCalList = Database.Query(Fieldz_To_Query);

                    }

                    System.debug('if Check');
                    if (quoteCalList.size() > 0) {
                        quote_Cals_Ids.add(quoteCalList[0].Id);

                        //Check whether Amortization Result exist or not
                        Map<String, Schema.SObjectField> mapOfFields = Schema.SObjectType.quoteCal__Amortization_Schedule__c.fields.getMap();
                        Set<String> All_Fields = mapOfFields.keySet();
                        String Fieldz_To_Query = 'Select ';
                        for (String Fld : All_Fields) {
                            Fieldz_To_Query += mapOfFields.get(Fld) + ',';
                        }
                        Fieldz_To_Query = Fieldz_To_Query.removeEnd(',');
                        //system.debug('>>>>>Fieldz_To_Query -->'+Fieldz_To_Query);
                        Fieldz_To_Query += ' ' + 'From quoteCal__Amortization_Schedule__c Where quoteCal__Calculator_Result__c In : quote_Cals_Ids';

                        //get all Amortization Result related to this Servicability Calculator
                        quoteAmortList = Database.query(Fieldz_To_Query);

                        System.debug(quoteAmortList);
                        //Check whether Amortization Result exist or not
                        /*if (Amort_Result_list.size() == 0) {
                            System.debug('Amortization Result Empty');
                            Message_To_Return = 'Sorry! There is no Amortization Result for this Application.';
                            return Message_To_Return;
                        }

                        if (Amort_Result_list.size() > 0) {
                         */
                        System.debug('Not Empty');
                        //Loan record fields mapping
                        loan_To_Insert.Application_Related_To__c = opp.Id;
                        loan_To_Insert.lms2__Quote_Calculator__c = quoteCalList[0].Id;
                        if (opp.AccountId != NULL) {
                            loan_To_Insert.Account_Name__c = opp.AccountId;
                        }
                        if (opp.lms2__Application_Number1__c != NULL) {
                            loan_To_Insert.Loan_Account_No__c = opp.lms2__Application_Number1__c;
                        }
                        if (quoteCalList[0].quoteCal__Amount_Financed__c != NULL) {
                            loan_To_Insert.lms2__Loan_Amount_c__c = quoteCalList[0].quoteCal__Amount_Financed__c;
                        }
                        if (String.isNotBlank(opp.lms2__Lender__c) && String.isNotEmpty(opp.lms2__Lender__c)) {
                            loan_To_Insert.Lender_Funder__c = opp.lms2__Lender__c;
                        }
                        if (quoteCalList[0].quoteCal__Repayment_Non_Published__c != NULL) {
                            loan_To_Insert.lms2__Current_Monthly_Loan_Repayment_c__c = quoteCalList[0].quoteCal__Repayment_Non_Published__c;
                        }
                        if (quoteCalList[0].quoteCal__Term_months__c != NULL) {
                            loan_To_Insert.lms2__Term_of_Loan_N__c = quoteCalList[0].quoteCal__Term_months__c;
                            //opp.lms2__Term_of_Loan__c = Integer.valueof(Serv_Cals_List[0].servicecal__New_Loan_Term_Years__c * 12);
                        }
                        if (quoteCalList[0].quoteCal__Desired_Base_Rate__c != NULL) {
                            loan_To_Insert.lms2__Interest_Rate__c = quoteCalList[0].quoteCal__Desired_Base_Rate__c;
                        }
                        if (quoteCalList[0].quoteCal__Customer_Rate_Non_Published__c != NULL) {
                            loan_To_Insert.lms2__Customer_Interest_Rate__c = quoteCalList[0].quoteCal__Customer_Rate_Non_Published__c;
                        }
                        if (quoteCalList[0].quoteCal__Goods_Type__c != NULL) {
                            loan_To_Insert.lms2__Asset_Type__c = quoteCalList[0].quoteCal__Goods_Type__c;
                        }
                        if (quoteCalList[0].quoteCal__Loan_Facility_Type__c != NULL) {
                            loan_To_Insert.lms2__Finance_Type__c = quoteCalList[0].quoteCal__Loan_Facility_Type__c;
                        }

                        System.debug(loan_To_Insert);
                    }


                    //Create a SAVEPOINT to rollback database if any error occurs
                    Savepoint RooBack_Here = Database.setSavepoint();

                    //Perform insertion of Records
                    System.debug(loan_To_Insert);
                    if (loan_To_Insert != NULL) {
                        Database.saveResult var_Result = Database.insert (loan_To_Insert, False);
                        if (var_Result.isSuccess()) {
                            opp.lms2__Term_of_Loan__c = (loan_To_Insert.lms2__Term_of_Loan_N__c);
                            update opp;
                            Loan_Id.add(var_Result.getId());
                            system.debug('>>>>>Loan id -->' + var_Result.getId());
                        } else {
                            Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                            create_task = False;
                            Database.rollback(RooBack_Here);
                            return Message_To_Return;
                        }
                    }

                    if (Loan_Id.size() > 0) {
                        if (quoteCalList.size() > 0) {
                            LoanRO_List = Convert_To_Loan_Button_Controller_Helper.Map_QuoteCal_To_LoanRO(quoteCalList[0], Loan_Id);
                            system.debug('>>>>>LoanRO_List -->' + LoanRO_List);
                            if (LoanRO_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRO_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        system.debug('>>>>>>New Loan Repayment Option Id -->' + var_result.getId());
                                        LoanRO_Id.add(var_result.getId());
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Option Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }

                        if (quoteAmortList.size() > 0 && LoanRO_Id.size() > 0) {
                            Decimal ServicingAmount = 0;
                            if(quoteCalList.size() > 0 && quoteCalList[0].quoteCal__Servicing_Fee__c != null){
                                ServicingAmount = quoteCalList[0].quoteCal__Servicing_Fee__c;
                            }
                            LoanRS_List = Convert_To_Loan_Button_Controller_Helper.Map_QuoteAmortResult_To_LoanRS(quoteAmortList, ServicingAmount, Loan_Id, LoanRO_Id, opp.CloseDate);
                            system.debug('>>>>>LoanRS_List 2-->' + LoanRS_List[0]);
                            if (LoanRS_List.size() > 0) {
                                Database.saveResult[] Insert_Results = Database.insert(LoanRS_List, False);
                                for (Database.saveResult var_result : Insert_Results) {
                                    if (var_result.isSuccess()) {
                                        Decimal totalInterest = 0.0;
                                        for (lms2__Loan_Repayent_Schedule__c LRS : LoanRS_List) {
                                            totalInterest += LRS.lms2__Interest__c;
                                        }
                                        loan_To_Insert.lms2__Total_Interest__c = totalInterest;
                                        loan_To_Insert.lms2__Total_Loan_Repayment__c = loan_To_Insert.lms2__Loan_Amount_c__c + totalInterest;
                                        loan_To_Insert.lms2__Outstanding_Amount__c = opp.Amount + totalInterest;
                                        system.debug('loan_To_Insert.lms2__Outstanding_Amount__c>>>'+loan_To_Insert.lms2__Outstanding_Amount__c);
                                        update loan_To_Insert;
                                        system.debug('>>>>>>New Loan Repayment Schedule Id -->' + var_result.getId());
                                        LoanRS_Id.add(var_result.getId());
                                        Message_To_Return = 'The Application is converted to Loan Successfully.';
                                    } else {
                                        system.debug('>>>>>>New Loan Repayment Schedule Insertion Error-->' + var_result.getErrors());
                                        Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + var_Result.getErrors();
                                        create_task = False;
                                        Database.rollback(RooBack_Here);
                                        return Message_To_Return;
                                    }
                                }
                            }
                        }
                        
                    List<Fee_Expense__c> FEList = new List<Fee_Expense__c>();
                    if (quoteAmortList.size() > 0 && LoanRO_Id.size() > 0) {//(new)
                         
                    List<Fee_Expense__c> FeeAndExpenseInstanceList = new List<Fee_Expense__c>();
                    for(Id LRS : LoanRS_Id){
                    List<quoteCal__Quote_Calculator__c> calculatorInstanceFunderForFee = new List<quoteCal__Quote_Calculator__c>();
                    List<Loan__c> LoanList = new List<Loan__c>();
                    LoanList = [select Id, lms2__Quote_Calculator__c from Loan__c where Id =:Loan_Id];
                    calculatorInstanceFunderForFee = [Select Id, quoteCal__Servicing_Fee__c from quoteCal__Quote_Calculator__c where Id =: LoanList[0].Quote_Calculator__c ];
                    
                    Fee_Expense__c FeeAndExpenseInstance = new Fee_Expense__c();
                    FeeAndExpenseInstance.lms2__Mode__c = 'Amount';
                    FeeAndExpenseInstance.lms2__Type_of_Fees__c = 'Loan Facilitation Fee';
                    FeeAndExpenseInstance.lms2__Fee_or_Expense__c = 'Fee';
                    FeeAndExpenseInstance.lms2__Charge_To__c = 'Customer';
                    FeeAndExpenseInstance.lms2__Fee_Frequency__c = 'Monthly';
                    FeeAndExpenseInstance.Loan_Repayment_Schedule__c = LRS;
                    //FeeAndExpenseInstance.Quote_Calculator__c = calculatorInstanceFunderForFee[0].Id;
                    FeeAndExpenseInstance.lms2__Loan_Repayment_Option__c = LoanRO_Id[0];

                    if(calculatorInstanceFunderForFee[0].quoteCal__Servicing_Fee__c != null){
                        FeeAndExpenseInstance.Value__c = calculatorInstanceFunderForFee[0].quoteCal__Servicing_Fee__c;
                    }else{
                        FeeAndExpenseInstance.Value__c = 0;
                    }
                    FeeAndExpenseInstanceList.add(FeeAndExpenseInstance);
                    }
                
                    insert FeeAndExpenseInstanceList;
                     }
                    }


                    //Insert  Task to show that the Loan is Applied successfully.
                    List<Task> Task_List = new List<Task>();
                    if (create_task) {
                        Task tsk = new Task();
                        tsk.WhatId = opp.Id;
                        tsk.Subject = 'Loan Applied';
                        tsk.Status = 'Completed';
                        tsk.Priority = 'Normal';
                        Task_List.add(tsk);

                    }
                    if (Task_List.size() > 0) {
                        insert Task_List;
                        lms2__Loan__c loan = [Select Id,Name,lms2__Account_Name__c,lms2__Term_Start_Date__c,lms2__Term_of_Loan_N__c from lms2__Loan__c where Id = :Loan_Id[0]];
                        if (loan.lms2__Account_Name__c != null) {
                            System.debug('LA' + loan.lms2__Account_Name__c);
                            Account acc = [Select Id,Name from Account where Id = :loan.lms2__Account_Name__c];
                            System.debug('A' + acc);

                            Contract con = new Contract();
                            con.AccountId = acc.Id;
                            con.StartDate = opp.CloseDate;
                            //con.EndDate = opp.CloseDate.addMonths(Integer.valueof(loan.lms2__Term_of_Loan_N__c));
                            con.ContractTerm = (Integer.valueof(loan.lms2__Term_of_Loan_N__c));
                            System.debug('con' + con);
                            insert con;

                            loan.lms2__Contract__c = con.id;
                            //loan.lms2__Outstanding_Amount__c = opp.Amount;
                            system.debug('loan.lms2__Outstanding_Amount__c>>>'+loan.lms2__Outstanding_Amount__c);
                            update loan;
                        }
                    }

                    return Message_To_Return;

                }
            }

            return Message_To_Return;
        }

        catch (Exception e) {
            system.debug('ERROR Message -->' + e.getMessage() + ' On Line Number -->' + e.getLineNumber());
            Message_To_Return = 'Opps ! An Error had occured, Error Message ->' + e.getMessage();
            return Message_To_Return;
        }
    }
    public class getCalculatorWrapper {

        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        //@AuraEnabled public Date CreatedDate;
        @AuraEnabled public Date TermStartDate;
        @AuraEnabled public Decimal LoanAmount;
        @AuraEnabled public Integer LoanPeriod;
        //@AuraEnabled public Decimal Interest;
        @AuraEnabled public Decimal FinalRate;
        @AuraEnabled public Decimal Repayment;

    }
    public class OpportunityWrapper {

        @AuraEnabled public Opportunity opp;
        @AuraEnabled public String status;

    }
}