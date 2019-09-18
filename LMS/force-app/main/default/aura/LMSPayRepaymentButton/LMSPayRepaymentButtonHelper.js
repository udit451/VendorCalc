({
    doInit_helper : function (c,e,h) {
        let recordIdJS = c.get("v.recordId");
        let action = c.get("c.getLoanAccountNumber");
        action.setParams({
            "recordId": c.get("v.recordId")
        });
        action.setCallback(this, function (r) {
            if (r.getState() === 'SUCCESS') {
                let storedResponse = r.getReturnValue();
                if (storedResponse !== null) {
                   let loanRecordJS = c.get("v.PaymentTransaction");
                    loanRecordJS.lms2__Payer_ID__c=storedResponse.lms2__Account_Name__r.Name;
                    loanRecordJS.lms2__Loan_Account_No__c=storedResponse.lms2__Loan_Account_No__c;
                    loanRecordJS.lms2__Amount_Requested__c= parseFloat(storedResponse.lms2__Current_Monthly_Loan_Repayment_c__c).toFixed(2);
                    c.set("v.PaymentTransaction",loanRecordJS);
                }
            } else {
                /*c.set("v.IsSpinnerRunning", false);
                //console.log("Error in save Application");
                reject("Error in save Application");*/
                console.log(r.getState());
            }
        });
        $A.enqueueAction(action);
    },

})