({
    doInit : function (c,e,h) {
      h.doInit_helper(c,e,h);
    },
    openPaymentPopup : function (c,e,h) {
      let paymentTransJS = c.get("v.PaymentTransaction");
      if(!(paymentTransJS.lms2__Payer_ID__c == undefined && paymentTransJS.lms2__Loan_Account_No__c == undefined) ){
          c.set("v.isButtonClicked",true);
      }
    },
    popupClosed :function (c,e,h) {
        var objChild = c.find('payTransaction');
        let popUpCloseJS = objChild.get("v.OpenPendingSchedulePopUp");
        c.set("v.isButtonClicked",popUpCloseJS);
    },
})