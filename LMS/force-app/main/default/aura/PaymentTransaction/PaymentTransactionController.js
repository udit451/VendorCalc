/**
 * Created by Rajat on 3/22/2018.
 */
({
    doInitPT : function(c, e, h){
        let repaymentJS = c.get("v.AmountFin");

        c.set("v.PaymentTransaction.lms2__Amount_Requested__c",repaymentJS);
        let isButtonClickedJS = c.get("v.isButtonClicked");
        if(isButtonClickedJS){
            h.getSchedule_Helper(c, e, h,isButtonClickedJS);
        }
    },

    getSchedule : function (c, e, h) {
        h.getSchedule_Helper(c, e, h);

    },
    getPendingSchedule : function (c, e, h) {
        h.getPendingSchedule_Helper(c, e, h,null);
    },

    closePendingSchedulePopUp : function (c, e, h){
        h.closePendingSchedulePopUp_Helper(c, e, h);
    },

    proceedPayment : function (c, e, h){
        h.proceedPayment_Helper(c, e, h);
    },

    closePaymentPopUp : function (c, e, h) {
        h.closePaymentPopUp_Helper(c, e, h);
    },

    checkPendingSchedule : function (c, e, h) {
        h.checkPendingSchedule_Helper(c, e, h);
        //h.showErroMessage_Helper(c, e, h);
    },

    closeUpdateListPopUp : function (c, e, h) {
        h.closeUpdateListPopUp_Helper(c, e, h);
    },

    closeAdjustPaymentPopUp : function (c, e, h) {
        h.closeAdjustPaymentPopUp_Helper(c, e, h);
    },

    payAmountandAdjustPayment : function (c, e, h) {       
        h.payAmountandAdjustPayment_Helper(c, e, h);
    },

    handleSelectedOption : function (c, e, h) {
        h.handleSelectedOption_Helper(c, e, h);
    },
    showErroMessage : function(c, e, h){       
       h.showErroMessage_Helper(c, e, h);
    }
    
})