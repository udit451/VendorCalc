({
    helperMethod : function(c, e, h) {
        try{
            
            let action = c.get("c.checkPaymentStatus_Apex");
            action.setParams({
                "loanId":c.get("v.recordId")
                
            });
            
            action.setCallback(this, function(r){
                if(r.getState() === 'SUCCESS'){
                    let storedResponse = r.getReturnValue();
                    if(storedResponse != null){
                        c.set("v.isOpenPDF",true);
                        //c.set("v.isAccess", true);
                        c.set("v.fileUrl",storedResponse);
                    }
                }
            });
            $A.enqueueAction(action);
            
        }catch (ex){
            console.log('Error :- '+ex);
        }

    }
})