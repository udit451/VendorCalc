@isTest
private with sharing class CustomLookup_Test {

    static testMethod void getLookupRecord_Apex1() {
    	Account acc = new Account();
        acc.name = 'Test Account';
        insert acc;
        
        Test.startTest();
        List<CustomLookup.CustomLookupWrapper> returnList = CustomLookup.getLookupRecord_Apex('Test', 'Account');
        System.assertEquals(returnList.size() , 1);
        Test.stopTest();
    }
    
    static testMethod void getLookupRecord_Apex2() {
    	Opportunity opp = new Opportunity();
        opp.Name = 'Test Account';
        opp.CloseDate = Date.today();
        opp.StageName = 'Closed Won';
        insert opp;
        
        Test.startTest();
        List<CustomLookup.CustomLookupWrapper> returnList = CustomLookup.getLookupRecord_Apex('Test', 'Opportunity');
        Test.stopTest();
    }
}