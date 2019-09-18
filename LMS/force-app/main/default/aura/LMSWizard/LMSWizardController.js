/**
 * Created by Rajat on 5/9/2019.
 */
({
    doInit: function (c, e, h) {
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        c.set("v.MinDate", today)
        h.doInit_helper(c, e, h);
    },

    borrowerChange: function (c, e, h) {
        h.borrowerChange_helper(c, e, h);
    },

    applicantChange: function (c, e, h) {
        h.applicantChange_helper(c, e, h);
    },

    resetClick: function (c, e, h) {
        if (confirm('Are you sure?')) {
            h.resetClick_Helper(c, e, h);
        }
    },

    saveClick: function (c, e, h) {
        h.saveClick_Helper(c, e, h);
        h.checkValidityOfmobile_Helper(c, e, h);
    },

    saveAndNextClick: function (c, e, h) {
        h.saveAndNextClick_Helper(c, e, h);
        h.checkValidityOfmobile_Helper(c, e, h);
    },

    nextClick: function (c, e, h) {
        h.nextClick_Helper(c, e, h);
    },

    showTable: function (c, e, h) {
        c.find('quote').showAmortTable();
    },

    handleSelectedOpp : function (c, e, h){
        h.handleSelectedOpp_Helper(c, e, h);
    },

    convertLoan : function (c, e, h){
        c.set('v.LoanConverted', true);
        h.convertLoan_Helper(c, e, h);
    },

    ToggleSectionOne : function (c, e, h) {
        h.ToggleSectionOne_Helper(c, e, h);
    },

    ToggleSectionTwo : function (c, e, h) {
        h.ToggleSectionTwo_Helper(c, e, h);
    },

    ToggleSectionThree : function (c, e, h) {
        h.ToggleSectionThree_Helper(c, e, h);
    },

    ToggleSectionFour : function (c, e, h) {
        h.ToggleSectionFour_Helper(c, e, h);
    },

    searchAddress: function (c, e, h) {
        h.searchAddress_Helper(c, e, h);
    },

    selectOption : function (c, e, h) {
        let searchInput = c.find("searchInput");
        searchInput.set("v.value", e.currentTarget.dataset.record);
        c.set('v.searchAddress',e.currentTarget.dataset.record);
        c.set('v.searchDone',true);
        let searchLookup = c.find("searchLookup");
        $A.util.removeClass(searchLookup, 'slds-is-open');
        $A.util.removeClass(searchLookup, 'slds-combobox-lookup');
        h.setAddressDetails_Helper(c, e, h, e.currentTarget.dataset.placeid);
    },

    clearAddress : function (c, e, h) {
        h.clearAddress_Helper(c);
    },
    checkValidityOfmobile : function(c, e, h){
        h.checkValidityOfmobile_Helper(c, e, h);
    },
    RedirectToLoan : function(c, e, h){
        var LoanId = c.get('v.LoanDetails');
        var idd = LoanId.id;
        var CurrentUrl = window.location.host;
        window.open('https://'+CurrentUrl+'/'+idd);
        //window.location.href = 'https://'+CurrentUrl+'/'+idd;
    }
})