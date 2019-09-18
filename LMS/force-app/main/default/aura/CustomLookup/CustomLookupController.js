/**
 * Created by Rajat on 3/10/2018.
 */
({
    getRecordNameList : function(c, e, h){
        let LValue = c.get('v.lookupValue');
        let LObj = c.get('v.lookupObjectAPI');
        if(LValue !== undefined && LValue !== null && LObj !== undefined && LObj !== null){
            if(LValue.length > 0 && LObj.length > 0){
                let action =  c.get("c.getLookupRecord_Apex");
                action.setParams({
                    "valueEnter" : LValue,
                    "objName" : LObj
                });
                action.setCallback(this, function (response) {
                    if(response.getState() == "SUCCESS"){
                        let data = (response.getReturnValue());
                        if(data.length !== 0){
                            c.set('v.lookupList', data);
                            //c.set('v.lookupId',data.Id);
                        }else {
                            c.set('v.lookupList', null);
                            c.set('v.NoResults', true);
                        }
                    }else{
                        console.log(response.getError());
                        console.log(response.getErrors());
                        console.log("something misshappens");
                    }
                });
                $A.enqueueAction(action);
            }else {
                c.set('v.lookupList', null);
                c.set('v.NoResults', false);
            }
        }else {
            c.set('v.lookupList', null);
            c.set('v.NoResults', false);
        }
    },

    selectedRecord : function(c, e, h){
        let IdKey = e.currentTarget.id;
        let label = e.currentTarget.title;
        let accessKey;
        c.get('v.lookupList').forEach(function (elem) {
            if (elem.Id === IdKey) {
                accessKey = elem.accountRecord;
            }
        });
        if(IdKey !== undefined && label !== undefined){
            c.set('v.NoResults',false);
            c.set('v.lookupId',IdKey);
            c.set('v.lookupLabel',label);
            c.set('v.lookupValue',label);
            c.set('v.lookupList', null);
            c.set('v.selectedLookup', true);
            if (c.get('v.lookupObjectAPI') === 'Account') {
                c.set('v.accountRecord', accessKey);
            }
            if (c.get('v.lookupObjectAPI') === 'Opportunity') {
                c.set('v.opportunityObject', accessKey);
            }
        }
    },

    clearSelected : function(c, e, h){
        c.set('v.lookupId',null);
        c.set('v.lookupLabel',null);
        c.set('v.lookupValue',null);
        c.set('v.lookupList', null);
        c.set('v.selectedLookup', false);
        let obj = {};
        obj.Name = '';
        obj.lms2__Email__c = '';
        obj.lms2__Mobile__c = '';
        obj.BillingStreet = '';
        obj.BillingCity = '';
        obj.BillingCountry = '';
        obj.BillingPostalCode = '';
        obj.BillingState = '';
        c.set('v.accountRecord', obj);
    },

    createRecord : function (c, e, h) {
        if (c.get('v.createAccountOption')) {
            let obj = {};
            obj.Name = c.get('v.lookupValue');
            obj.lms2__Email__c = '';
            obj.lms2__Mobile__c = '';
            obj.BillingStreet = '';
            obj.BillingCity = '';
            obj.BillingCountry = '';
            obj.BillingPostalCode = '';
            obj.BillingState = '';
            c.set('v.accountRecord', obj);
            c.set('v.createNewAccount', true);
        }
        if (c.get('v.createApplicantOption')) {
            let length = 25;
            let randomStringJS = (length) => {
                var result = '';
                var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                var charactersLength = characters.length;
                for (var i = 0; i < length; i++) {
                    result += characters.charAt(Math.floor(Math.random() * charactersLength));
                }
                return result;
            };
            let obj = {};
            obj.Name = c.get('v.lookupValue');
            obj.CloseDate = null;
            obj.Amount = null;
            obj.lms2__Application_Number1__c = randomStringJS(10);
            obj.lms2__Lender__c = null;
            c.set('v.opportunityObject', obj);
            c.set('v.createNewApplicant', true);
        }
    },

    changeLookupId : function (c, e, h) {
        try {
            c.set('v.NoResults',false);
            c.set('v.lookupList', null);
            c.set('v.selectedLookup', true);
        } catch (ex) {
            console.log(ex.message);
        }
    },
})