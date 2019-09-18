({
     showSuccessToast_Helper : function (c){
	    var element = c.find("SuccessToast");
	    $A.util.toggleClass(element, "slds-hide");
        window.setTimeout(
            $A.getCallback(function () {
               $A.util.toggleClass(element, "slds-hide");
            }), 2000
        );
    },
    
    showErrorToast_Helper : function (c){
        var element = c.find("ErrorToast");
	    $A.util.toggleClass(element, "slds-hide");
        window.setTimeout(
            $A.getCallback(function () {
                $A.util.toggleClass(element, "slds-hide");
            }), 2000
        );
    },

    handleSelectedOpp_Helper : function(c, e, h) {
        console.log('click');
        var s = e.getSource();
        console.log(s);
        var val = s.get('v.value');
        console.log(val);
        c.set('v.SelectedOpp', val);
        var x = c.get('v.SelectedOpp');
        console.log(x);
    },

    convertLoan_Helper : function (c, e, h) {
        var btn = e.getSource();
        console.log(btn);
        var app = c.get('v.SelectedOpp');
        console.log(app);
        if(app !== undefined && app !== null) {
            var action = c.get("c.ConvertToLoan");
            action.setParams({
                "appId": app
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {
                        if(storedResponse === 'The Application is converted to Loan Successfully.') {
                            c.set('v.SuccessMessage', storedResponse);
                            h.showSuccessToast_Helper(c);
                            h.getLoanDetails_Helper(c, e, h);
                        }
                        else{
                            c.set('v.ErrorMessage', storedResponse);
                            h.showErrorToast_Helper(c);
                        }
                    } else {
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }
                }
                else {
                    //console.log("something misshappens");
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                }
            });
            $A.enqueueAction(action);
        }
    },

    getLoanDetails_Helper : function (c, e, h){
        var oppId = c.get('v.recordId');
        if(oppId !== undefined && oppId !== null) {
            var action = c.get("c.getLoanDetails_Apex");
            action.setParams({
                "appId": oppId
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {
                        console.log(storedResponse);
                        var LD = storedResponse.Loan_Details;
                        var LRO = storedResponse.LoanRO;
                        var LDS = storedResponse.LoanRS_List;
                        var Con = storedResponse.ContractObj;
                        c.set('v.LoanDetails', LD);
                        c.set('v.LRO', LRO);
                        c.set('v.LRepaymentSchedule', LDS);
                        c.set('v.ContractDetails',Con);
                        c.set('v.ConvertedSuccessfuly',true);
                        console.log(Con);
                        if(LD.FinancialCalculatorScenario != null)
                        {
                            var cmp = c.find('MortLoanDetail');
                            console.log(cmp);
                            $A.util.removeClass(cmp,"slds-hide");
                        }
                        else if(LD.ServiceabilityCalculatorScenario != null){
                            var cmp = c.find('ServLoanDetail');
                            $A.util.removeClass(cmp,"slds-hide");
                        }
                    }
                    else {
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }
                }
                else{
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                }
            });
            $A.enqueueAction(action);
        }
    },

    ToggleSectionOne_Helper : function (c, e, h){
        c.set('v.isActive', '1');
    },

    ToggleSectionTwo_Helper : function (c, e, h){
        c.set('v.isActive', '2');
    },

    ToggleSectionThree_Helper : function (c, e, h){
        c.set('v.isActive', '3');
    },
    ToggleSectionFour_Helper : function (c, e, h){
         c.set('v.isActive', '4');
    },
    backtoRecord_Helper : function(c, e, h){
        try{
            window.history.back();
        }catch(ex) {
            console.log(ex);
        }
    },
})