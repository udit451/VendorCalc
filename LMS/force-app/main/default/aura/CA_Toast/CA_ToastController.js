/***********************************************************************************************************
Name       Date (dd/mm/yyyy)   Change Request Record       Short Description
Krapy Tuli   26/03/2019          Toast Controller        To show the success/error toast on the UI.
**************************************************************************************************************/
({
    closeToast : function(c, e, h) {
        /*To close the toast using button*/
        c.set("v.showToast", false);
    },

    changeToastHandler : function (c, e, h) {
        if (c.get('v.showToast') === true) {
            window.setTimeout(
                $A.getCallback(function () {
                    c.set("v.showToast", false);
                }), 5000
            );
        }
    },

    /*doinit : function(c, e, h){
         /!*To close the toast automatically after 3 seconds*!/
        c.set("v.showToast", true);
        if (c.get('v.showToast') === true) {
            window.setTimeout(
                $A.getCallback(function () {
                    c.set("v.showToast", false);
                }), 3000
            );
        }
    }*/

})