/**
 * Created by krapy on 16/4/18.
 */
({
    showToast_Helper: function (c, variant, message) {
        c.set('v.showToast', false);
        c.set('v.variant', variant);
        c.set('v.message', message);
        c.set('v.showToast', true);
    },

    getSchedule_Helper: function (c, e, h, isButtonClickedJS) {
       
        var payerId = c.get('v.PaymentTransaction.lms2__Payer_ID__c');
        var loanApplicationNo = c.get('v.PaymentTransaction.lms2__Loan_Account_No__c');
        
        if (payerId === null || payerId === undefined || payerId.length <= 0) {
            h.showToast_Helper(c, 'error', 'Please enter PayerId');
            c.set('v.showPayButton', false);
        } else {
            if (loanApplicationNo === null || loanApplicationNo === undefined || loanApplicationNo.length <= 0) {
                h.showToast_Helper(c, 'error', 'Please enter Loan Application Number');
                c.set('v.showPayButton', false);
            }
        }
        if (payerId !== null && payerId !== undefined && loanApplicationNo !== null && loanApplicationNo !== undefined && payerId.length > 0 && loanApplicationNo.length > 0) {
            try {
                var action = c.get("c.getRepaymentSchedule");
                action.setParams({
                    "loanAppNumber": loanApplicationNo
                });
                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        if (storedResponse !== null) {
                            
                            c.set('v.LRSList', storedResponse);
                            c.set('v.showPayButton', true);
                            var element = c.find("getScheduleDiv");
                            $A.util.removeClass(element, "slds-hide");
                           
                        } else {
                            h.showToast_Helper(c, 'error', 'No Schedule found');
                            var element = c.find("getScheduleDiv");
                            $A.util.addClass(element, "slds-hide");
                            c.set('v.showPayButton', false);
                        }
                    } else {
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }
                });
                $A.enqueueAction(action);
            } catch (Ex) {
                console.log('Exception');
                console.log(Ex);
            }
        }
    },

    getPendingSchedule_Helper: function (c, e, h) {
        c.set('v.PendingPaymentList', null);
        var LRS = c.get('v.LRSList');
       
        var PendingScheduleList = [];
        var count = 0;
        try {
            LRS.forEach(function (i) {
                //To check if there are past pending schedules
                if (i.PendingPayment === true) {
                    PendingScheduleList.push(i);
                }
            });
            if (PendingScheduleList.length > 0) {
                c.set('v.OpenPendingSchedulePopUp', true);
                c.set('v.PendingPaymentList', PendingScheduleList);
            } else {
                LRS.forEach(function (i) {
                    if (i.Payment_Status === 'Pending' && i.Payment > 1) {
                        PendingScheduleList.push(i);
                    }
                });
                if (PendingScheduleList.length > 0) {
                    c.set('v.OpenPendingSchedulePopUp', true);
                } else {
                    LRS.forEach(function (i) {
                        if (i.Payment_Status === 'Pending' && i.Payment >= 0 && i.Payment < 1) {
                            PendingScheduleList.push(i);
                        }
                    });
                   
                    if (PendingScheduleList.length > 0) {
                        c.set('v.OpenPendingSchedulePopUp', true);
                        //c.set('v.LoanComplete', true);
                    } else {
                        LRS.forEach(function (i) {
                            if (i.Payment_Status === 'Pending') {
                                PendingScheduleList.push(i);
                            }
                        });
                        if (PendingScheduleList.length === 0) {
                            c.set('v.OpenPendingSchedulePopUp', true);
                            c.set('v.LoanComplete', true);
                        }
                    }
                }
            }
        } catch (e) {
            console.log(e);
        }
    },

    closePendingSchedulePopUp_Helper: function (c, e, h) {
        c.set('v.OpenPendingSchedulePopUp', false);
        let isButtonClicked = c.get("v.isButtonClicked");
        if (isButtonClicked) {
            var vx = c.get("v.method");
            $A.enqueueAction(vx);
        }
    },

    proceedPayment_Helper: function (c, e, h) {
        var LRS = c.get('v.LRSList');
       
        var AmountRequested = 0;
        var ServicingFee = 0;

        let bool = true;
        LRS.forEach(function (i) {
            if (i.Payment_Status === 'Pending' && bool) {
                AmountRequested += i.Payment;
                ServicingFee += i.ServicingAmount;
                bool = false;
            }
        });
        
        AmountRequested = parseFloat(AmountRequested) + parseFloat(ServicingFee);
        

        c.set('v.PaymentTransaction.lms2__Amount_Requested__c', AmountRequested);
        c.set('v.PaymentTransaction.lms2__Payment_Amount__c', '');
        c.set('v.OpenPendingSchedulePopUp', false);
        c.set('v.OpenPaymentPopUp', true);
    },

    closePaymentPopUp_Helper: function (c, e, h) {
        c.set('v.OpenPaymentPopUp', false);
        c.set('v.OpenPendingSchedulePopUp', true);
    },

    checkPendingSchedule_Helper: function (c, e, h) {
        
        var LRSList = c.get('v.LRSList');
        var temp = 0;
        var Balance = 0;
        var RemainingSchedule = 0;
        var PmtSchedule = 0;
        var RequestedAmount = c.get("v.PaymentTransaction.lms2__Amount_Requested__c");
        var Fee = c.get("v.LRSList[0].ServicingAmount");
        var amt = c.get('v.PaymentTransaction.lms2__Payment_Amount__c');
        //Get the total payment value of all unpaid schedules
        
        if (amt === null || amt === 0) {
            h.showToast_Helper(c, 'error', 'Payment Amount cannot be 0');
        } else {
            
            if (amt < 1) {
                h.showToast_Helper(c, 'error', 'Payment Amount should be greater than $1');
            } else {
                LRSList.forEach(function (i) {
                    if (i.Payment_Status === 'Pending') {
                        PmtSchedule += parseFloat(i.Payment);
                        //PmtSchedule = PmtSchedule;
                        if (temp === 0) {
                            Balance = parseFloat(i.Payment);
                            Balance = Balance + Fee;
                            RemainingSchedule = i.Remaining;
                        }
                        temp++;
                    }
                });

                //User pays more Amount than total to be paid
                if (PmtSchedule < 50 && Math.round(amt) < Math.round(PmtSchedule ) && Math.round(amt) === Math.round(PmtSchedule)) {
                    h.showToast_Helper(c, 'error', 'Pay Total Amount as Your Total Amount is less than $50');
                } else {
                    if (Math.round(amt) > Math.round(PmtSchedule + Fee)) {
                        h.showToast_Helper(c, 'error', 'Payment Amount should be less than Total Amount to be Paid');
                    } else {
                        //If it is not the last schedule
                        if (RemainingSchedule > 0) {
                            //Then Adjust option will be shown if user pays more than integer part of required amount
                            if (Math.round(amt) > Math.round(RequestedAmount)) {
                                c.set('v.OpenPaymentPopUp', false);
                                c.set('v.OpenPendingSchedulePopUp', false);
                                c.set('v.showAmountAdjustPopUp', true);
                            } else {
                                if (Math.round(amt) === Math.round(RequestedAmount)) {
                                    h.payPendingSchedule_Helper(c, e, h, false);

                                } else if (Math.round(amt) < Math.round(RequestedAmount)) {
                                    
                                        h.payPendingSchedule_Helper(c, e, h, false);
                                   
                                }
                            }
                        }
                        //If it is the last Schedule then user have to pay the exact amount to close the Loan
                        else {
                            if (amt === RequestedAmount) {
                                h.payPendingSchedule_Helper(c, e, h, false);
                            } else {                                
                                    h.showToast_Helper(c, 'error', 'Pay exact amount as it is last schedule');
                            }
                        }
                    }
                }
            }
        }
    },

    payAmountandAdjustPayment_Helper: function (c, e, h) {
        var opt = c.get('v.selectedOpt');
        if (opt == 'Pay Principal') {
            h.payPendingSchedule_Helper(c, e, h, false);
        }else if(opt == 'Pay Further Schedules'){
            //Here true means user want to pay further schedules and no recalculation needed
            h.payPendingSchedule_Helper(c, e, h, true);
        } else {
            h.showToast_Helper(c, 'error', 'Please Select Payment Method');
        }
    },

    payPendingSchedule_Helper: function (c, e, h, ck) {

        c.set("v.PaymentTransaction.lms2__Loan__c", c.get('v.LRSList[0].Loan'));
       
        var PaymentTransaction = c.get("v.PaymentTransaction");
        
        try {
            if (PaymentTransaction.length !== 0) {
                var action = c.get("c.doPayment");
                action.setParams({
                    "PaymentTransaction": JSON.stringify(PaymentTransaction),
                    "val": JSON.stringify(ck)
                });
                action.setCallback(this, function (response) {
                    if (response.getState() === "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                       
                        if (storedResponse === 'success') {
                            
                            c.set('v.OpenPendingSchedulePopUp', false);
                            c.set('v.showAmountAdjustPopUp', false);
                            c.set('v.OpenPaymentPopUp', false);
                            h.getSchedule_Helper(c, e, h);
                            h.showToast_Helper(c, 'success', 'Your Payment has been saved successfully!');
                            //location.reload();
                            $A.get('e.force:refreshView').fire();
                        }else if(storedResponse === 'Please Use Different Payment Method'){
                            h.showToast_Helper(c, 'error', storedResponse);
                        } else {
                            h.showToast_Helper(c, 'error', storedResponse);
                        }
                    } else {
                        h.showToast_Helper(c, 'error', 'Something mishappens!');
                       
                    }
                });
                $A.enqueueAction(action);
            } else {
                h.showToast_Helper(c, 'error', 'Something mishappens!');
            }
        } catch (Ex) {
            console.log(Ex);
        }
    },

    closeUpdateListPopUp_Helper: function (c, e, h) {
        h.getSchedule_Helper(c, e, h);
    },

    closeAdjustPaymentPopUp_Helper: function (c, e, h) {
        c.set('v.showAmountAdjustPopUp', false);
        c.set('v.OpenPaymentPopUp', true);
    },

    handleSelectedOption_Helper: function (c, e, h) {
        var opt = e.getSource().get('v.value');
        c.set('v.selectedOpt', opt);
       
    },

})