({

    firstPath : function(c, e, h){
        $('#Borrower_Page').show();
        $('#Laon_Page').hide();
        $('#calculator_Page').hide();
        $('#Convert_To_Loan_Page').hide();
        $("#firstLi").addClass("slds-is-current slds-is-active");
        $("#secondLi").removeClass("slds-is-current slds-is-active");
        $("#thirdLi").removeClass("slds-is-current slds-is-active");
        $("#fourthLi").removeClass("slds-is-current slds-is-active");
    },

    secondPath : function(c, e, h){
        $('#Borrower_Page').hide();
        $('#Laon_Page').show();
        $('#calculator_Page').hide();
        $('#Convert_To_Loan_Page').hide();
        $("#firstLi").addClass("slds-is-current slds-is-active");
        $("#secondLi").addClass("slds-is-current slds-is-active");
        $("#thirdLi").removeClass("slds-is-current slds-is-active");
        $("#fourthLi").removeClass("slds-is-current slds-is-active");
    },

    thirdPath : function(c, e, h){
        $('#Borrower_Page').hide();
        $('#Laon_Page').hide();
        $('#calculator_Page').show();
        $('#Convert_To_Loan_Page').hide();
        $("#firstLi").addClass("slds-is-current slds-is-active");
        $("#secondLi").addClass("slds-is-current slds-is-active");
        $("#thirdLi").addClass("slds-is-current slds-is-active");
        $("#fourthLi").removeClass("slds-is-current slds-is-active");
    },

    fourthPath : function(c, e, h){
        $('#Borrower_Page').hide();
        $('#Laon_Page').hide();
        $('#calculator_Page').hide();
        $('#Convert_To_Loan_Page').show();
        $("#firstLi").addClass("slds-is-current slds-is-active");
        $("#secondLi").addClass("slds-is-current slds-is-active");
        $("#thirdLi").addClass("slds-is-current slds-is-active");
        $("#fourthLi").addClass("slds-is-current slds-is-active");
        h.getRelatedOppToConvert_Helper(c, e, h);
    },

    borrowerChange : function(c, e, h){
        h.borrowerChange_Helper(c, e, h);
    },

    resetClick : function(c, e, h){
        if(confirm('Are you sure?')){
            h.resetClick_Helper(c, e, h);
        }
    },

    nextClick : function(c, e, h){
        h.nextClick_Helper(c, e, h);
    },

    saveClick : function(c, e, h){
        h.saveClick_Helper(c, e, h);
    },

    saveAndNextClick : function(c, e, h){
        h.saveAndNextClick_Helper(c, e, h);
    },

    selectCalculator : function (c ,e ,h) {
        h.selectCalculator_Helper(c, e, h);
    },

    ShowMainMenu : function (c,e,h) {
        c.find("SCGeneric_Ext").previousData();
    },

    SaveData : function (c,e,h) {
        c.find("SCGeneric_Ext").saveData();
    },

    ClearData : function (c,e,h) {
        c.find("SCGeneric_Ext").clearData();
    },

    handleSelectedOpp : function (c, e, h){
        h.handleSelectedOpp_Helper(c, e, h);

    },
    convertLoan : function (c, e, h){
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

    saveLoan : function (c, e, h) {
        h.saveLoan_Helper(c, e, h);
    },

    saveNextLoan : function (c, e, h){
        h.saveNextLoan_Helper(c, e, h);
    },

    NextToConvertLoan : function (c, e, h){
        h.NextToConvertLoan_Helper(c, e, h);
    }

})