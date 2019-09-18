({
    doInit : function (c,e,h) {
        var oppId = c.get('v.recordId');
        if(oppId !== undefined){
            var action = c.get("c.getCalculatorsList");
            action.setParams({
                "oppId": oppId
            });
            action.setCallback(this, function (response) {
                if (response.getState() == "SUCCESS") {
                    var storedResponse = (response.getReturnValue());
                    if (storedResponse !== null && storedResponse !== undefined) {
						c.set('v.LoansToConvert', storedResponse);
                        c.set('v.CanConvertApp',true);
                    }
                    else{
                        c.set('v.ErrorMessage', 'No Calculator Data Found');
                         $('#ErrorToast').show();
        				 window.setTimeout(
            			 $A.getCallback(function () {
                		 $('#ErrorToast').hide();
            			 }), 20000
        				);
                        h.backtoRecord_Helper(c, e, h);
                    }
                }
                else{
                    c.set('v.ErrorMessage', 'Something Mishappened');
                    h.showErrorToast_Helper(c);
                    h.backtoRecord_Helper(c, e, h);
                }
            });
            $A.enqueueAction(action);
        }
    },

    returnDetailPage : function (c,e,h) {
        h.backtoRecord_Helper(c, e, h);
    },

    convertLoan : function (c,e,h) {
        h.convertLoan_Helper(c,e,h);
    },

    handleSelectedOpp : function (c,e,h) {
        h.handleSelectedOpp_Helper(c,e,h);
    },

    ToggleSectionOne : function (c,e,h) {
        h.ToggleSectionOne_Helper(c,e,h);
    },

    ToggleSectionTwo : function (c,e,h) {
        h.ToggleSectionTwo_Helper(c,e,h);
    },

    ToggleSectionThree : function (c,e,h) {
        h.ToggleSectionThree_Helper(c,e,h);
    },

    ToggleSectionFour : function (c, e, h) {
        h.ToggleSectionFour_Helper(c, e, h);
    }
})