public with sharing class LMSPayRepaymentButtonController {
    @AuraEnabled
    public static lms2__Loan__c getLoanAccountNumber(String recordId){
        return [SELECT lms2__Loan_Account_No__c,lms2__Account_Name__r.Name,lms2__Current_Monthly_Loan_Repayment_c__c FROM lms2__Loan__c WHERE Id =: recordId];
    }
}