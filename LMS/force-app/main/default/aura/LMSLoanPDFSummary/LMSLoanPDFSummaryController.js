({
    generatePDF : function(c, e, h) {
        //c.set("v.isOpenPDF",true);
       h.helperMethod(c, e, h);
    },
    
    closeAlertPopUp: function(c, e, h){
        c.set("v.isOpenPDF", false);
        //c.set("v.isAccess", false);
    },
})