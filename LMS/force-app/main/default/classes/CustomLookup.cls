public with sharing class CustomLookup {
    @AuraEnabled
    public static List<CustomLookupWrapper> getLookupRecord_Apex(String valueEnter, String objName){
        List<CustomLookupWrapper> wrapperList = new List<CustomLookupWrapper>();
        try {

            Boolean checkObjectAvailability = CustomLookup.checkObjectAvailability(objName);
            if(checkObjectAvailability == true){
                String tempLabel = '';
                String query = 'Select Id, ';
                if(objName == 'Account'){
                    query += ' Name, lms2__Email__c, lms2__Mobile__c, Phone, BillingStreet, BillingState, BillingCity, BillingCountry, BillingPostalCode From ' + objName + ' where Name Like \'' + valueEnter + '%\' Limit 10000';
                    tempLabel = 'Name';
                }else if(objName == 'Opportunity'){
                    query += ' Name, CloseDate, Amount, lms2__Application_Number1__c, lms2__Lender__c From ' + objName + ' where Name Like \'' + valueEnter + '%\' AND StageName = \'Settled\' Limit 10000';
                    tempLabel = 'Name';
                }else if(objName != 'Case'){
                    query += ' Name From ' + objName + ' where Name Like \'' + valueEnter + '%\' Limit 10000';
                    tempLabel = 'Name';
                }else {
                    query += ' CaseNumber From ' + objName + ' where Name Like \'' + valueEnter + '%\' Limit 10000';
                    tempLabel = 'CaseNumber';
                }
                List<sObject> objList = new List<sObject>();
                objList = Database.query(query);
                if(objList.size() > 0){

                    for(sObject sObj : objList){
                        CustomLookupWrapper wrapper = new CustomLookupWrapper();
                        wrapper.Id = (String)sObj.get('Id');
                        wrapper.Name = (String)sObj.get(tempLabel);
                        if(objName == 'Account') {
                            wrapper.accountRecord = (Account) sObj;
                        }
                        if(objName == 'Opportunity') {
                            wrapper.accountRecord = (Opportunity) sObj;
                        }
                        wrapperList.add(wrapper);
                    }
                    if(wrapperList.size() > 0){
                        return wrapperList;
                    }
                }
            }
        } catch (Exception ex) {
            CustomLookupWrapper wrapper = new CustomLookupWrapper();
            wrapper.message = ex.getMessage() + ' at ' + ex.getLineNumber();
            System.debug(ex.getLineNumber());
            System.debug(ex.getMessage());
            wrapperList.add(wrapper);
        }

        return wrapperList;

    }

    public static Boolean checkObjectAvailability (String objName){
        if(objName != null){
            List<String> sObjectList = new List<String>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
            {
                Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
                if(describeSObjectResultObj.isQueryable())
                {
                    String name = objTyp.getDescribe().getName();
                    if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                            !name.containsignorecase('share') && !name.containsignorecase('feed') && !name.containsignorecase('feed'))
                    {
                        SobjectList.add(name);
                    }
                }
            }
            if(SobjectList.size()>0){
                for(String str : SobjectList){
                    if(str == objName){
                        return true;
                    }
                }
            }
        }else{
            return false;
        }

        return false;
    }

    public class CustomLookupWrapper{
        @AuraEnabled public String Id;
        @AuraEnabled public String Name;
        @AuraEnabled public String message;
        @AuraEnabled public sObject accountRecord;
    }
}