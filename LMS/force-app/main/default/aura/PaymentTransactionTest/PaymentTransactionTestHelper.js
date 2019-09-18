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

    getSchedule_Helper : function (c, e, h) {
        console.log('helper Called');
        var payerId = c.get('v.PaymentTransaction.lms2__Payer_ID__c');
        var loanApplicationNo = c.get('v.PaymentTransaction.lms2__Loan_Account_No__c');
        console.log(payerId);
        console.log(loanApplicationNo);
        if(payerId === null || payerId === undefined || payerId.length <= 0) {
             c.set("v.ErrorMessage", 'Please enter PayerId');
             h.showErrorToast_Helper(c);
             c.set('v.showPayButton', false);
        }
        else{
            if(loanApplicationNo === null || loanApplicationNo === undefined || loanApplicationNo.length <= 0){
                 c.set("v.ErrorMessage",'Please enter Loan Application Number');
                 h.showErrorToast_Helper(c);
                 c.set('v.showPayButton', false);
            }
        }
        if(payerId !== null && payerId !== undefined && loanApplicationNo !== null && loanApplicationNo !== undefined && payerId.length > 0 && loanApplicationNo.length > 0)
        {
            try{
                var action =  c.get("c.getRepaymentSchedule");
                action.setParams({
                    "loanAppNumber" : loanApplicationNo
                });
                action.setCallback(this, function (response) {
                    if(response.getState() == "SUCCESS"){
                        var storedResponse = (response.getReturnValue());
                        if(storedResponse !== null){
                            console.log(storedResponse);

                            c.set('v.LRSList', storedResponse);
                            c.set('v.showPayButton', true);
                            var element = c.find("getScheduleDiv");
	    					$A.util.removeClass(element, "slds-hide");
                            var CloasingBalance = 0;
                            var nextPayDate = 0;
                            console.log('CloasingBalance--->'+CloasingBalance);
                            for(var i=0;i<storedResponse.length;i++){
                                if(storedResponse[i].Payment_Status === 'Pending'){
                                    CloasingBalance = parseFloat(storedResponse[i].Opening_Balance);
                                    nextPayDate = storedResponse[i].Repayment_Date;
                                    break;
                                }
                            }
                            console.log('CloasingBalance--->'+CloasingBalance);
                            c.set('v.TotalUnPaidAmount',CloasingBalance);
                            c.set('v.nextPaymentDate',nextPayDate);
                            console.log('nextPayDate--->'+nextPayDate);
                            console.log('CloasingBalance--->'+CloasingBalance);
                            c.set('v.isOpen',true);
                        }
                        else{
                            c.set('v.ErrorMessage', 'No Schedule found');
                            h.showErrorToast_Helper(c);
                            var element = c.find("getScheduleDiv");
	    					$A.util.addClass(element, "slds-hide");
                            c.set('v.showPayButton', false);
                        }
                    }
                    else {
                    c.set('v.ErrorMessage', 'Something mishappens!');
                    h.showErrorToast_Helper(c);
                    }
                });
                $A.enqueueAction(action);
            	}
            catch(Ex){
                console.log('Exception');
                console.log(Ex);
            }
        }
    },

    getPendingSchedule_Helper : function (c, e, h) {
        c.set('v.PendingPaymentList', null);
        var LRS = c.get('v.LRSList');
        //console.log(LRS);
        var PendingScheduleList = [];
        var count = 0;
        try {
            LRS.forEach(function (i) {
                //To check if there are past pending schedules
                if (i.PendingPayment === true) {
                    PendingScheduleList.push(i);
                }
            });
            if(PendingScheduleList.length > 0)
            {
                c.set('v.OpenPendingSchedulePopUp', true);
                c.set('v.PendingPaymentList', PendingScheduleList);
            }
            else{
                LRS.forEach(function (i) {
                    if (i.Payment_Status === 'Pending' && i.Payment > 1 ){
                        PendingScheduleList.push(i);
                    }
                });
                if(PendingScheduleList.length > 0){
                    c.set('v.OpenPendingSchedulePopUp', true);
                }
                else{
                    LRS.forEach(function (i) {
                        if (i.Payment_Status === 'Pending' && i.Payment >= 0 && i.Payment < 1 ){
                            PendingScheduleList.push(i);
                        }
                    });
                    if(PendingScheduleList.length > 0)
                    {
                        c.set('v.OpenPendingSchedulePopUp', true);
                        c.set('v.LoanComplete', true);
                    }
                    else{
                        LRS.forEach(function (i) {
                            if (i.Payment_Status === 'Pending'){
                                PendingScheduleList.push(i);
                            }
                        });
                        if(PendingScheduleList.length === 0) {
                            c.set('v.OpenPendingSchedulePopUp', true);
                            c.set('v.LoanComplete', true);
                        }
                    }
                }
            }
        }
        catch(e){
            console.log(e);
        }
    },

    closePendingSchedulePopUp_Helper : function (c, e, h){
        c.set('v.OpenPendingSchedulePopUp',false);
    },

    proceedPayment_Helper : function (c, e, h){
        var LRS = c.get('v.LRSList');
        var AmountRequested = 0;
        LRS.forEach(function (i) {
            if(i.PendingPayment === true){
                console.log(i.Payment);
                AmountRequested += i.Payment;
            }
        });
        console.log(AmountRequested);
        c.set('v.PaymentTransaction.lms2__Amount_Requested__c',AmountRequested);
        c.set('v.PaymentTransaction.lms2__Payment_Amount__c','');
        c.set('v.OpenPendingSchedulePopUp', false);
        c.set('v.OpenPaymentPopUp', true);
    },

    closePaymentPopUp_Helper : function (c, e, h) {
        c.set('v.OpenPaymentPopUp',false);
        c.set('v.OpenPendingSchedulePopUp',true);
    },

    checkPendingSchedule_Helper :function (c, e, h) {

        var LRSList = c.get('v.LRSList');
        var temp = 0;
        var Balance = 0;
        var RemainingSchedule = 0;
        var PmtSchedule = 0;
        var RequestedAmount = c.get("v.PaymentTransaction.lms2__Amount_Requested__c");//(new 2 Aug)
        var amt = c.get('v.PaymentTransaction.lms2__Payment_Amount__c');
        console.log(amt);
        //Get the total payment value of all unpaid schedules

        if(amt == null || amt == 0){
            c.set('v.ErrorMessage', 'Payment Amount cannot be 0');
            h.showErrorToast_Helper(c);
        }
        else {

            if (amt < 1) {
                c.set('v.ErrorMessage', 'Payment Amount should be greater than $1');
                h.showErrorToast_Helper(c);
            }

            else {
                /*LRSList.forEach(function (i) {
                    if (i.Payment_Status === 'Pending') {
                        console.log(i.Payment);
                        Balance += parseFloat(i.Payment);
                    }
                });*/
                console.log(Balance);
                LRSList.forEach(function (i) {
                    if (i.Payment_Status === 'Pending' && temp === 0) {
                        console.log('Got');
                        Balance = parseFloat(i.Opening_Balance);
                        PmtSchedule = parseFloat(i.Payment);
                        RemainingSchedule = i.Remaining;
                        temp++;
                    }
                });

                console.log(RemainingSchedule);
                console.log('amt1>>>>>>'+amt);
                console.log('PmtSchedule1>>>>>>'+PmtSchedule);
                console.log('RequestedAmount1>>>>>>'+RequestedAmount);
                //User pays more Amount than total to be paid
                if (amt > Balance) {
                    c.set('v.ErrorMessage', 'Payment Amount should be less than Total Amount');
                    h.showErrorToast_Helper(c);
                }
                else {
                    //If it is not the last schedule
                    if (RemainingSchedule !== 0) {
                        //Then Adjust option will be shown if user pays more than integer part of required amount
                        if (Math.round(amt) > Math.round(RequestedAmount)) {
                            c.set('v.OpenPaymentPopUp', false);
                            c.set('v.OpenPendingSchedulePopUp', false);
                            c.set('v.showAmountAdjustPopUp', true);
                        }
                        else {
                            /*if (amt >= PmtSchedule) {
                                h.payPendingSchedule_Helper(c, e, h, true);
                            }
                            else {
                                h.payPendingSchedule_Helper(c, e, h, false);
                            }*/
                            if (Math.round(amt) ===  Math.round(RequestedAmount)) {

                                h.payPendingSchedule_Helper(c, e, h, false);

                            }
                            else if (Math.round(amt) < Math.round(RequestedAmount)) {
                                h.payPendingSchedule_Helper(c, e, h, false);

                            }
                        }
                    }
                    //If it is the last Schedule then user have to pay the exact amount to close the Loan
                    else {
                        if (amt === RequestedAmount) {
                            h.payPendingSchedule_Helper(c, e, h, false);
                        }
                        else {

                            if(RequestedAmount - amt < 1){
                                h.payPendingSchedule_Helper(c, e, h, false);

                            }
                            else{

                                c.set('v.ErrorMessage', 'Pay exact amount as it is last schedule');
                                 h.showErrorToast_Helper(c);}
                        }
                    }
                }
            }
        }
    },

    payAmountandAdjustPayment_Helper : function (c, e, h){
        var opt = c.get('v.selectedOpt');
        if(opt == 'Pay Principal'){
            h.payPendingSchedule_Helper(c, e, h, false);
       }
       else{
            //Here true means user want to pay further schedules and no recalculation needed
           h.payPendingSchedule_Helper(c, e, h,true);
       }
    },

    payPendingSchedule_Helper : function (c, e, h, ck){
        c.set("v.PaymentTransaction.lms2__Loan__c",c.get('v.LRSList[0].Loan'));
        var PaymentTransaction = c.get("v.PaymentTransaction");
        console.log('----->'+JSON.stringify(PaymentTransaction));
        try {
            if (PaymentTransaction.length !== 0) {
                var action = c.get("c.doPayment");
                action.setParams({
                    "PaymentTransaction": JSON.stringify(PaymentTransaction),
                    "val": JSON.stringify(ck)
                });
                action.setCallback(this, function (response) {
                    if (response.getState() == "SUCCESS") {
                        var storedResponse = (response.getReturnValue());
                        console.log(storedResponse);
                        if (storedResponse === 'success') {
                            console.log(storedResponse);
                            //c.set('v.UpdatedLRSList', storedResponse);
                            c.set('v.OpenPendingSchedulePopUp', false);
                            c.set('v.showAmountAdjustPopUp', false);
                            c.set('v.OpenPaymentPopUp', false);
                            h.getSchedule_Helper(c, e, h);
                            c.set('v.SuccessMessage', 'Your Payment has been saved successfully!');
                            h.showSuccessToast_Helper(c);
                        }
                        else {
                            c.set('v.ErrorMessage', storedResponse);
                            h.showErrorToast_Helper(c);
                        }
                    }
                    else {
                        c.set('v.ErrorMessage', 'Something mishappens!');
                        h.showErrorToast_Helper(c);
                    }
                });
                $A.enqueueAction(action);
            }
            else {
                c.set('v.ErrorMessage', 'Something mishappens!');
                h.showErrorToast_Helper(c);
            }
        }
        catch(Ex)
        {
            console.log(Ex);
        }
    },
    closeUpdateListPopUp_Helper : function (c, e, h) {
        h.getSchedule_Helper(c, e, h);
    },

    closeAdjustPaymentPopUp_Helper : function (c, e, h) {
        c.set('v.showAmountAdjustPopUp',false);
        c.set('v.OpenPaymentPopUp',true);
    },

    handleSelectedOption_Helper : function(c, e, h)
    {
        var opt = e.getSource().get('v.value');
        c.set('v.selectedOpt',opt);
        console.log(opt);
    },
    calculateAllPaymentBalance:function(c,e,h,loanApplicationNo){
        try{
             var action = c.get("c.calculateAllPaymentBalance_Apex");
            action.setParams({
                "LoanApplicationNo": loanApplicationNo
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {

                        var totalPaidAmount = 0;
                        var totalUnpaidAmmount = 0;
                        for(var i=0;i<storedResponse.length;i++){
                            console.log(parseFloat(storedResponse.Payment_Status));
                            if(storedResponse.Payment_Status === 'Paid'){
                                totalPaidAmount+=parseFloat(storedResponse.lms2__Payment__c);
                            }else{
                                totalUnpaidAmmount+=parseFloat(storedResponse.lms2__Payment__c);
                            }
                        }
                        console.log('totalPaidAmount--->'+totalPaidAmount);
                        console.log('totalUnpaidAmmount---->'+totalUnpaidAmmount);
                        c.set('v.TotalPaidAmount',totalPaidAmount);
                        c.set('v.isOpen',true);
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
    },
    recalculate_helper:function(c,e,h){
    console.log('recalculate_helper');
        var totalAmmount = c.get('v.TotalUnPaidAmount');
        var newAmount = c.get('v.NewLoanAmount');
        var nextPayDate = c.get('v.nextPaymentDate');
        var totalNewLoanAmount = parseFloat(totalAmmount) + parseFloat(newAmount);
        console.log('nextPayDate--->'+nextPayDate);
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();
        console.log('today--->'+today);
        var todayDate = yyyy +'-'+mm+'-'+dd;
         console.log('todayDate--->'+todayDate);
    }
})