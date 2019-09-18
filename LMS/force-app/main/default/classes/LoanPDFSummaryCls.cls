public class LoanPDFSummaryCls {
    
    public static LoanSummaryWrapper summmaryWrapperObject {get;set;}
    public static List<LoanSummaryWrapper> loanSummaryList {get;set;}
    public static LoanSummaryWrapper summaryPaidObject {get;set;}
    public static List<LoanSummaryWrapper> summaryPaidList {get;set;}
    public static lms2__Loan__c loanAccount {get;set;}
    public static User currentUser {get;set;}
    public static String logoUrl {get;set;}
    
    public static Boolean hasLoanId {get;set;}
    public LoanPDFSummaryCls(){
        String getId = String.valueOf(ApexPages.currentPage().getParameters().get('id'));
        System.debug('getId>>'+getId);
        if (ApexPages.currentPage().getUrl().contains('id=') && ApexPages.currentPage().getParameters().get('id') != '') {
            System.debug('In if');
            hasLoanId = true;
            LoanPDFSummaryCls.getPDFData(getId);
        }else {
            hasLoanId = false;
        }
    }
    @AuraEnabled
    public static void getPDFData(String loanId){
        System.debug('loanId>>'+loanId);
        currentuser = new User();
        currentuser = [SELECT id, Name, AccountId, ContactId, CompanyName, MobilePhone, Street, City, State, PostalCode, Country FROM User WHERE id = '0057F000005DE7S' ];
        System.debug('currentuser>>'+currentuser);
        Account accountData = new Account();
        if (currentuser.AccountId != null) {
				accountData= [Select lms2__Logo_URL__c From Account where Id = :currentuser.AccountId];
                System.debug('accountData>>'+accountData);
            logoUrl = accountData.lms2__Logo_URL__c;
        } else {
            logoUrl = '';
        }
        loanAccount = new lms2__Loan__c();
        if(loanId != null){
            loanAccount = [SELECT Name, lms2__Account_Name__r.Name, lms2__Lender_Funder__c,lms2__Asset_Type__c,lms2__Customer_Interest_Rate__c,lms2__Current_Monthly_Loan_Repayment_c__c,lms2__Term_Start_Date__c,lms2__Term_End_Date__c,lms2__Total_Interest__c,lms2__Total_Loan_Repayment__c,lms2__Contract__r.ContractNumber, lms2__Loan_Account_No__c, lms2__Loan_Amount_c__c, lms2__Term_of_Loan_N__c FROM lms2__Loan__c WHERE Id =:loanId]; 
            
            System.debug('loanAccount>>'+loanAccount) ;
        }
        List<lms2__Loan_Repayent_Schedule__c> loanSummaryPdfList = new List<lms2__Loan_Repayent_Schedule__c>();
        loanSummaryList = new List<LoanSummaryWrapper>();
        summaryPaidList = new List<LoanSummaryWrapper>();
        
        try{
            if(loanId != null){
                
                 
                //lms2__Loan_Repayent_Schedule__c summaryData = new lms2__Loan_Repayent_Schedule__c();
                
                String loanSummary =  'SELECT Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c, lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c, lms2__Closing_Balance__c, lms2__Principal__c, lms2__Estimated_Repayment_Date__c,lms2__Interest__c,lms2__Loan_Account_2__c,lms2__Loan_Account_2__r.lms2__Quote_Calculator__c,lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c,lms2__Payment__c, lms2__Loan_Application_Number__c,lms2__Loan_Repayment_del__c,lms2__Loan_Repayment_Option__c,lms2__Opening_Balance__c,lms2__Payment_Status__c,lms2__Repayment_Number_del__c,lms2__Remaining__c FROM lms2__Loan_Repayent_Schedule__c WHERE lms2__Loan_Account_2__c =: loanId';
                loanSummaryPdfList = Database.query(loanSummary);
                System.debug('loanSummaryPdfList>>'+loanSummaryPdfList);
                
                for(lms2__Loan_Repayent_Schedule__c loanRepayObject : loanSummaryPdfList){
                    if(loanRepayObject.lms2__Payment_Status__c == 'Pending'){
                        summmaryWrapperObject = new LoanSummaryWrapper();
                        
                        
                        summmaryWrapperObject.Repayment_Date = loanRepayObject.lms2__Estimated_Repayment_Date__c;
                        System.debug('summmaryWrapperObject.Name'+summmaryWrapperObject.Name);
                        summmaryWrapperObject.Opening_Balance = loanRepayObject.lms2__Opening_Balance__c.setScale(2);
                        summmaryWrapperObject.Closing_Balance = loanRepayObject.lms2__Closing_Balance__c.setScale(2);
                        summmaryWrapperObject.Payment = loanRepayObject.lms2__Payment__c.setScale(2); 
                        summmaryWrapperObject.Interest =loanRepayObject.lms2__Interest__c.setScale(2);
                        summmaryWrapperObject.Principal_Amount = loanRepayObject.lms2__Principal__c.setScale(2);
                        summmaryWrapperObject.Payment_Status = loanRepayObject.lms2__Payment_Status__c; 
                        System.debug('summmaryWrapperObject.Payment_Status'+summmaryWrapperObject.Payment_Status);   
                        loanSummaryList.add(summmaryWrapperObject);
                        System.debug('loanSummaryList>>'+loanSummaryList);
                        
                    }else if(loanRepayObject.lms2__Payment_Status__c == 'Paid'){
                        System.debug('in elseIf');
                        summaryPaidObject = new LoanSummaryWrapper();
                        summaryPaidObject.Repayment_Date = loanRepayObject.lms2__Estimated_Repayment_Date__c;
                        System.debug('summaryPaidObject.Name'+summaryPaidObject.Name);
                        summaryPaidObject.Opening_Balance = loanRepayObject.lms2__Opening_Balance__c.setScale(2);
                        summaryPaidObject.Closing_Balance = loanRepayObject.lms2__Closing_Balance__c.setScale(2);
                        summaryPaidObject.Payment = loanRepayObject.lms2__Payment__c.setScale(2);    
                        summaryPaidObject.Interest = loanRepayObject.lms2__Interest__c.setScale(2);
                        summaryPaidObject.Principal_Amount = loanRepayObject.lms2__Principal__c.setScale(2);
                        summaryPaidObject.Payment_Status = loanRepayObject.lms2__Payment_Status__c; 
                        System.debug('summaryPaidObject.Payment_Status'+summaryPaidObject.Payment_Status);   
                        summaryPaidList.add(summaryPaidObject);
                        System.debug('summaryPaidList>>'+summaryPaidList);
                        
                    }    
                }    
                
            }
            
            
        }catch (Exception e){
            
            System.debug(e.getLineNumber());
            System.debug(e.getMessage());
            
        }
        //return null;
        
    }
    public class LoanSummaryWrapper{
        public String Name {get;set;}
        public Decimal Closing_Balance {get;set;}
        public String Loan_Period {get;set;}
        public Decimal Interest_Rate {get;set;}
        public Date Repayment_Date {get;set;}
        public Decimal Interest {get;set;}
        public Decimal Payment {get;set;}
        public String Loan_Application_Number {get;set;}
        public Decimal Loan_Repayment {get;set;}
        public String Loan_Repayment_Option {get;set;}
        public Decimal Opening_Balance {get;set;}
        public String Payment_Status {get;set;}
        public Decimal Remaining {get;set;}
        public Decimal Repayment_Number {get;set;}
        public Boolean PendingPayment {get;set;}
        public Boolean PaidPayment {get;set;}
        public String Loan {get;set;}
        public Decimal Principal_Amount {get;set;}
        
    }
    @AuraEnabled
    public static String checkPaymentStatus_Apex(String loanId) {
        String getId = loanId;
        if (String.isNotBlank(loanId)) {
            
            String siteURL = LoanPDFSummaryCls.getPublicSiteLink_Apex();
            return siteURL + '/apex/lms2__LMSLoanPDFSummary?id=' + getId;
            
        } else {
            return 'No Status found';
        }
    }      
    
    @AuraEnabled
    public static String getPublicSiteLink_Apex() {
        String SiteId = Site.getSiteId();
        if (SiteId == NULL) {
            return null;
        } else {
            String BaseUrl = Site.getBaseUrl();
            String Domain = Site.getDomain();
            String PathPrefix = Site.getPathPrefix();
            String FullURL = '';
            if (BaseUrl != NULL) {
                FullURL += BaseUrl;
            }
            return FullURL;
        }
    }
}