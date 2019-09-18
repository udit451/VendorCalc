/**
 * Created by Rajat on 5/9/2019.
 */
({
    doInit_helper: function (c, e, h) {
        // c.set("v.salesPath", 4);
        /*window.setTimeout(
            $A.getCallback(function () {
                c.set("v.salesPath", 2);
            }), 2000
        );
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.salesPath", 3);
            }), 4000
        );
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.salesPath", 4);
            }), 6000
        );
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.salesPath", 1);
            }), 8000
        );*/
        /*h.showSpinner_Helper(c);
        var opp = '0067F00000PIaZoQAL';//c.get("v.opportunityObject.Id");
        if (opp !== undefined && opp !== null) {
            var action = c.get("c.getCalculatorsList_Apex");
            action.setParams({
                "oppId": opp
            });
            action.setCallback(this, function (response) {
                if (response.getState() === "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {
                        var element1 = c.find("NoAppDiv");
                        $A.util.addClass(element1, "slds-hide");
                        var element2 = c.find("AppDiv");
                        $A.util.removeClass(element2, "slds-hide");
                        c.set('v.LoansToConvert', storedResponse);
                    } else {
                        var element1 = c.find("NoAppDiv");
                        $A.util.removeClass(element1, "slds-hide");
                        var element2 = c.find("AppDiv");
                        $A.util.addClass(element2, "slds-hide");
                    }
                    h.getLoanDetails_Helper(c, e, h);
                } else {
                    h.showToast_Helper(c, 'error', 'Unable to get records.');
                }
            });
            $A.enqueueAction(action);
        } else {
            var element1 = c.find("NoAppDiv");
            $A.util.addClass(element1, "slds-show");
            var element2 = c.find("AppDiv");
            $A.util.addClass(element2, "slds-hide");
        }
        h.hideSpinner_Helper(c);*/
    },

    borrowerChange_helper: function (c, e, h) {
        let accountName = c.get('v.accountObject.Name');
        if (!$A.util.isUndefinedOrNull(accountName) && !$A.util.isEmpty(accountName)) {

        } else {
            let obj = {};
            obj.lms2__Email__c = '';
            obj.lms2__Mobile__c = '';
            obj.Id = null;
            c.set('v.accountObject', obj);
            c.set('v.createNewAccount', false);
        }
    },

    applicantChange_helper: function (c, e, h) {
        let applicantName = c.get('v.opportunityObject.Name');
        if (!$A.util.isUndefinedOrNull(applicantName) && !$A.util.isEmpty(applicantName)) {

        } else {
            let obj = {};
            obj.Name = c.get('v.lookupValue');
            obj.CloseDate = null;
            obj.Id = null;
            obj.Amount = null;
            obj.lms2__Application_Number1__c = '';
            obj.lms2__Lender__c = null;
            c.set('v.opportunityObject', obj);
            h.generateRandomString_Helper(c, e, h, 25);
            c.set('v.createNewApplicant', false);
        }
    },

    resetClick_Helper: function (c, e, h) {
        let indexName = e.getSource().get('v.name');
        if (indexName === 'Borrower_Page') {
            let obj = {};
            obj.Name = null;
            obj.lms2__Mobile__c = null;
            obj.Phone = null;
            obj.lms2__Email__c = null;
            obj.BillingStreet = null;
            obj.Id = null;
            c.set('v.accountObject', obj);
        } else if (indexName === 'Laon_Page') {
            let obj = {};
            obj.Name = null;
            obj.CloseDate = null;
            obj.Id = null;
            obj.Amount = null;
            obj.lms2__Application_Number1__c = '';
            obj.lms2__Lender__c = null;
            c.set('v.opportunityObject', obj);
            h.generateRandomString_Helper(c, e, h, 25);
            c.set('v.createNewApplicant', false);
        } else if (indexName === 'calculator') {
            c.find('quote').resetQuote();
        }
    },

    saveClick_Helper: function (c, e, h) {
        let indexName = e.getSource().get('v.name');
        if (indexName === 'Borrower_Page') {
            h.validateAndSaveBorrower_Helper(c, e, h, false);
            h.generateRandomString_Helper(c, e, h, 25);
        } else if (indexName === 'Laon_Page') {
            h.validateAndSaveLoan_Helper(c, e, h, false);
        } else if (indexName === 'calculator') {
            c.find('quote').saveQuote();
        }
    },

    saveAndNextClick_Helper: function (c, e, h) {
        var indexName = e.getSource().get('v.name');
        if (indexName === 'Borrower_Page') {
            h.validateAndSaveBorrower_Helper(c, e, h, true);
            h.generateRandomString_Helper(c, e, h, 25);
            h.getAllLenderNames_Helper(c, e, h);
        } else if (indexName === 'Laon_Page') {
            h.validateAndSaveLoan_Helper(c, e, h, true);
        } else if (indexName === 'calculator') {
            c.find('quote').saveQuote();
            window.setTimeout(
                $A.getCallback(function () {
                    c.set('v.salesPath', 4);
                    h.getRelatedOppToConvert_Helper(c, e, h);
                }), 2500
            );
        }
    },

    validateAndSaveBorrower_Helper: function (c, e, h, sn) {
        var accObj = c.get('v.accountObject');
        if (!$A.util.isUndefinedOrNull(accObj.Name) && !$A.util.isEmpty(accObj.Name) && accObj.Name.length > 0) {
            h.showSpinner_Helper(c);
            var action = c.get("c.saveAccountData_Apex");
            action.setParams({
                "accountRecord": JSON.stringify(accObj)
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    //console.log(storedResponse);
                    if (!$A.util.isUndefinedOrNull(storedResponse) && (storedResponse.length === 18 || storedResponse.length === 15)) {
                        c.set('v.accountObject.Id', storedResponse);
                        //c.set('v.opportunityObject.AccountId', storedResponse);
                        if (sn === true) {
                            c.set('v.salesPath', 2);
                        } else {
                            h.showToast_Helper(c, 'success', 'Successfully Saved!');
                        }
                        h.hideSpinner_Helper(c);
                    } else {
                        h.showToast_Helper(c, 'error', storedResponse);
                    }

                } else {
                    h.showToast_Helper(c, 'error', 'Unable to save.');
                }
            });
            $A.enqueueAction(action);
        } else {
            h.showToast_Helper(c, 'error', 'Please enter the name.');
        }
    },

    generateRandomString_Helper: function (c, e, h, length) {
        let randomStringJS = (length) => {
            var result = '';
            var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
            var charactersLength = characters.length;
            for (var i = 0; i < length; i++) {
                result += characters.charAt(Math.floor(Math.random() * charactersLength));
            }
            return result;
        };
        let oppObjJS = c.get("v.opportunityObject");
        if (oppObjJS.lms2__Application_Number1__c === undefined || oppObjJS.lms2__Application_Number1__c === '') {
            c.set("v.opportunityObject.lms2__Application_Number1__c", randomStringJS(10));
        }
    },

    validateAndSaveLoan_Helper: function (c, e, h, sn) {
        try {
            
            var oppObj = c.get('v.opportunityObject');
                if(!$A.util.isUndefinedOrNull(oppObj.Name) && !$A.util.isUndefinedOrNull(oppObj.CloseDate) && !$A.util.isEmpty(oppObj.Name) && oppObj.Name.length > 0){
                h.showSpinner_Helper(c);
                oppObj.StageName = 'Settled';
                oppObj.AccountId = c.get('v.accountObject.Id');
                var action = c.get("c.saveOpportunityData_Apex");
                action.setParams({
                    "opportunityRecord": JSON.stringify(oppObj)
                });
                action.setCallback(this, function (response) {
                    if (response.getState() === "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        //console.log(oppObj);
                        if (storedResponse !== null && storedResponse.status === 'success') {
                            c.set('v.opportunityObject', storedResponse.opp);
                            if (sn === true) {
                                c.set('v.salesPath', 3);
                            } else {
                                h.showToast_Helper(c, 'success', 'Successfully Saved!');
                            }
                            h.hideSpinner_Helper(c);
                        } else {
                            h.showToast_Helper(c, 'error', storedResponse.status);
                        }

                    } else {
                        h.showToast_Helper(c, 'error', 'Unable to save.');
                    }
                });
                $A.enqueueAction(action);
            } else {
                h.showToast_Helper(c, 'error', 'Please fill mandatory fields.');
            }
            h.hideSpinner_Helper(c);
        } catch (ex) {
            console.log('Error-->>' + ex);
        }
    },

    showToast_Helper: function (c, variant, message) {
        try {
            
            c.set('v.showToast', true);
            c.set('v.variant', variant);
            c.set('v.message', message);
        } catch (ex) {
            console.log('Message :: ' + ex.message);
        }
    },

    showSpinner_Helper: function (c) {
        c.set("v.showSpinner", true);
        window.setTimeout(
            $A.getCallback(function () {
                c.set("v.showSpinner", false);
            }), 15000
        );
    },

    hideSpinner_Helper: function (c) {
        c.set("v.showSpinner", false);
    },

    nextClick_Helper: function (c, e, h) {
        var indexName = e.getSource().get('v.name');
        if (indexName === 'Borrower_Page') {
            c.set('v.salesPath', 2);
            c.set('v.opportunityObject.AccountId', c.get('v.accountObject.Id'));
            h.generateRandomString_Helper(c, e, h, 25);
            h.getAllLenderNames_Helper(c, e, h);
        } else if (indexName === 'Laon_Page') {
            c.set('v.salesPath', 3);
        } else if (indexName === 'calculator') {
            c.set('v.salesPath', 4);
            h.getRelatedOppToConvert_Helper(c, e, h);
        }
    },

    getRelatedOppToConvert_Helper: function (c, e, h) {

        try {
            h.showSpinner_Helper(c);
            var opp = c.get("v.opportunityObject.Id");
            if (opp !== undefined && opp !== null) {
                var action = c.get("c.getCalculatorsList_Apex");
                action.setParams({
                    "oppId": opp
                });
                action.setCallback(this, function (response) {
                    if (response.getState() === "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        
                        if (storedResponse !== null && storedResponse !== undefined) {
                            var element1 = c.find("NoAppDiv");
                            
                            $A.util.addClass(element1, "slds-hide");
                            var element2 = c.find("AppDiv");
                            
                            $A.util.removeClass(element2, "slds-hide");
                            c.set('v.LoansToConvert', storedResponse);
                        } else {
                            var element1 = c.find("NoAppDiv");
                            $A.util.removeClass(element1, "slds-hide");
                            var element2 = c.find("AppDiv");
                            $A.util.addClass(element2, "slds-hide");
                        }
                    } else {
                        h.showToast_Helper(c, 'error', 'Unable to get records.');
                    }
                });
                $A.enqueueAction(action);
            } else {
                var element1 = c.find("NoAppDiv");
                $A.util.addClass(element1, "slds-show");
                var element2 = c.find("AppDiv");
                $A.util.addClass(element2, "slds-hide");
            }
            h.hideSpinner_Helper(c);
        } catch (e) {
            console.log('Error-->>' + e);
        }
    },

    handleSelectedOpp_Helper: function (c, e, h) {
        var val = e.getSource().get('v.value')
        c.set('v.SelectedOpp', val);
    },

    convertLoan_Helper: function (c, e, h) {
        try {
            h.showSpinner_Helper(c);
            var btn = e.getSource();
            var app = c.get('v.SelectedOpp');
            if (app !== undefined && app !== null) {
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
                            if (storedResponse === 'The Application is converted to Loan Successfully.') {
                                h.showToast_Helper(c, 'success', storedResponse);
                                btn.set("v.disabled", true);
                                h.getLoanDetails_Helper(c, e, h);
                                
                            } else {
                                h.showToast_Helper(c, 'error', storedResponse);
                            }
                        } else {
                            h.showToast_Helper(c, 'error', 'Unable to convert loan.');
                        }
                    } else {
                        h.showToast_Helper(c, 'error', 'Unable to convert loan.');
                    }
                });
                $A.enqueueAction(action);
            }
            h.hideSpinner_Helper(c);
        } catch (ex) {
            console.log('Error--->' + ex);
        }
    },

    getLoanDetails_Helper: function (c, e, h) {
        try {
            var app = c.get("v.opportunityObject.Id");
            if (app !== undefined && app !== null) {
                var action = c.get("c.getLoanDetails_Apex");
                action.setParams({
                    "appId": app
                });
                action.setCallback(this, function (response) {
                    if (response.getState() === "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        
                        if (storedResponse !== null && storedResponse !== undefined) {
                            
                            var LD = storedResponse.Loan_Details;
                            var LRO = storedResponse.LoanRO;
                            var LDS = storedResponse.LoanRS_List;
                            var Con = storedResponse.ContractObj;
                            var LR = storedResponse.LoanR_List;
                            
                            c.set('v.LoanDetails', LD);
                            c.set('v.LRO', LRO);
                            c.set('v.LRepaymentSchedule', LDS);
                            c.set('v.ContractDetails', Con);
                            var loan_id = c.get('v.LoanDetails');
                            if (loan_id.QuoteCalculatorScenario != null) {
                                c.set('v.showQuoteCalc', true);
                            }

                        } else {
                            h.showToast_Helper(c, 'error', storedResponse.getErrors());
                        }
                    } else {
                        h.showToast_Helper(c, 'error', 'Something mishappens');
                    }

                });
                $A.enqueueAction(action);
            }
        } catch (ex) {
            console.log('Error--->' + e);
        }
    },

    ToggleSectionOne_Helper: function (c, e, h) {
        c.set('v.isActive', '1');
    },

    ToggleSectionTwo_Helper: function (c, e, h) {
        c.set('v.isActive', '2');
    },

    ToggleSectionThree_Helper: function (c, e, h) {
        c.set('v.isActive', '3');
    },

    ToggleSectionFour_Helper: function (c, e, h) {
        c.set('v.isActive', '4');
    },

    getAllLenderNames_Helper : function (c, e, h) {
        try {
            let action = c.get("c.getAllLenderNames_Apex");
            action.setCallback(this, function (response) {
                let state = response.getState();
                if (state === 'SUCCESS') {
                    let serverResponse = response.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(serverResponse)) {
                        c.set('v.lenderNames', serverResponse)
                        //console.log('serverResponse: ', serverResponse);
                    } else {
                        console.log('Server Response is blank.');
                    }

                } else if (state === 'ERROR') {
                    let errors = response.getError();
                    console.log(errors);
                } else {
                    console.log('Server errors');
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log(ex.message);
        }
    },

    searchAddress_Helper: function (c, e, h) {
        try {
            //console.log(' search key : -- > ' + c.get("v.searchKey")) ;
            let action = c.get("c.getAddressAutoComplete");
            action.setParams({
                "input": c.get("v.searchKey")
            });
            action.setCallback(this, function (r) {
                if (r.getState() === 'SUCCESS') {
                    let inputDress = c.get('v.searchKey');
                    let searchLookup = c.find("searchLookup");
                    let storedResponse = r.getReturnValue();
                    let options = JSON.parse(storedResponse);
                    //console.log('options   '+storedResponse);
                    let predictions = options.predictions;
                    let addressees = [];
                    if (predictions.length > 0) {

                        for (let i = 0; i < predictions.length; i++) {
                            let obj = predictions[i];
                            let bc = [];
                            for (let j = 0; j < obj.terms.length; j++) {

                                bc.push(obj.terms[j].offset, obj.terms[j].value);

                            }
                            addressees.push(
                                {
                                    value: obj.types[0],
                                    PlaceId: obj.place_id,
                                    localVal: bc,
                                    label: obj.description
                                });
                            //console.log(obj.description);
                        }

                        $A.util.addClass(searchLookup, 'slds-is-open');
                    } else {
                        $A.util.removeClass(searchLookup, 'slds-is-open');
                    }
                    c.set("v.filteredOptions", addressees);
                } else {
                    console.log('ERROR');
                    console.log(r.getError());
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log(ex);
        }
    },

    clearAddress_Helper: function (c) {
        try {
            c.find("searchInput").set("v.value", null);
            c.set("v.searchKey", null);
            c.set("v.searchDone", false);
            c.set('v.accountObject.BillingCity', '');
            c.set('v.accountObject.BillingCountry', '');
            c.set('v.accountObject.BillingPostalCode', '');
            c.set('v.accountObject.BillingState', '');
            c.set('v.accountObject.BillingStreet', '');
        } catch (ex) {
            console.log(ex);
        }
    },

    setAddressDetails_Helper: function (c, e, h, placeId) {
        try {
            let action = c.get("c.getAddressDetails");
            action.setParams({
                "placeId": placeId
            });
            action.setCallback(this, function (r) {
                if (r.getState() === 'SUCCESS') {
                    let storedResponse = r.getReturnValue();
                    if (!$A.util.isUndefinedOrNull(storedResponse)) {
                        let parseStoredResponse = JSON.parse(storedResponse);
                        if (!$A.util.isUndefinedOrNull(parseStoredResponse)) {
                            if (!$A.util.isUndefinedOrNull(parseStoredResponse.result)) {
                                if (!$A.util.isUndefinedOrNull(parseStoredResponse.result.address_components) && parseStoredResponse.result.address_components.length > 0) {
                                    let street = '';
                                    parseStoredResponse.result.address_components.forEach(function (elem) {
                                        if (!$A.util.isUndefinedOrNull(elem.types) && elem.types.length > 0) {
                                            elem.types.forEach(function (typeElem) {
                                                if (typeElem.toLowerCase() === 'street_number') {
                                                    //console.log('street_number: ', elem.long_name);
                                                    street += elem.long_name;
                                                }
                                                if (typeElem.toLowerCase() === 'sublocality') {
                                                    //console.log('sublocality: ', elem.long_name);
                                                    street += ' ' + elem.long_name;
                                                }
                                                if (typeElem.toLowerCase() === 'route') {
                                                    //console.log('route: ', elem.long_name);
                                                    street += ' ' + elem.long_name;
                                                }
                                                if (typeElem.toLowerCase() === 'administrative_area_level_2') {
                                                    //console.log('City: ', elem.long_name);
                                                    c.set('v.accountObject.BillingCity', elem.long_name);
                                                }
                                                if (typeElem.toLowerCase() === 'administrative_area_level_1') {
                                                    //console.log('Province: ', elem.long_name);
                                                    c.set('v.accountObject.BillingState', elem.long_name);
                                                }
                                                if (typeElem.toLowerCase() === 'country') {
                                                    //console.log('country: ', elem.long_name);
                                                    c.set('v.accountObject.BillingCountry', elem.long_name);
                                                }
                                                if (typeElem.toLowerCase() === 'postal_code') {
                                                    //console.log('postal_code: ', elem.long_name);
                                                    c.set('v.accountObject.BillingPostalCode', elem.long_name);
                                                }
                                            });
                                        }
                                    });
                                    c.set('v.accountObject.BillingStreet', street);
                                }
                            }
                        }
                    }

                } else {
                    console.log('ERROR');
                    console.log(r.getError());
                }
            });
            $A.enqueueAction(action);
        } catch (ex) {
            console.log(ex);
        }
    },
    checkValidityOfmobile_Helper: function(c, e, h){
        var val = c.find("mob").get('v.value');
        //var mnumber = val.split(' ');
        
        //console.log('mnumber>>'+mnumber);

        var i;
        for(i =0; i< val.length; i++){
            console.log('val[i]::'+val[i]);
            if(val[i]=== ' '){
                h.showToast_Helper(c, 'error', 'Mobile number should not contain space');
                //console.log('Wrong');
                break;
                
            } 
            
        }
    },
})