({
    showSpinner_Helper : function (c){
        $('#spinner_Div').show();
        window.setTimeout(
            $A.getCallback(function () {
                $('#spinner_Div').hide();
            }), 10000
        );
    },

    hideSpinner_Helper : function (c){
        $('#spinner_Div').hide();
    },

    showSuccessToast_Helper : function (c){
        try{
	    var element = c.find("SuccessToast");
	    $A.util.toggleClass(element, "slds-hide");
        window.setTimeout(
            $A.getCallback(function () {
               $A.util.toggleClass(element, "slds-hide");
            }), 2000
        );
        }
        catch(e){
            console.log('Error-->>'+e);
        }
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

    borrowerChange_Helper : function (c, e, h){
        var accObj = c.get('v.accountObject');
        if(accObj.Name !== undefined && accObj.Name.length > 0){
            var cmpTarget = c.find('accountName');
            $A.util.removeClass(cmpTarget, 'slds-has-error');
        }else {
            var cmpTarget = c.find('accountName');
            $A.util.addClass(cmpTarget, 'slds-has-error');
        }
    },

    resetClick_Helper : function (c, e, h){
        var indexName = e.getSource().get('v.name');
        if(indexName === 'Borrower_Page'){
            var obj = {};
            obj.Name = null;
            obj.lms2__Mobile__c = null;
            obj.Phone = null;
            obj.Email = null;
            obj.BillingStreet = null;
            obj.Id = null;
            c.set('v.accountObject', obj);
        }else {

        }
    },

    nextClick_Helper : function (c, e, h){
        var indexName = e.getSource().get('v.name');
        var account_id=c.get('v.SavedAccId');
        //console.log(account_id);
        if(indexName === 'Borrower_Page'){
            $('#Borrower_Page').hide();
            $('#Laon_Page').show();
            $("#secondLi").addClass("slds-is-current slds-is-active");
        }else if(indexName === 'Laon_Page'){
            $('#Borrower_Page').hide();
            $('#Laon_Page').hide();
            $('#calculator_Page').show();
            $("#secondLi").addClass("slds-is-current slds-is-active");
            $("#thirdLi").addClass("slds-is-current slds-is-active");
        }
    },

    saveClick_Helper : function (c, e, h){
        var indexName = e.getSource().get('v.name');
        if(indexName === 'Borrower_Page'){
            //h.validateAndSaveBorrower_Helper(c, e, h, false);
            h.validateAccountName_Email_Helper(c, e, h, false);
        }else if(indexName === 'Laon_Page'){
            h.validateAndSaveLoan_Helper(c, e, h, false);
        }
    },

    saveAndNextClick_Helper : function (c, e, h){
        var indexName = e.getSource().get('v.name');
        if(indexName === 'Borrower_Page'){
            //h.validateAndSaveBorrower_Helper(c, e, h, true);
            h.validateAccountName_Email_Helper(c, e, h, true);
        }else if(indexName === 'Laon_Page'){
            h.validateAndSaveLoan_Helper(c, e, h, true);
        }
    },

   validateAccountName_Email_Helper : function (c, e, h, sn){

        var accObjName = c.get('v.accountObject.Name');

        if(accObjName === undefined)
        {
            var cmpTarget = c.find('accountName');
            $A.util.addClass(cmpTarget, 'slds-has-error');
            c.set('v.ErrorMessage', 'Please enter the name.');
            h.showErrorToast_Helper(c);

        }

        else {

            var accObjEmail = c.get('v.accountObject.Email');

            if (accObjEmail !== undefined) {
                var atpos = accObjEmail.indexOf("@");
                var dotpos = accObjEmail.lastIndexOf(".");

                if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= accObjEmail.length) {

                    c.set('v.ErrorMessage', 'Please enter valid Email');
                    h.showErrorToast_Helper(c);

                    var cmpTarget = c.find('accountEmail');
                    $A.util.addClass(cmpTarget, 'slds-has-error');
                }
                else {
                    h.validateAndSaveBorrower_Helper(c, e, h, sn);
                }

            }
            else {
                h.validateAndSaveBorrower_Helper(c, e, h, sn);
            }
        }

    },

   validateAndSaveBorrower_Helper : function(c, e, h, sn){
        h.showSpinner_Helper(c);
        var accObj = c.get('v.accountObject');
        //console.log(accObj);
        if(accObj.Name !== undefined && accObj.Name.length > 0){
            var action =  c.get("c.saveAccountData_Apex");
            action.setParams({
                "accountRecord" : JSON.stringify(accObj)
            });
            action.setCallback(this, function (response) {
                if(response.getState() == "SUCCESS"){
                    var storedResponse = (response.getReturnValue());

                    //console.log(storedResponse);
                    if(storedResponse === 'success'){

                        if(sn === true){
                            $('#Borrower_Page').hide();
                            $('#Laon_Page').show();
                            $("#secondLi").addClass("slds-is-current slds-is-active");
                        } else {
                            c.set('v.SuccessMessage', 'Successfully Saved!');
                            h.showSuccessToast_Helper(c);
                        }
                    }else {
                        //console.log("something misshappens");
                        c.set('v.ErrorMessage', storedResponse);
                        h.showErrorToast_Helper(c);
                    }

                }else{
                    //console.log("something misshappens");
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                }
            });
            $A.enqueueAction(action);
        }
        h.hideSpinner_Helper(c);
    },

   validateAndSaveLoan_Helper : function(c, e, h, sn){
       try{
        //console.log('method called');
        h.showSpinner_Helper(c);
        var oppObj = c.get('v.opportunityObject');
        //console.log(oppObj);
        if(oppObj.Name !== undefined && oppObj.Name.length > 0){
            //console.log(oppObj);
            var action =  c.get("c.saveOpportunityData_Apex");
            //console.log(action);
            action.setParams({
                "opportunityRecord" : JSON.stringify(oppObj)
            });
            action.setCallback(this, function (response) {
                if(response.getState() == "SUCCESS"){
                    var storedResponse = (response.getReturnValue());
                    console.log({storedResponse});
                    if(storedResponse !== null && storedResponse.status === 'success' ){
                        c.set('v.opportunityObject', storedResponse.opp);
                        if(sn === true){
                            $('#Borrower_Page').hide();
                            $('#Laon_Page').hide();
                            $('#calculator_Page').show();
                            $("#secondLi").addClass("slds-is-current slds-is-active");
                            $("#thirdLi").addClass("slds-is-current slds-is-active");
                        } else {
                            c.set('v.SuccessMessage', 'Successfully Saved!');
                            h.showSuccessToast_Helper(c);
                        }
                    }else {
                        //console.log("something misshappens");
                        c.set('v.ErrorMessage', storedResponse.status);
                        h.showErrorToast_Helper(c);
                    }

                }else{
                    //console.log("something misshappens");
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                }
            });
            $A.enqueueAction(action);
        }else {
            var cmpTarget = c.find('accountName');
            $A.util.addClass(cmpTarget, 'slds-has-error');
            c.set('v.ErrorMessage', 'Please enter the name.');
            h.showErrorToast_Helper(c);
        }
        h.hideSpinner_Helper(c);
       }
       catch(e){
           console.log('Error-->>'+e);
       }
    },


   getRelatedOppToConvert_Helper : function(c, e, h){

        try{
            h.showSpinner_Helper(c);
            var opp = c.get("v.opportunityObject.Id");
            console.log(opp);
            if(opp !== undefined && opp !== null) {
                var action = c.get("c.getCalculatorsList");

                action.setParams({
                    "oppId": opp
                });

                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        console.log(JSON.stringify(storedResponse));
                        if (storedResponse !== null && storedResponse !== undefined) {
                            var element1 = c.find("NoAppDiv");
                            $A.util.addClass(element1, "slds-hide");
                            var element2 = c.find("AppDiv");
                            $A.util.removeClass(element2, "slds-hide");
                            c.set('v.LoansToConvert', storedResponse);
                            console.log(JSON.stringify(storedResponse));
                        } else {
                            var element1 = c.find("NoAppDiv");
                            $A.util.removeClass(element1, "slds-hide");
                            var element2 = c.find("AppDiv");
                            $A.util.addClass(element2, "slds-hide");
                        }
                    } else {
                        c.set('v.CheckRelatedData',false);
                        //console.log("something misshappens");
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }

                });
                $A.enqueueAction(action);
            }
            else
            {
                //console.log('Else');
                $('#NoAppDiv').show();
                $('#AppDiv').hide();
            }
            h.hideSpinner_Helper(c);
        }
        catch(e){
            console.log('Error-->>'+e);
        }
   },

   handleSelectedOpp_Helper : function(c, e, h)
   {
        console.log('click');
        var s = e.getSource();
        console.log(s);
        var val = s.get('v.value');
        console.log(val);
        c.set('v.SelectedOpp', val);
        var x = c.get('v.SelectedOpp');
        console.log(x);
   },


    convertLoan_Helper : function (c, e, h)
    {
        try{
            h.showSpinner_Helper(c);
            var btn = e.getSource();
            var app = c.get('v.SelectedOpp');
            //console.log(app);
            if(app !== undefined && app !== null) {
                var action = c.get("c.ConvertToLoan");
                action.setParams({
                    "appId": app
                });

                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var storedResponse = (response.getReturnValue());

                        if (storedResponse !== null && storedResponse !== undefined) {

                            var element2 = c.find("AppDiv");
                            $A.util.removeClass(element2, "slds-hide");

                            //c.set('v.LoansToConvert', storedResponse);
                            //console.log(storedResponse);

                            if(storedResponse === 'The Application is converted to Loan Successfully.') {
                                c.set('v.SuccessMessage', storedResponse);
                                h.showSuccessToast_Helper(c);
                                btn.set("v.disabled",true);
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
                    } else {

                        //console.log("something misshappens");
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }

                });
                $A.enqueueAction(action);
            }
            h.hideSpinner_Helper(c);
        }
        catch(e){
            console.log('Error--->'+e);
        }
    },

    selectCalculator_Helper : function (c, e, h)
    {
        try{
            c.set('v.showButtons',false);
            var selectedCal = c.get("v.selectCalculator");
            var opp = c.get('v.opportunityObject');
            //console.log(JSON.stringify(opp));
            if(opp.Id !== undefined && opp.Id !== null) {

                c.set('v.CheckOpp', true);
                //console.log('In else');
                if (selectedCal === '--Select Calculator--') {
                    c.set("v.CalculatorNameHeader", 'Calculator');

                } else if (selectedCal === 'Mortgage Calculator') {
                    window.setTimeout(
                        $A.getCallback(function () {
                            c.find('MortgageCalculator').reInitMortgage();
                            c.set("v.CalculatorNameHeader", selectedCal);
                            $('#spinnerLMS_Div').show();

                        }), 1000
                    );
                    window.setTimeout(
                        $A.getCallback(function () {
                            $('#spinnerLMS_Div').hide();
                            c.set('v.showButtons',true);
                        }), 3000
                    );


                } else if (selectedCal === 'Serviceability Calculator') {
                    //c.find("SCGeneric_Ext").reInitServiceability();
                    window.setTimeout(
                        $A.getCallback(function () {
                            c.set("v.CalculatorNameHeader", selectedCal);
                            $('#spinnerLMS_Div').show();

                        }), 1000
                    );
                    window.setTimeout(
                        $A.getCallback(function () {
                            $('#spinnerLMS_Div').hide();
                        }), 2000
                    );
                }
                else if (selectedCal === 'Loan Calculator') {
                    window.setTimeout(
                        $A.getCallback(function () {
                            c.set("v.CalculatorNameHeader", selectedCal);
                            $('#spinnerLMS_Div').show();

                        }), 1000
                    );
                    window.setTimeout(
                        $A.getCallback(function () {
                            $('#spinnerLMS_Div').hide();
                            c.set('v.showButtons',true);
                        }), 3000
                    );
                }

            }
            else {
                //console.log('Is Empty');
                c.set('v.ErrorMessage', 'No Opportunity Saved!! Please Save Opportunity first.');
                h.showErrorToast_Helper(c);

            }
        }
        catch(e){
            console.log('Error--->'+e);
        }
    },

    getLoanDetails_Helper : function (c, e, h){
    try{
        var app = c.get('v.opportunityObject.Id');
        //console.log('app--------->'+app);
        if(app !== undefined && app !== null) {
            var action = c.get("c.getLoanDetails_Apex");
            action.setParams({
                "appId": app
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
                        var loan_id = c.get('v.LoanDetails');
                        console.log(loan_id);
                        var loan_id1 = c.get('v.LRO');
                        console.log(loan_id1);
                        var loan_id2 = c.get('v.LRepaymentSchedule');
                        console.log(loan_id2);
                        console.log(Con);
                        //console.log(loan_id.FinancialCalculatorScenario);
                        //console.log(loan_id.ServiceabilityCalculatorScenario)
                        //h.calculateAllPaymentBalance(c,e,h,app);
                        if(loan_id.FinancialCalculatorScenario != null)
                        {
                            c.set('v.showMorgCalc',true);
                        }
                        else if(loan_id.ServiceabilityCalculatorScenario != null){

                            c.set('v.showServCalc',true);
                        }

                    } else {
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }
                } else {
                    //console.log("something 13misshappens");
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                }

            });
            $A.enqueueAction(action);
        }
    }
    catch(e){
        console.log('Error--->'+e);
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

    saveLoan_Helper : function (c, e, h){
        if(c.get('v.selectCalculator') === 'Loan Calculator'){
            c.find('LoanCalculator').saveRecord();
        }
        else if(c.get('v.selectCalculator') === 'Mortgage Calculator'){
            c.find('MortgageCalculator').saveRecord();
        }

    },

    saveNextLoan_Helper : function (c, e, h){
        if(c.get('v.selectCalculator') === 'Loan Calculator'){
            c.find('LoanCalculator').saveRecord();
        }
        else if(c.get('v.selectCalculator') === 'Mortgage Calculator'){
            c.find('MortgageCalculator').saveRecord();
        }
        window.setTimeout(
            $A.getCallback(function () {
                $('#Borrower_Page').hide();
                $('#Laon_Page').hide();
                $('#calculator_Page').hide();
                $('#Convert_To_Loan_Page').show();
                $("#secondLi").addClass("slds-is-current slds-is-active");
                $("#thirdLi").addClass("slds-is-current slds-is-active");
                $("#fourthLi").addClass("slds-is-current slds-is-active");
                h.getRelatedOppToConvert_Helper(c, e, h);
            }), 2000
        );
    },

    NextToConvertLoan_Helper : function (c, e, h){
        $('#Borrower_Page').hide();
        $('#Laon_Page').hide();
        $('#calculator_Page').hide();
        $('#Convert_To_Loan_Page').show();
        $("#secondLi").addClass("slds-is-current slds-is-active");
        $("#thirdLi").addClass("slds-is-current slds-is-active");
        $("#fourthLi").addClass("slds-is-current slds-is-active");
        h.getRelatedOppToConvert_Helper(c, e, h);
    },
    /*New Changes [16-10]*/
    /*calculateAllPaymentBalance:function(c,e,h,OpportunityId){
        try{
             var action = c.get("c.calculateAllPaymentBalance_Apex");
            action.setParams({
                "appId": OpportunityId
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {
                        console.log(storedResponse);
                        c.set('');
                    }
                } else {
                    console.log("something 13misshappens");
                }
            });
            $A.enqueueAction(action);
        }catch(ex){
            console.log('Error');
            console.log(ex);
        }
    }*/

})