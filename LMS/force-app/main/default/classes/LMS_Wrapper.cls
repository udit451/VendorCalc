/**
 * Created by krapy on 4/4/18.
 */

public with sharing class LMS_Wrapper {

    public class LoanDetail_Wrapper{

        @AuraEnabled public String id;
        @AuraEnabled public String Name;
        @AuraEnabled public String AccountName;
        @AuraEnabled public Decimal CurrentMonthlyLoanRepayment;
        @AuraEnabled public String FinancialCalculatorScenario;
        @AuraEnabled public String QuoteCalculatorScenario; 
        @AuraEnabled public String LoanAccountNo;
        @AuraEnabled public Decimal LoanAmount;
        @AuraEnabled public Date TermEndDate;
        @AuraEnabled public Decimal TermofLoan;
        @AuraEnabled public Date TermStartDate;
        @AuraEnabled public String ApplicationRelatedTo;
        @AuraEnabled public String ServiceabilityCalculatorScenario;

    }


    public class LoanRO_Wrapper{

        @AuraEnabled public String id;
        @AuraEnabled public String Name;
        @AuraEnabled public String Account;
        @AuraEnabled public Decimal AdditionalMonthlyLoanRepayment;
        @AuraEnabled public Decimal Annual_Interest_Rate;
        @AuraEnabled public Decimal Annual_Interest_Rate_Sensitivity;
        @AuraEnabled public Decimal Annual_Rental_Income_s_GAI;
        @AuraEnabled public Decimal Annual_Rental_Income_s_NMI;
        @AuraEnabled public Decimal Anual_Rental_Income_s_AGI;
        @AuraEnabled public Decimal Anual_Rental_Income_s_GFI;
        @AuraEnabled public Decimal Anual_Rental_Income_s_NFI;
        @AuraEnabled public Decimal Anual_Rental_Income_s_TNMI;
        @AuraEnabled public Decimal Applicant_1_Income_AGI;
        @AuraEnabled public Decimal Applicant_1_Income_GFI;
        @AuraEnabled public Decimal Applicant_1_Income_NFI;
        @AuraEnabled public Decimal Applicant_1_Income_TNMI;
        @AuraEnabled public Decimal Applicant_2_Income_AGI;
        @AuraEnabled public Decimal Applicant_2_Income_GFI;
        @AuraEnabled public Decimal Applicant_2_Income_NFI;
        @AuraEnabled public Decimal Applicant_2_Income_TNMI;
        @AuraEnabled public Decimal Applicant_3_Income_AGI;
        @AuraEnabled public Decimal Applicant_3_Income_GFI;
        @AuraEnabled public Decimal Applicant_3_Income_NFI;
        @AuraEnabled public Decimal Applicant_3_Income_TNM;
        @AuraEnabled public Decimal Applicant_4_Income_AGI;
        @AuraEnabled public Decimal Applicant_4_Income_GFI;
        @AuraEnabled public Decimal Applicant_4_Income_NFI;
        @AuraEnabled public Decimal Applicant_4_Income_TNMI;
        @AuraEnabled public Decimal AverageAnnual_Inflation_Rate;
        @AuraEnabled public Decimal Capitalized_cost;
        @AuraEnabled public Decimal Capital_Outstanding;
        @AuraEnabled public Decimal Capital_Repaid;
        @AuraEnabled public Decimal Children;
        @AuraEnabled public Decimal Child_Support_AMP;
        @AuraEnabled public Decimal Child_Support_FCMP;
        @AuraEnabled public Decimal Closing_Balance;
        @AuraEnabled public Decimal Company_1_Profit_AGI;
        @AuraEnabled public Decimal Company_1_Profit_NFI;
        @AuraEnabled public Decimal Company_1_Profit_c;
        @AuraEnabled public Decimal Company_1_Profit_TNMI;
        @AuraEnabled public Decimal Company_2_Profit_AGI;
        @AuraEnabled public Decimal Company_2_Profit;
        @AuraEnabled public Decimal Company_2_Profit_NFI;
        @AuraEnabled public Decimal Company_2_Profit_TNMI;
        @AuraEnabled public String Country_of_Residence;
        @AuraEnabled public Decimal Couples;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_ADL;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_AMP;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_D_L;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_FCDL;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_FCMP;
        @AuraEnabled public Decimal Credit_Card_Limit_not_debt_MP;
        @AuraEnabled public Decimal Debt_Service_Ratio_DSR;
        @AuraEnabled public String Debt_Service_Ratio_t_DSR;
        @AuraEnabled public Date Estimated_Repayment_Date;
        @AuraEnabled public Decimal Fixed_Monthly_Repayments;
        @AuraEnabled public Decimal Fixed_Rate;
        @AuraEnabled public Decimal Fixed_Term;
        @AuraEnabled public String Foreign_Currency;
        @AuraEnabled public Decimal Foreign_Currency_Exchange_Rate;
        @AuraEnabled public Decimal Housing_loan_Variable_ADL;
        @AuraEnabled public Decimal Housing_loan_Variable_AMP;
        @AuraEnabled public Decimal Housing_Loan_Variable_D_L;
        @AuraEnabled public Decimal Housing_Loan_Variable_FCDL;
        @AuraEnabled public Decimal Housing_Loan_Variable_FCMP;
        @AuraEnabled public Decimal Housing_Loan_Variable_MP;
        @AuraEnabled public Decimal Interest_Charged;
        @AuraEnabled public Decimal Interest_Coverage_Ratio_ICR;
        @AuraEnabled public String Interest_Coverage_Ratio_ICR_t;
        @AuraEnabled public String Interest_Only_Term_Years;
        @AuraEnabled public Decimal Intrest_Rate_on_new_Loan;
        @AuraEnabled public Decimal Lease_Hp_ADL;
        @AuraEnabled public Decimal Lease_Hp_AMP;
        @AuraEnabled public Decimal Lease_HP_D_L;
        @AuraEnabled public Decimal Lease_Hp_FCDL;
        @AuraEnabled public Decimal Lease_Hp_FCMP;
        @AuraEnabled public Decimal Lease_HP_MP;
        @AuraEnabled public Decimal Lease_price;
        @AuraEnabled public Decimal Living_Expenses_Used;
        @AuraEnabled public String Loan;
        @AuraEnabled public Decimal Loan_Amount;
        @AuraEnabled public Decimal Loan_Assesment_Rate_minimum_7;
        @AuraEnabled public Decimal Loan_Period;
        @AuraEnabled public Decimal Loan_Repayment;
        @AuraEnabled public String Loan_Type;
        @AuraEnabled public Decimal minus_Existing_Commitment_Sensitivity_2;
        @AuraEnabled public Decimal minus_New_loan_Commitment_Sensitivity_2;
        @AuraEnabled public Decimal Monthly_depreciation_fee;
        @AuraEnabled public Decimal Monthly_Difference;
        @AuraEnabled public Decimal Monthly_Living_Expenses_AUD;
        @AuraEnabled public Decimal Monthly_Living_Expenses_FC;
        @AuraEnabled public Decimal Monthly_Loan_Repayment;
        @AuraEnabled public Decimal Monthly_payment;
        @AuraEnabled public Decimal Monthly_Sales_Tax_Payment;
        @AuraEnabled public Decimal Montlhy_sales_tax_payment;
        @AuraEnabled public Decimal Net_Disposable_Income;
        @AuraEnabled public Decimal Net_Surplus_Income_NSI;
        @AuraEnabled public Decimal Net_Surplus_Income_NSI_t;
        @AuraEnabled public Decimal New_Loan_Amount;
        @AuraEnabled public String New_Loan_Term_Years;
        @AuraEnabled public Decimal New_Monthly_Loan_Repayment_s;
        @AuraEnabled public String Opportunity;
        @AuraEnabled public Decimal Other_ADL;
        @AuraEnabled public Decimal Other_AMP;
        @AuraEnabled public Decimal Other_D_L;
        @AuraEnabled public Decimal Other_FCDL;
        @AuraEnabled public Decimal Other_FCMP;
        @AuraEnabled public String Overall_Result;
        @AuraEnabled public Decimal Overdraft_ADL;
        @AuraEnabled public Decimal Overdraft_AMP;
        @AuraEnabled public Decimal Overdraft_D_L;
        @AuraEnabled public Decimal Overdraft_FCDL;
        @AuraEnabled public Decimal Overdraft_FCMP;
        @AuraEnabled public Decimal Overdraft_MP;
        @AuraEnabled public Decimal Personal_loan_Fixed_ADL;
        @AuraEnabled public Decimal Personal_loan_Fixed_AMP;
        @AuraEnabled public Decimal Personal_Loan_Fixed_D_L;
        @AuraEnabled public Decimal Personal_loan_Fixed_FCDL;
        @AuraEnabled public Decimal Personal_loan_Fixed_FCMP;
        @AuraEnabled public Decimal Personal_Loan_Fixed_MP;
        @AuraEnabled public Decimal Personal_loan_Variable_ADL;
        @AuraEnabled public Decimal Personal_loan_Variable_AMP;
        @AuraEnabled public Decimal Personal_Loan_Variable_D_L;
        @AuraEnabled public Decimal Personal_loan_Variable_FCDL;
        @AuraEnabled public Decimal Personal_loan_Variable_FCMP;
        @AuraEnabled public Decimal Personal_Loan_Variable_MP;
        @AuraEnabled public Decimal Rent_Board_AMP;
        @AuraEnabled public Decimal Rent_Board_FCMP;
        @AuraEnabled public Decimal Rent_Board_MP;
        @AuraEnabled public String Repayment_Type;
        @AuraEnabled public Decimal Residual_value;
        @AuraEnabled public String Repayment_Frequency;
        @AuraEnabled public Decimal Single_Adult;
        @AuraEnabled public String Test_1_Must_Be_Possitive_1;
        @AuraEnabled public Decimal Test_1_Must_Be_Possitive_2;
        @AuraEnabled public String Test_2_Must_NOT_exceed_35_1;
        @AuraEnabled public Decimal Test_2_Must_NOT_exceed_35_2;
        @AuraEnabled public Decimal Total_AGI;
        @AuraEnabled public Decimal Total_AMP;
        @AuraEnabled public Decimal Total_Commitments_AUD;
        @AuraEnabled public Decimal Total_Commitments_Foreign_Currency;
        @AuraEnabled public Decimal Total_Expenses;
        @AuraEnabled public Decimal Total_FCMP;
        @AuraEnabled public Decimal Total_GFI;
        @AuraEnabled public Decimal Total_Gross_Income;
        @AuraEnabled public Decimal Total_income_available_for_debt;
        @AuraEnabled public Decimal Total_Income_GAI;
        @AuraEnabled public Decimal Total_Income;
        @AuraEnabled public Decimal Total_Interest_over_Loan_Period;
        @AuraEnabled public Decimal Total_Living_Expenses;
        @AuraEnabled public Decimal Total_Loan_Repayment_over_Loan_P;
        @AuraEnabled public Decimal Total_Net_Commitments;
        @AuraEnabled public Decimal Total_Net_Income;
        @AuraEnabled public Decimal Total_NFI;


    }

    public class LoanRS_Wrapper{


        @AuraEnabled public String id;
        @AuraEnabled public String Name;
        @AuraEnabled public Decimal Capitalizedcost;
        @AuraEnabled public Decimal CapitalOutstanding;
        @AuraEnabled public Decimal CapitalRepaid;
        @AuraEnabled public Decimal ClosingBalance;
        @AuraEnabled public String Loan_Calculator;
        @AuraEnabled public Date EstimatedRepaymentDate;
        @AuraEnabled public Decimal FixedMonthlyRepayments;
        @AuraEnabled public Decimal Interest;
        @AuraEnabled public Decimal Leaseprice;
        @AuraEnabled public Decimal LoanRepayment;
        @AuraEnabled public String LoanRepaymentOption;
        @AuraEnabled public Decimal Monthlydepreciationfee;
        @AuraEnabled public Decimal Monthlyleasefee;
        @AuraEnabled public Decimal Monthlypayment;
        @AuraEnabled public Decimal Montlhysalestaxpayment;
        @AuraEnabled public Decimal Payment;
        @AuraEnabled public date PaymentDate;
        @AuraEnabled public Decimal PaymentNumber;
        @AuraEnabled public String PaymentStatus;
        @AuraEnabled public Decimal Pretaxmontlhypayment;
        @AuraEnabled public Decimal Principal;
        @AuraEnabled public Decimal Remaining;
        @AuraEnabled public Decimal RepaymentNumber;
        @AuraEnabled public Decimal Residualvalue;
        @AuraEnabled public Decimal OpeningBalance;
        @AuraEnabled public Decimal ServicingAmount;

    }
    public class LoanR_Wrapper{


        @AuraEnabled public String id;
        @AuraEnabled public String Name;
        @AuraEnabled public Decimal Capitalizedcost;
        @AuraEnabled public Decimal CapitalOutstanding;
        @AuraEnabled public Decimal CapitalRepaid;
        @AuraEnabled public Decimal ClosingBalance;
        @AuraEnabled public String Loan_Calculator;
        @AuraEnabled public Date EstimatedRepaymentDate;
        @AuraEnabled public Decimal FixedMonthlyRepayments;
        @AuraEnabled public Decimal Interest;
        @AuraEnabled public Decimal Leaseprice;
        @AuraEnabled public Decimal LoanRepayment;
        @AuraEnabled public String LoanRepaymentOption;
        @AuraEnabled public Decimal Monthlydepreciationfee;
        @AuraEnabled public Decimal Monthlyleasefee;
        @AuraEnabled public Decimal Monthlypayment;
        @AuraEnabled public Decimal Montlhysalestaxpayment;
        @AuraEnabled public Decimal Payment;
        @AuraEnabled public date PaymentDate;
        @AuraEnabled public Decimal PaymentNumber;
        @AuraEnabled public String PaymentStatus;
        @AuraEnabled public Decimal Pretaxmontlhypayment;
        @AuraEnabled public Decimal Principal;
        @AuraEnabled public Decimal Remaining;
        @AuraEnabled public Decimal RepaymentNumber;
        @AuraEnabled public Decimal Residualvalue;
        @AuraEnabled public Decimal OpeningBalance;

    }

    public class Contract_Wrapper{


        @AuraEnabled public String id;
        @AuraEnabled public String ContractNumber;
        @AuraEnabled public String Account;
        @AuraEnabled public Date StartDate;
        @AuraEnabled public Date EndDate;
        @AuraEnabled public Integer Term;

    }

    public class LMSFinalWrapper {


        @AuraEnabled public LoanDetail_Wrapper Loan_Details;
        @AuraEnabled public LoanRO_Wrapper LoanRO;
        @AuraEnabled public List<LoanRS_Wrapper> LoanRS_List;
        @AuraEnabled public List<LoanR_Wrapper> LoanR_List;
        @AuraEnabled public Contract_Wrapper ContractObj;

    }


}