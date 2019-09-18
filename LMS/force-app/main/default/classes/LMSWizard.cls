/**
 * Created by Rajat on 5/9/2019.
 */

public with sharing class LMSWizard {
    @AuraEnabled
    public static String saveAccountData_Apex(String accountRecord) {
        Account acc = new Account();
        try {
            acc = (Account) JSON.deserialize(accountRecord, Account.class);
            if (acc != null) {
                upsert acc;
                return acc.Id;
            }
        } catch (Exception e) {
            System.debug(e);
            return e.getMessage();
        }
        return null;
    }

    @AuraEnabled
    public static LMS.OpportunityWrapper saveOpportunityData_Apex(String opportunityRecord) {
        return LMS.saveOpportunityData_Apex(opportunityRecord);
    }

    @AuraEnabled
    public static List<LMS.getCalculatorWrapper> getCalculatorsList_Apex(String oppId) {
        return LMS.getCalculatorsList(oppId);
    }

    @AuraEnabled
    public static String ConvertToLoan(String appId) {
        return LMS.ConvertToLoan(appId);
    }

    @AuraEnabled
    public static LMS_Wrapper.LMSFinalWrapper getLoanDetails_Apex(String appId) {
        return LMS.getLoanDetails_Apex(appId);
    }

    @AuraEnabled
    public static List<String> getAllLenderNames_Apex () {
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = lms2__Loan__c.lms2__Lender_Funder__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }
        return pickListValuesList;
    }

    @AuraEnabled
    public static string getAddressAutoComplete(String input) {
        //String types = '(regions)';
        String language = 'en';
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + EncodingUtil.urlEncode(input, 'UTF-8') +
                /*'&types=' + types*/ +'&language=' + language + '&key=' + LMSWizard.getGoogleMapsAPIKey() + '&libraries=places';
        return LMSWizard.getHttp(url);
    }

    private static String getGoogleMapsAPIKey() {
        /* return 'AIzaSyDb5QzlDjdgmjsZfXqSQI-KYcPWmMiifHg';*/
        return 'AIzaSyAmtOMoxUFLr5NY4zYlqnVNRF8OlFLOKEE'; //Added Date 11 march 2019
    }

    private static String getHttp(String url) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            return response.getBody();
        } catch (Exception e) {
            return 'ERROR: ' + e.getMessage();
        }
    }

    @AuraEnabled
    public static string getAddressDetails(String placeId) {
        String url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + placeId + '&language=en&key=' + LMSWizard.getGoogleMapsAPIKey();
        return LMSWizard.getHttp(url);
    }

    @AuraEnabled
    public static String getChildvalue(XMLDom.Element node , String identifier){
        String value = '';
        for(XMLDom.Element child : node.childNodes){
            if(child.nodeName == identifier){
                value = child.nodeValue;
            }
        }
        return value ;
    }
    @AuraEnabled
    public static String getDomain_Apex() {
        try {
            return String.valueOf(System.URL.getSalesforceBaseUrl());
        } catch (Exception ex) {
            system.debug('Error' + ex + 'at Line' + ex.getLineNumber());
        }
        return null;
    }
}