/**
* Created by krapy on 16/4/18.
*/

public with sharing class PaymentTransactionController {


    @AuraEnabled public static List<Payment_Schedule_List_Wrapper> getRepaymentSchedule(String loanAppNumber) {

        try {
            if (loanAppNumber != null) {
                List<lms2__Loan_Repayent_Schedule__c> LRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
                List<Payment_Schedule_List_Wrapper> Schedules = new List<Payment_Schedule_List_Wrapper>();
                Integer count = 0;
                Decimal Payment = 0;
                LRepaymentSchedule = [
                        Select Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c,lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c,lms2__Closing_Balance__c,
                                lms2__Estimated_Repayment_Date__c,
                                lms2__Interest__c,
                                lms2__Payment__c,
                                lms2__Loan_Application_Number__c,
                                lms2__Loan_Repayment_del__c,
                                lms2__Loan_Repayment_Option__c,
                                lms2__Opening_Balance__c,
                                lms2__Payment_Status__c,
                                lms2__Repayment_Number_del__c,
                                lms2__Remaining__c,
                                lms2__Servicing_Fee__c,
                                lms2__Loan_Repayment_Option__r.lms2__Loan__c
                        from lms2__Loan_Repayent_Schedule__c
                        where lms2__Loan_Application_Number__c = :loanAppNumber
                        AND lms2__Loan_Repayment_Option__r.lms2__Active__c = true
                        AND lms2__Payment_Status__c = 'Pending'
                        order by lms2__Repayment_Number_del__c

                ];
                if (LRepaymentSchedule.size() > 0) {
                    //(LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c);
                    for (lms2__Loan_Repayent_Schedule__c LRS : LRepaymentSchedule) {
                        Payment_Schedule_List_Wrapper PSListWrapper = new Payment_Schedule_List_Wrapper();
                        PSListWrapper.Name = LRS.Name;
                        PSListWrapper.Closing_Balance = Double.valueOf(LRS.lms2__Closing_Balance__c.setScale(2));
                        PSListWrapper.Loan_Period = LRS.lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c;
                        PSListWrapper.Interest_Rate = LRS.lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c;
                        PSListWrapper.Repayment_Date = LRS.lms2__Estimated_Repayment_Date__c;
                        PSListWrapper.Interest = LRS.lms2__Interest__c.setScale(2).setScale(2);
                        PSListWrapper.Payment = Double.valueOf(LRS.lms2__Payment__c.setScale(2));
                        PSListWrapper.Loan_Application_Number = LRS.lms2__Loan_Application_Number__c;
                        PSListWrapper.Loan_Repayment = LRS.lms2__Loan_Repayment_del__c;
                        PSListWrapper.Loan_Repayment_Option = LRS.lms2__Loan_Repayment_Option__c;
                        PSListWrapper.Opening_Balance = Double.valueOf(LRS.lms2__Opening_Balance__c.setScale(2));
                        PSListWrapper.ServicingAmount = LRS.lms2__Servicing_Fee__c;
                        PSListWrapper.Payment_Status = LRS.lms2__Payment_Status__c;
                        PSListWrapper.Remaining = LRS.lms2__Remaining__c;
                        PSListWrapper.Repayment_Number = LRS.lms2__Repayment_Number_del__c;
                        PSListWrapper.Loan = LRS.lms2__Loan_Repayment_Option__r.lms2__Loan__c;
                        if (LRS.lms2__Payment_Status__c == 'Pending' && LRS.lms2__Estimated_Repayment_Date__c <= date.today()) {
                            PSListWrapper.PendingPayment = true;
                        } else {
                            PSListWrapper.PendingPayment = false;
                        }
                        Schedules.add(PSListWrapper);
                    }
                   // System.debug(Schedules);
                    return Schedules;
                }
                return null;
            }
        } catch (Exception e) {
            System.debug(e);
        }
        return null;
    }

    @AuraEnabled
    public static String doPayment(String PaymentTransaction, String val) {

        if (PaymentTransaction != '') {
            try {

                lms2__Payment_Transaction__c PaymentTrans = new lms2__Payment_Transaction__c();
                PaymentTrans = (lms2__Payment_Transaction__c) JSON.deserialize(PaymentTransaction, lms2__Payment_Transaction__c.class);
                PaymentTrans.lms2__Payment_Date_and_Time__c = System.now();

                insert PaymentTrans;

                Integer count = 0;

                String Message_to_return;
                List<lms2__Loan_Repayent_Schedule__c> LRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
                LRepaymentSchedule = [
                        Select Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c,lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c,lms2__Closing_Balance__c,
                                lms2__Estimated_Repayment_Date__c,
                                lms2__Interest__c,
                                lms2__Loan_Account_2__c,
                                lms2__Loan_Account_2__r.lms2__Quote_Calculator__c,
                                lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c,
                                lms2__Payment__c,
                                lms2__Loan_Application_Number__c,
                                lms2__Loan_Repayment_del__c,
                                lms2__Loan_Repayment_Option__c,
                                lms2__Opening_Balance__c,
                                lms2__Payment_Status__c,
                                lms2__Repayment_Number_del__c,
                                lms2__Remaining__c,
                                lms2__Servicing_Fee__c
                        from lms2__Loan_Repayent_Schedule__c
                        where lms2__Loan_Application_Number__c = :PaymentTrans.lms2__Loan_Account_No__c and lms2__Payment_Status__c = 'Pending'
                        AND lms2__Loan_Repayment_Option__r.lms2__Active__c = true
                        order by lms2__Repayment_Number_del__c asc
                ];
                PaymentTrans.lms2__Loan_Repayment_Option__c = LRepaymentSchedule[0].lms2__Loan_Repayment_Option__c;
                update PaymentTrans;
                String loanAccountId  = LRepaymentSchedule[0].lms2__Loan_Account_2__c;
                Decimal Fee = LRepaymentSchedule[0].lms2__Servicing_Fee__c;
                if (LRepaymentSchedule[0].lms2__Loan_Account_2__r.lms2__Quote_Calculator__c != null) {
                    return doPaymentForQuote(PaymentTrans, LRepaymentSchedule, Boolean.valueOf(val));
                } else {
                    Decimal opening_Bal, newTerm, serial, newPmt, PMTtobePaid, PMTdifference, newClosingBal, ClosingBal, ROI, PaymentMade, updatedCB, Term, InterestCharged;
                    String paymentCondition = '';
                    //set<Id> LRSPaid = new set<Id>();
                    List<lms2__Loan_Repayent_Schedule__c> LRSPaid = new List<lms2__Loan_Repayent_Schedule__c>();
                    List<lms2__Loan_Repayment__c> LRepayment = new List<lms2__Loan_Repayment__c>();
                    ROI = LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c;
                    Term = LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c == null && LRepaymentSchedule[0].lms2__Loan_Account_2__r.lms2__Quote_Calculator__c != null ? LRepaymentSchedule[0].lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c : Decimal.valueOf(LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c) * 12;
                    PMTtobePaid = Double.valueOf(LRepaymentSchedule[0].lms2__Payment__c);
                    Decimal PMTtobePaidWithFee = PMTtobePaid;
                    if(Fee != null ){
                        PMTtobePaidWithFee = PMTtobePaidWithFee + Fee;
                    }

                    InterestCharged = Double.valueOf(LRepaymentSchedule[0].lms2__Interest__c);
                    opening_Bal = Double.valueOf(LRepaymentSchedule[0].lms2__Opening_Balance__c);
                    ClosingBal = Double.valueOf(LRepaymentSchedule[0].lms2__Closing_Balance__c);
                    serial = LRepaymentSchedule[0].lms2__Repayment_Number_del__c;
                    PaymentMade = PaymentTrans.lms2__Payment_Amount__c;

                    // If more than one pending schedule are left
                    //('LRepaymentSchedule.size()>>>>'+LRepaymentSchedule.size());
                    if (LRepaymentSchedule.size() > 1) {
                        if (PaymentMade < InterestCharged) {
                            newClosingBal = ClosingBal + (PMTtobePaid - InterestCharged) + (InterestCharged - PaymentMade);
                        } else if (PaymentMade == InterestCharged) {
                            newClosingBal = ClosingBal + (PMTtobePaid - InterestCharged);
                        } else {
                            PMTdifference = PaymentMade - ( PMTtobePaid.setScale(2) + fee );
                            newClosingBal = ClosingBal - PMTdifference;
                        }
                        if (val == 'false') {
                            if (PMTtobePaidWithFee > PaymentMade) {
                                newTerm = Term - serial ;
                                PMTdifference = PaymentMade - PMTtobePaid.setScale(2);
                                newClosingBal = ClosingBal - PMTdifference;
                                newPmt = calcNewPMT(ROI / 12, newTerm, -newClosingBal, 0, 0);
                                LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                                LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
                                LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = 0;
                                LRepaymentSchedule[0].lms2__Closing_Balance__c = newClosingBal.setScale(2);
                                LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                                LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                                LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                                LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                                
                                Decimal remainingFee = LRepaymentSchedule[0].lms2__Servicing_Fee__c;
                                LRSPaid.add(LRepaymentSchedule[0]);

                                Decimal totalPaidAmt = newPmt * newTerm;
                                Decimal closingbalance1;
                                for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                                    if (pay.lms2__Repayment_Number_del__c == serial + 1) {
                                        Decimal remainingbalance = PMTtobePaidWithFee - PaymentMade;

                                        if(remainingbalance <= pay.lms2__Servicing_Fee__c){
                                            pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingbalance;
                                        }else if(remainingbalance > remainingFee) {
                                            remainingbalance = remainingbalance - remainingFee;
                                            pay.lms2__Payment__c = pay.lms2__Payment__c + remainingbalance ;
                                            pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingFee;
                                        }else if(remainingbalance == remainingFee){
                                            pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingFee;
                                        }
                                        pay.lms2__Opening_Balance__c = newClosingBal.setScale(2);
                                        newClosingBal = closingbalance1;
                                        if(pay.lms2__Remaining__c == 0){
                                        pay.lms2__Closing_Balance__c = 0.00;
                                        }
                                    }
                                    //newClosingBal = closingbalance1;
                                }
                                LRSPaid.add(LRepaymentSchedule[0]);
                                /*LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
                                if(LRepayment.size() > 0){
                                    delete LRepayment;
                                }*/
                                update LRepaymentSchedule;
                                calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                                updateFeeAndExpense(LRSPaid, PaymentTrans);
                                return 'success';

                            }
                            //When user pays more than the requested Amount and opts for Pay Principal
                            else {
                                newTerm = Term - serial ;
                                 Decimal newOpeningValue = newClosingBal;
                                newPmt = calcNewPMT(ROI / 1200, newTerm, -newClosingBal, 0, 1);
                                LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                                LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = PaymentMade - PMTtobePaidWithFee;
                                LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
                                LRepaymentSchedule[0].lms2__Closing_Balance__c = newClosingBal.setScale(2);
                                LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                                LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                                LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                                LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                                
                                LRSPaid.add(LRepaymentSchedule[0]);

                                Decimal totalPaidAmt = newPmt * newTerm;
                                Decimal closingbalance1;
                                Decimal totalInterest = totalPaidAmt - newClosingBal;
                                for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                                    if (pay.lms2__Repayment_Number_del__c != serial) {
                                        Decimal InterestMonthly = totalInterest / newTerm;
                                        Decimal principal = newPmt - InterestMonthly;
                                        closingbalance1 = newClosingBal - principal;
                                        pay.lms2__Opening_Balance__c = newClosingBal.setScale(2);
                                        closingBal = newClosingBal.setScale(2);
                                        pay.lms2__Interest__c = InterestMonthly.setScale(2);
                                        pay.lms2__Capital_Repaid_del__c = principal.setScale(2);
                                        pay.lms2__Payment__c = newPmt.setScale(2);
                                        pay.lms2__Closing_Balance__c = closingbalance1.setScale(2);
                                        newClosingBal = closingbalance1;
                                        if(pay.lms2__Remaining__c == 0){
                                        pay.lms2__Closing_Balance__c = 0.00;
                                        }
                                    }
                                }
                                /*LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
                                if(LRepayment.size() > 0){
                                    delete LRepayment;
                                }*/
                                update LRepaymentSchedule;
                                createNewLoanRepaymentSchedule(PaymentTrans, newOpeningValue, newTerm);
                                calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                                updateFeeAndExpense(LRSPaid, PaymentTrans);
                                return 'success';
                            }
                        }
                        //When user pays more than the requested Amount and opts for Pay Further Schedule
                        else {
                            Integer paymentYears, n;
                            n = 0;
                            Decimal remBalance;
                            Double PaidMoney;
                            PaidMoney = PaymentMade;

                            for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                                if (pay.lms2__Payment_Status__c == 'Pending'){
                                    if (PaymentMade == (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)) {
                                        pay.lms2__Payment_Status__c = 'Paid';
                                        pay.lms2__Estimated_Repayment_Date__c = date.today();
                                        pay.lms2__Additional_Capital_Repaid__c = 0;
                                        pay.lms2__Loan_Account_2__c = null;
                                        pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                        PaymentMade = PaymentMade - (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2);
                                        LRSPaid.add(pay);
                                    } else if (PaymentMade > (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)) {
                                        pay.lms2__Payment_Status__c = 'Paid';
                                        pay.lms2__Estimated_Repayment_Date__c = date.today();
                                        pay.lms2__Additional_Capital_Repaid__c = 0;
                                        pay.lms2__Loan_Account_2__c = null;
                                        pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                        PaymentMade = PaymentMade - (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2);
                                        LRSPaid.add(pay);
                                    }
                                    if(pay.lms2__Remaining__c == 0){
                                        pay.lms2__Closing_Balance__c = 0.00;
                                    }
                                }
                            }
                            update LRepaymentSchedule;
                            Decimal r = 0;
                            Decimal cb = 0;
                            if (PaymentMade != 0) {
                                for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                                    if (pay.lms2__Payment_Status__c == 'Pending' && n == 0) {
                                        Decimal amout = pay.lms2__Payment__c;
                                        r = pay.lms2__Repayment_Number_del__c;
                                        if (r == 60) {
                                            pay.lms2__Payment__c = pay.lms2__Payment__c - PaymentMade;
                                            PaymentMade = PaymentMade - pay.lms2__Payment__c;
                                            cb = pay.lms2__Closing_Balance__c;
                                        }else if(PaymentMade != 0){
                                            if(PaymentMade <= pay.lms2__Payment__c.setScale(2)){
                                                pay.lms2__Payment__c = pay.lms2__Payment__c - PaymentMade;
                                                PaymentMade = 0;
                                                pay.lms2__Closing_Balance__c = pay.lms2__Opening_Balance__c - pay.lms2__Payment__c + pay.lms2__Interest__c;
                                                cb = pay.lms2__Closing_Balance__c;
                                            }else if(PaymentMade < (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)){
                                                //pay.lms2__Payment__c = PaymentMade - pay.lms2__Payment__c;
                                                pay.lms2__Servicing_Fee__c = PaymentMade - pay.lms2__Payment__c;
                                                //PaymentMade - pay.lms2__Payment__c;
                                                pay.lms2__Closing_Balance__c = pay.lms2__Opening_Balance__c - pay.lms2__Payment__c + pay.lms2__Interest__c;
                                                cb = pay.lms2__Closing_Balance__c;
                                            }
                                        }
                                        if(pay.lms2__Remaining__c == 0){
                                        pay.lms2__Closing_Balance__c = 0.00;
                                        }
                                        If (Math.round(pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c) == 0) {
                                            pay.lms2__Payment_Status__c = 'Paid';
                                            pay.lms2__Additional_Capital_Repaid__c = 0;
                                            pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                            pay.lms2__Loan_Account_2__c = null;
                                            LRSPaid.add(pay);
                                        }
                                        n++;
                                    }
                                }
                                update LRepaymentSchedule;
                                calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                                updateFeeAndExpense(LRSPaid, PaymentTrans);
                                return 'success';
                            }
                        }
                    }
                    //If only Last Schedule is to be paid
                    else if (LRepaymentSchedule.size() == 1) {
                        LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                        LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
                        LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                        LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                        LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = 0;
                        LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                        LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                        LRSPaid.add(LRepaymentSchedule[0]);
                        /*LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
                        if(LRepayment.size() > 0){
                            delete LRepayment;
                        }*/

                        update LRepaymentSchedule;
                        calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                        updateFeeAndExpense(LRSPaid, PaymentTrans);
                        return 'success';
                    }
                }

            } catch (Exception e) {
                System.debug(e.getMessage() + ' ' + e.getLineNumber());
                return e.getMessage();
            }
        }
        return null;
    }

    public static String doPaymentForQuote(Payment_Transaction__c PaymentTrans, List<Loan_Repayent_Schedule__c> LRepaymentSchedule, Boolean bool) {
        Decimal opening_Bal, newTerm, serial, newPmt, PMTtobePaid, PMTdifference, newClosingBal, ClosingBal, ROI, PaymentMade, updatedCB, Term, InterestCharged, Fee;
        String paymentCondition = '';
        //set<Id> LRSPaid = new set<Id>();
        List<Loan_Repayent_Schedule__c> LRSPaid = new List<Loan_Repayent_Schedule__c>();
        List<lms2__Loan_Repayment__c> LRepayment = new List<lms2__Loan_Repayment__c>();
        ROI = LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c;
        Term = LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c == null && LRepaymentSchedule[0].lms2__Loan_Account_2__r.lms2__Quote_Calculator__c != null ? LRepaymentSchedule[0].lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c : Decimal.valueOf(LRepaymentSchedule[0].lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c);
        PMTtobePaid = Double.valueOf(LRepaymentSchedule[0].lms2__Payment__c);
        Fee = LRepaymentSchedule[0].lms2__Servicing_Fee__c;
        Decimal PMTtobePaidWithFee = 0;
        PMTtobePaidWithFee = PMTtobePaid;
        String loanAccountId = LRepaymentSchedule[0].lms2__Loan_Account_2__c;

        if(Fee != null){
            PMTtobePaidWithFee = PMTtobePaidWithFee + Fee;
        }
        InterestCharged = Double.valueOf(LRepaymentSchedule[0].lms2__Interest__c);
        opening_Bal = Double.valueOf(LRepaymentSchedule[0].lms2__Opening_Balance__c);
        ClosingBal = Double.valueOf(LRepaymentSchedule[0].lms2__Closing_Balance__c);
        serial = LRepaymentSchedule[0].lms2__Repayment_Number_del__c;
        PaymentMade = PaymentTrans.lms2__Payment_Amount__c;
        //System.debug('LRepaymentSchedule>>>>'+LRepaymentSchedule);
        //System.debug('LRepaymentSchedule>>>>'+LRepaymentSchedule.size());
        //System.debug('PaymentMade>>>>'+PaymentMade);
        // If more than one pending schedule are left
        if (LRepaymentSchedule.size() > 1) {
            if (PaymentMade < InterestCharged) {
                newClosingBal = ClosingBal + (PMTtobePaid - InterestCharged) + (InterestCharged - PaymentMade);
            } else if (PaymentMade == InterestCharged) {
                newClosingBal = ClosingBal + (PMTtobePaid - InterestCharged);
            } else {
                PMTdifference = PaymentMade - ( PMTtobePaid + fee ).setScale(2);
                newClosingBal = ClosingBal - PMTdifference;
            }
            
            //Check here
            if(PMTdifference == 0.00){
                LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                LRepaymentSchedule[0].lms2__Payment__c = PMTtobePaid.setScale(2);
                LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = 0;
                LRepaymentSchedule[0].lms2__Closing_Balance__c = newClosingBal.setScale(2);
                LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = PMTtobePaid;

                LRSPaid.add(LRepaymentSchedule[0]);

                update LRepaymentSchedule;
                calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId );
                updateFeeAndExpense(LRSPaid, PaymentTrans);
                return 'success';
            }else{
                if (bool == false) {
                    if (PMTtobePaidWithFee > PaymentMade) {
                        newTerm = Term - serial ;
                        PMTdifference = PaymentMade - PMTtobePaid.setScale(2);
                        newClosingBal = ClosingBal - PMTdifference;
                        newPmt = calcNewPMT(ROI / 1200, newTerm, -newClosingBal, 0, 0);
                        LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                        LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
                        LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = 0;
                        LRepaymentSchedule[0].lms2__Closing_Balance__c = newClosingBal.setScale(2);
                        LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                        LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                        LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                        LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                        
                        Decimal remainingFee = LRepaymentSchedule[0].lms2__Servicing_Fee__c;
                        Decimal totalPaidAmt = newPmt * newTerm;
                        Decimal closingbalance1;
                        for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                            if (pay.lms2__Repayment_Number_del__c == serial + 1) {
                                Decimal remainingbalance = PMTtobePaidWithFee - PaymentMade;

                                if(remainingbalance <= pay.lms2__Servicing_Fee__c){
                                    pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingbalance;
                                }else if(remainingbalance > remainingFee) {
                                    remainingbalance = remainingbalance - remainingFee;
                                    pay.lms2__Payment__c = pay.lms2__Payment__c + remainingbalance ;
                                    pay.lms2__Loan_Repayment_del__c =  pay.lms2__Payment__c  ;
                                    pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingFee;
                                }else if(remainingbalance == remainingFee){
                                    pay.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c + remainingFee;
                                }
                                pay.lms2__Opening_Balance__c = newClosingBal.setScale(2);
                                newClosingBal = closingbalance1;
                                if(pay.lms2__Remaining__c == 0){
                                    pay.lms2__Closing_Balance__c = 0.00;
                                }
                            }
                            //newClosingBal = closingbalance1;
                        }
                        LRSPaid.add(LRepaymentSchedule[0]);
                       /* LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
                        if(LRepayment.size() > 0){
                            delete LRepayment;
                        }*/
                        update LRepaymentSchedule;
                        calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                        updateFeeAndExpense(LRSPaid, PaymentTrans);
                        return 'success';
                    }
                    //When user pays more than the requested Amount and opts for Pay Principal
                    else {
                        System.debug('More');
                        newTerm = Term - serial ;
                       
                        Decimal newOpeningValue = newClosingBal;
                        newPmt = calcNewPMT(ROI / 1200, newTerm, -newClosingBal, 0, 1);
                        if(newPmt < 0){
                            return 'Please Use Different Payment Method';
                        }
                        LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = LRepaymentSchedule[0].lms2__Payment__c;
                        LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = PaymentMade - PMTtobePaidWithFee;
                        LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
                        LRepaymentSchedule[0].lms2__Closing_Balance__c = newClosingBal.setScale(2);
                        LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
                        LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
                        LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
                        LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
                        LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = PMTtobePaid;
                        LRSPaid.add(LRepaymentSchedule[0]);

                        Decimal totalPaidAmt = newPmt * newTerm;
                        
                        Decimal closingbalance1;
                        Decimal totalInterest = totalPaidAmt - newClosingBal;
                        
                        for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                            if (pay.lms2__Repayment_Number_del__c != serial) {
                                Decimal InterestMonthly = totalInterest / newTerm;
                                Decimal principal = newPmt - InterestMonthly;
                                closingbalance1 = newClosingBal - principal;
                                pay.lms2__Opening_Balance__c = newClosingBal.setScale(2);
                                closingBal = newClosingBal.setScale(2);
                                pay.lms2__Interest__c = InterestMonthly.setScale(2);
                                pay.lms2__Capital_Repaid_del__c = principal.setScale(2);
                                pay.lms2__Payment__c = newPmt.setScale(2);
                                pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                pay.lms2__Closing_Balance__c = closingbalance1.setScale(2);
                                newClosingBal = closingbalance1;
                                if(pay.lms2__Remaining__c == 0){
                                    pay.lms2__Closing_Balance__c = 0.00;
                                }
                            }
                        }
                        /*LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
                        if(LRepayment.size() > 0){
                            delete LRepayment;
                        }*/
                        update LRepaymentSchedule;
                        createNewLoanRepaymentSchedule(PaymentTrans, newOpeningValue, newTerm);
                        calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                        updateFeeAndExpense(LRSPaid, PaymentTrans);

                        return 'success';
                    }
                }
                //When user pays more than the requested Amount and opts for Pay Further Schedule
                else {
                    System.debug('Pay with schedule');
                    Integer paymentYears, n;
                    n = 0;
                    Decimal remBalance;
                    Double PaidMoney;
                    PaidMoney = PaymentMade;

                    for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                        if (pay.lms2__Payment_Status__c == 'Pending'){
                            if (PaymentMade == (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)) {
                                pay.lms2__Payment_Status__c = 'Paid';
                                pay.lms2__Loan_Account_2__c = null;
                                pay.lms2__Estimated_Repayment_Date__c = date.today();
                                pay.lms2__Additional_Capital_Repaid__c = 0;
                                pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                PaymentMade = PaymentMade - (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2);
                                LRSPaid.add(pay);
                            } else if (PaymentMade > (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)) {
                                pay.lms2__Payment_Status__c = 'Paid';
                                pay.lms2__Estimated_Repayment_Date__c = date.today();
                                pay.lms2__Additional_Capital_Repaid__c = 0;
                                pay.lms2__Loan_Account_2__c = null;
                                pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                PaymentMade = PaymentMade - (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2);
                                LRSPaid.add(pay);
                            }
                            if(pay.lms2__Remaining__c == 0){
                                pay.lms2__Closing_Balance__c = 0.00;
                            }
                        }
                    }
                    update LRepaymentSchedule;
                    Decimal r = 0;
                    Decimal cb = 0;
                    if (PaymentMade != 0) {
                        for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                            if (pay.lms2__Payment_Status__c == 'Pending' && n == 0) {

                                r = pay.lms2__Repayment_Number_del__c;
                                if (r == 60) {
                                    pay.lms2__Payment__c = pay.lms2__Payment__c - PaymentMade;
                                    PaymentMade = PaymentMade - pay.lms2__Payment__c;
                                    cb = pay.lms2__Closing_Balance__c;
                                }else if(PaymentMade != 0){
                                    if(PaymentMade <= pay.lms2__Payment__c.setScale(2)){
                                        pay.lms2__Payment__c = pay.lms2__Payment__c - PaymentMade;
                                        pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                        PaymentMade = 0;
                                        pay.lms2__Closing_Balance__c = pay.lms2__Opening_Balance__c - pay.lms2__Payment__c + pay.lms2__Interest__c;
                                        cb = pay.lms2__Closing_Balance__c;
                                    }else if(PaymentMade < (pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c).setScale(2)){
                                        //pay.lms2__Payment__c = PaymentMade - pay.lms2__Payment__c;
                                        pay.lms2__Servicing_Fee__c = PaymentMade - pay.lms2__Payment__c;
                                        //PaymentMade - pay.lms2__Payment__c;
                                        pay.lms2__Closing_Balance__c = pay.lms2__Opening_Balance__c - pay.lms2__Payment__c + pay.lms2__Interest__c;
                                        cb = pay.lms2__Closing_Balance__c;
                                    }
                                }
                                if(pay.lms2__Remaining__c == 0){
                                    pay.lms2__Closing_Balance__c = 0.00;
                                }
                                If (Math.round(pay.lms2__Payment__c + pay.lms2__Servicing_Fee__c) == 0) {
                                    pay.lms2__Payment_Status__c = 'Paid';
                                    pay.lms2__Loan_Repayment_del__c = pay.lms2__Payment__c;
                                    pay.lms2__Additional_Capital_Repaid__c = 0;
                                    pay.lms2__Loan_Account_2__c = null;
                                    LRSPaid.add(pay);
                                }
                                n++;
                            }
                        }
                        update LRepaymentSchedule;
                        calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
                        updateFeeAndExpense(LRSPaid, PaymentTrans);

                        return 'success';
                    }
                }
            }

        }
        //If only Last Schedule is to be paid
        else if (LRepaymentSchedule.size() == 1) {
            LRepaymentSchedule[0].lms2__Payment__c = PaymentMade.setScale(2);
            LRepaymentSchedule[0].lms2__Payment_Status__c = 'Paid';
            LRepaymentSchedule[0].lms2__Estimated_Repayment_Date__c = date.today();
            LRepaymentSchedule[0].lms2__Additional_Capital_Repaid__c = 0;
            LRepaymentSchedule[0].lms2__Closing_Balance__c = 0;
            LRepaymentSchedule[0].lms2__Payment_Transaction__c = PaymentTrans.Id;
            LRepaymentSchedule[0].lms2__Loan_Account_2__c = null;
            LRepaymentSchedule[0].lms2__Loan_Repayment_del__c = PMTtobePaid;
            LRSPaid.add(LRepaymentSchedule[0]);
           /* LRepayment = [Select Id, Name from lms2__Loan_Repayment__c where  lms2__Loan_Repayment_Schedule__c IN:LRSPaid];//(new)
            if(LRepayment.size() > 0){
                delete LRepayment;
            }*/

            update LRepaymentSchedule;
            calculateOutStandingAmount(PaymentTrans, LRSPaid,loanAccountId);
            updateFeeAndExpense(LRSPaid, PaymentTrans);

            return 'success';
        }
        return null;
    }
    public static void updateFeeAndExpense(List<Loan_Repayent_Schedule__c> LRSPaid, Payment_Transaction__c PaymentTrans){
        List<lms2__Loan_Repayent_Schedule__c> LRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
                LRepaymentSchedule = [
                        Select Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c,lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c,lms2__Closing_Balance__c,
                                lms2__Estimated_Repayment_Date__c,
                                lms2__Interest__c,
                                lms2__Loan_Account_2__c,
                                lms2__Loan_Account_2__r.lms2__Quote_Calculator__c,
                                lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c,
                                lms2__Payment__c,
                                lms2__Loan_Application_Number__c,
                                lms2__Loan_Repayment_del__c,
                                lms2__Loan_Repayment_Option__c,
                                lms2__Opening_Balance__c,
                                lms2__Payment_Status__c,
                                lms2__Repayment_Number_del__c,
                                lms2__Remaining__c,
                                lms2__Servicing_Fee__c
                        from lms2__Loan_Repayent_Schedule__c
                        where lms2__Loan_Application_Number__c = :PaymentTrans.lms2__Loan_Account_No__c and lms2__Payment_Status__c = 'Pending'
                        AND lms2__Loan_Repayment_Option__r.lms2__Active__c = true
                        order by lms2__Repayment_Number_del__c asc
                ];
        
        List<Fee_Expense__c> FeeList = new List<Fee_Expense__c>();
        FeeList = [Select Id, lms2__Loan_Repayment_Schedule__r.lms2__Servicing_Fee__c from Fee_Expense__c where lms2__Loan_Repayment_Schedule__c IN:LRepaymentSchedule ];
        for (Fee_Expense__c MA : FeeList) {
           // MA.lms2__Value__c = MA.lms2__Loan_Repayment_Schedule__r.lms2__Servicing_Fee__c;
        }
        update FeeList;        

    }
    public static void calculateOutStandingAmount(Payment_Transaction__c PaymentTrans, List<Loan_Repayent_Schedule__c> LRSPaid, String loanAccountId){//(new) Counting outstanding Amounts here
        if(PaymentTrans != null){
            List<lms2__Loan_Repayent_Schedule__c> LRepaymentSchedule = new List<Loan_Repayent_Schedule__c>();
            LRepaymentSchedule = [
                    Select Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c,lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c,lms2__Closing_Balance__c,
                            lms2__Estimated_Repayment_Date__c,
                            lms2__Interest__c,
                            lms2__Loan_Account_2__c,
                            lms2__Loan_Account_2__r.lms2__Quote_Calculator__c,
                            lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c,
                            lms2__Payment__c,
                            lms2__Loan_Application_Number__c,
                            lms2__Loan_Repayment_del__c,
                            lms2__Loan_Repayment_Option__c,
                            lms2__Opening_Balance__c,
                            lms2__Payment_Status__c,
                            lms2__Repayment_Number_del__c,
                            lms2__Remaining__c,
                            lms2__Servicing_Fee__c
                    from lms2__Loan_Repayent_Schedule__c
                    where lms2__Loan_Application_Number__c = :PaymentTrans.lms2__Loan_Account_No__c and lms2__Payment_Status__c = 'Pending'
                    AND lms2__Loan_Repayment_Option__r.lms2__Active__c = true
                    order by lms2__Repayment_Number_del__c asc
            ];
            if(LRepaymentSchedule.size() > 0){
                Decimal OutstagingAmount = 0;
                Decimal CapitalOutstagingAmount = 0;
                Decimal interest = 0;

                for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                    OutstagingAmount = OutstagingAmount + pay.lms2__Payment__c;
                    interest = interest + pay.lms2__Interest__c;
                }
                

                CapitalOutstagingAmount = OutstagingAmount - interest;

                List<lms2__Loan__c> LoanList = new List<lms2__Loan__c>();
                List<lms2__Loan_Repayment_Option__c> LoanROption = new List<lms2__Loan_Repayment_Option__c>();
                if(LRepaymentSchedule[0].lms2__Loan_Account_2__c != null){
                    LoanList = [Select Id, Name, lms2__Outstanding_Amount__c from lms2__Loan__c where Id =: LRepaymentSchedule[0].lms2__Loan_Account_2__c];
                    if (OutstagingAmount != null) {
                        LoanList[0].lms2__Outstanding_Amount__c = OutstagingAmount;
                    }
                    update LoanList;
                }
                if(LRepaymentSchedule[0].lms2__Loan_Repayment_Option__c != null){
                    LoanROption = [select lms2__Capital_Outstanding__c	 from lms2__Loan_Repayment_Option__c where Id =: LRepaymentSchedule[0].lms2__Loan_Repayment_Option__c];
                    if(CapitalOutstagingAmount >= 0 ){
                        LoanROption[0].lms2__Capital_Outstanding__c = CapitalOutstagingAmount;
                    }
                    
                    update LoanROption;
                }
                
            }
        }
        if (LRSPaid.size() > 0) {
            List<lms2__Loan_Repayment__c> LoanRS_To_Return_List = new List<lms2__Loan_Repayment__c>();
           
            for (Loan_Repayent_Schedule__c MA : LRSPaid) {
                lms2__Loan_Repayment__c LoanRS_To_Return = new lms2__Loan_Repayment__c ();
                LoanRS_To_Return.lms2__Payment_Status__c = 'Paid';
                LoanRS_To_Return.lms2__Loan_Repayment_Schedule__c = MA.Id;
                LoanRS_To_Return.lms2__Loan_Repayment_Option__c = LRSPaid[0].lms2__Loan_Repayment_Option__c;
                LoanRS_To_Return.lms2__Loan_Account_2__c = loanAccountId;
                LoanRS_To_Return.lms2__Payment_Date__c = system.today();

                if (MA.lms2__Capitalized_cost_del__c != NULL) {
                    LoanRS_To_Return.lms2__Capitalized_cost__c = MA.lms2__Capitalized_cost_del__c;
                }
                

                Decimal PMTtobePaid = MA.lms2__Loan_Repayment_del__c + MA.lms2__Servicing_Fee__c;
                Decimal PaymentMade =  MA.lms2__Payment__c;

                if(PMTtobePaid > PaymentMade){
                    Decimal PaymentDiff = PMTtobePaid - PaymentMade;

                   if(PaymentDiff < MA.lms2__Servicing_Fee__c){
                        PaymentDiff = MA.lms2__Servicing_Fee__c - PaymentDiff;
                        LoanRS_To_Return.lms2__Servicing_Fee__c = PaymentDiff;
                    }else if(PaymentDiff > MA.lms2__Servicing_Fee__c) {
                        PaymentDiff = MA.lms2__Servicing_Fee__c;
                        LoanRS_To_Return.lms2__Servicing_Fee__c = PaymentDiff;
                    }else if(PaymentDiff == MA.lms2__Servicing_Fee__c){
                        LoanRS_To_Return.lms2__Servicing_Fee__c = PaymentDiff;
                    } 
                }else{
                    if (MA.lms2__Servicing_Fee__c != NULL) {
                    LoanRS_To_Return.lms2__Servicing_Fee__c = MA.lms2__Servicing_Fee__c;
                    }
                }
                

                

               

                if (MA.lms2__Capital_Outstanding_del__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Outstanding__c = MA.lms2__Capital_Outstanding_del__c;
                }
                if (MA.lms2__Additional_Capital_Repaid__c != NULL) {
                    LoanRS_To_Return.lms2__Capital_Repaid__c = MA.lms2__Additional_Capital_Repaid__c;
                }
                if (MA.lms2__Closing_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Closing_Balance__c = MA.lms2__Closing_Balance__c;
                }
                if (MA.lms2__Fixed_Monthly_Repayments_del__c != NULL) {
                    LoanRS_To_Return.lms2__Fixed_Monthly_Repayments__c = MA.lms2__Fixed_Monthly_Repayments_del__c;
                }
                if (MA.lms2__Interest__c != NULL) {
                    LoanRS_To_Return.lms2__Interest__c = MA.lms2__Interest__c;
                }
                if (MA.lms2__Lease_price_del__c != NULL) {
                    LoanRS_To_Return.lms2__Lease_price__c = MA.lms2__Lease_price_del__c;
                }
                if (MA.lms2__Payment__c != NULL) {
                    LoanRS_To_Return.lms2__Payment__c = MA.lms2__Payment__c;
                }
                if (MA.lms2__Loan_Repayment_del__c != NULL) {
                    LoanRS_To_Return.lms2__Loan_Repayment__c = MA.lms2__Loan_Repayment_del__c;
                }
                if (MA.lms2__Monthly_depreciation_fee_del__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_depreciation_fee__c = MA.lms2__Monthly_depreciation_fee_del__c;
                }
                if (MA.lms2__Monthly_lease_fee_del__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_lease_fee__c = MA.lms2__Monthly_lease_fee_del__c;
                }
                if (MA.lms2__Monthly_payment_del__c != NULL) {
                    LoanRS_To_Return.lms2__Monthly_payment__c = MA.lms2__Monthly_payment_del__c;
                }
                if (MA.lms2__Montlhy_sales_tax_payment_del__c != NULL) {
                    LoanRS_To_Return.lms2__Montlhy_sales_tax_payment__c = MA.lms2__Montlhy_sales_tax_payment_del__c;
                }
                if (MA.lms2__Opening_Balance__c != NULL) {
                    LoanRS_To_Return.lms2__Opening_Balance__c = MA.lms2__Opening_Balance__c;
                }
                if (MA.lms2__Pre_tax_montlhy_payment_del__c != NULL) {
                    LoanRS_To_Return.lms2__Pre_tax_montlhy_payment__c = MA.lms2__Pre_tax_montlhy_payment_del__c;
                }
                if (MA.lms2__Repayment_Number_del__c != NULL) {
                    LoanRS_To_Return.lms2__Repayment_Number__c = MA.lms2__Repayment_Number_del__c;
                        if(MA.lms2__Estimated_Repayment_Date__c != null){
                        LoanRS_To_Return.lms2__Estimated_Repayment_Date__c = MA.lms2__Estimated_Repayment_Date__c;
                        }
                }
                if (MA.lms2__Residual_value_del__c != NULL) {
                    LoanRS_To_Return.lms2__Residual_value__c = MA.lms2__Residual_value_del__c;
                }

                LoanRS_To_Return_List.add(LoanRS_To_Return);
            }
            insert LoanRS_To_Return_List;
        }
    }

    public static void createNewLoanRepaymentSchedule(lms2__Payment_Transaction__c PaymentTrans, Decimal newClosingBal, Decimal newTerm){//(new) Counting outstanding Amounts here
        if(PaymentTrans != null){
            String paymentOptionId = PaymentTrans.lms2__Loan_Repayment_Option__c;
            
            List<lms2__Loan_Repayment_Option__c> options = new List<lms2__Loan_Repayment_Option__c>();
            Map<String, Schema.SObjectField> mapoptionsFields = Schema.SObjectType.lms2__Loan_Repayment_Option__c.fields.getMap();
            Set<String> All_Option_Fields = mapoptionsFields.keySet();
            String Fieldz_To_Query_Option = 'Select ';
            for (String Fld : All_Option_Fields) {
                Fieldz_To_Query_Option += mapoptionsFields.get(Fld) + ',';
            }
            Fieldz_To_Query_Option = Fieldz_To_Query_Option.removeEnd(',');
            Fieldz_To_Query_Option += ' ' + 'From lms2__Loan_Repayment_Option__c Where Id =: paymentOptionId AND lms2__Active__c = true Order By CreatedDate DESC Limit 1 ';
            options = Database.Query(Fieldz_To_Query_Option);
            List<Fee_Expense__c> PaidLRSFee = new List<Fee_Expense__c>();
            List<Fee_Expense__c> PaidLRSFeeNew = new List<Fee_Expense__c>();
            List<lms2__Loan_Repayent_Schedule__c> PaidLRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
            List<lms2__Loan_Repayent_Schedule__c> PaidLRepaymentSch = new List<lms2__Loan_Repayent_Schedule__c>();
            if(options.size() > 0){
                for (lms2__Loan_Repayment_Option__c option: options){
                    option.lms2__Active__c = false;
                }
                update options;
                lms2__Loan_Repayment_Option__c option = new lms2__Loan_Repayment_Option__c();
                option = options[0];
                option.Id = null;
                option.lms2__New_Loan_Amount__c = newClosingBal.setScale(2);
                option.lms2__New_Loan_Term_Years__c = String.valueOf(newTerm);
                option.lms2__Active__c = true;
                upsert option;
                Decimal Repayment = 0;
                if(option.Id != null ){
                    List<lms2__Loan_Repayent_Schedule__c> LRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
                    
                    LRepaymentSchedule = [
                            Select Id, Name,lms2__Loan_Repayment_Option__r.lms2__New_Loan_Term_Years__c,lms2__Loan_Repayment_Option__r.lms2__Intrest_Rate_on_new_Loan__c,lms2__Closing_Balance__c,
                                    lms2__Estimated_Repayment_Date__c,
                                    lms2__Interest__c,
                                    lms2__Loan_Account_2__c,
                                    lms2__Loan_Account_2__r.lms2__Quote_Calculator__c,
                                    lms2__Loan_Account_2__r.lms2__Term_of_Loan_N__c,
                                    lms2__Payment__c,
                                    lms2__Loan_Application_Number__c,
                                    lms2__Loan_Repayment_del__c,
                                    lms2__Loan_Repayment_Option__c,
                                    lms2__Opening_Balance__c,
                                    lms2__Payment_Status__c,
                                    lms2__Repayment_Number_del__c,
                                    lms2__Remaining__c,
                                    lms2__Servicing_Fee__c,
                                    lms2__Capital_Repaid_del__c,
                                    lms2__Payment_Date__c,
                                    lms2__Principal__c
                            from lms2__Loan_Repayent_Schedule__c
                            where lms2__Loan_Application_Number__c =: PaymentTrans.lms2__Loan_Account_No__c and lms2__Payment_Status__c = 'Pending'
                            AND lms2__Loan_Repayment_Option__c =: paymentOptionId
                            order by lms2__Repayment_Number_del__c asc

                    ];
                    
                    if(LRepaymentSchedule.size() > 0){
                        Integer i = 1;
                        Integer n = LRepaymentSchedule.size();
                        n = n-1;
                        List<lms2__Loan_Repayent_Schedule__c> newSchedules = new List<lms2__Loan_Repayent_Schedule__c>();
                        List<lms2__Loan_Repayent_Schedule__c> OldSchedules = new List<lms2__Loan_Repayent_Schedule__c>();
                        for (lms2__Loan_Repayent_Schedule__c pay : LRepaymentSchedule) {
                            lms2__Loan_Repayent_Schedule__c scheduleObj = new lms2__Loan_Repayent_Schedule__c();
                            scheduleObj.lms2__Repayment_Number_del__c = i;
                            scheduleObj.lms2__Opening_Balance__c = pay.lms2__Opening_Balance__c;
                            scheduleObj.lms2__Interest__c = pay.lms2__Interest__c;
                            scheduleObj.lms2__Capital_Repaid_del__c = pay.lms2__Capital_Repaid_del__c;
                            scheduleObj.lms2__Payment__c = pay.lms2__Payment__c;
                            scheduleObj.lms2__Closing_Balance__c = pay.lms2__Closing_Balance__c;
                            scheduleObj.lms2__Servicing_Fee__c = pay.lms2__Servicing_Fee__c;
                            scheduleObj.lms2__Loan_Repayment_Option__c = option.Id;
                            scheduleObj.lms2__Payment_Status__c = pay.lms2__Payment_Status__c;
                            scheduleObj.lms2__Estimated_Repayment_Date__c = pay.lms2__Estimated_Repayment_Date__c;
                            scheduleObj.lms2__Loan_Account_2__c = pay.lms2__Loan_Account_2__c;
                            scheduleObj.lms2__Principal__c = pay.lms2__Principal__c;
                            scheduleObj.lms2__Remaining__c = n--;
                            Repayment = Repayment + pay.lms2__Interest__c;
                            i++;
                            newSchedules.add(scheduleObj);
                        }
                        if (Repayment != null) {
                            option.lms2__Loan_Repayment__c = Repayment;
                            update option;
                        }
                        
                        if(newSchedules.size() > 0){
                            upsert newSchedules;
                        }
                    }
                }
                PaidLRepaymentSchedule = [
                        Select Id,
                        lms2__Loan_Account_2__c
                        from lms2__Loan_Repayent_Schedule__c
                        where lms2__Loan_Application_Number__c = :PaymentTrans.lms2__Loan_Account_No__c
                        AND lms2__Loan_Repayment_Option__c = :paymentOptionId
                ];
                PaidLRSFee = [Select Id, lms2__Loan__c from lms2__Fee_Expense__c where lms2__Loan_Repayment_Schedule__c IN:PaidLRepaymentSchedule];
                if (PaidLRepaymentSchedule.size() > 0) {
                    for (lms2__Loan_Repayent_Schedule__c paid : PaidLRepaymentSchedule) {
                        paid.lms2__Loan_Account_2__c = null;
                        PaidLRepaymentSch.add(paid);
                    }

                }
                if(PaidLRSFee.size() > 0){
                     for (Fee_Expense__c paid : PaidLRSFee) {
                        paid.lms2__Loan__c = null;
                        PaidLRSFeeNew.add(paid);
                    }
                }
                update PaidLRepaymentSch;
                update PaidLRSFeeNew;
            }
            List<lms2__Loan_Repayent_Schedule__c> NewLRepaymentSchedule = new List<lms2__Loan_Repayent_Schedule__c>();
                NewLRepaymentSchedule = [
                        Select Id, 
                        lms2__Servicing_Fee__c,
                        lms2__Loan_Account_2__c,
                        lms2__Loan_Repayment_Option__c,
                        lms2__Loan_Account_2__r.lms2__Quote_Calculator__c
                        from lms2__Loan_Repayent_Schedule__c
                        where lms2__Loan_Application_Number__c = :PaymentTrans.lms2__Loan_Account_No__c and lms2__Payment_Status__c = 'Pending'
                        AND lms2__Loan_Repayment_Option__r.lms2__Active__c = true
                        order by lms2__Repayment_Number_del__c asc
                ];
                List<Fee_Expense__c> NewFeeAndExpList = new List<Fee_Expense__c>();
            for(lms2__Loan_Repayent_Schedule__c LRS : NewLRepaymentSchedule){
                 
                Fee_Expense__c fee = new Fee_Expense__c();
                fee.lms2__Mode__c = 'Amount';
                fee.lms2__Type_of_Fees__c = 'Loan Facilitation Fee';
                fee.lms2__Fee_or_Expense__c = 'Fee';
                fee.lms2__Charge_To__c = 'Customer';
                fee.lms2__Fee_Frequency__c = 'Monthly';
                fee.Loan_Repayment_Schedule__c = LRS.Id;
                fee.Quote_Calculator__c = LRS.lms2__Loan_Account_2__r.lms2__Quote_Calculator__c;
                fee.lms2__Loan__c = LRS.lms2__Loan_Account_2__c;
                fee.lms2__Loan_Repayment_Option__c = LRS.lms2__Loan_Repayment_Option__c;
                //fee.Value__c = LRS.lms2__Servicing_Fee__c;
                NewFeeAndExpList.add(fee);
            }
            insert NewFeeAndExpList; 
        }
    }
    @AuraEnabled
    public static Decimal calcNewPMT(Decimal rate, Decimal nperiod, Decimal pv, Decimal fv, Integer LoanType) {
       
        if (rate == 0) {
            return -(pv + fv) / nperiod;
        }
        Decimal temp1 = 1 + rate;
        Decimal pvif = temp1.pow(Integer.valueOf(nperiod));
        Decimal pmt = rate / (pvif - 1) * -(pv * pvif + fv);
        if (LoanType == 1) {
            pmt /= (1 + rate);
        }
        return pmt;
    }

    public class Payment_Schedule_List_Wrapper {

        @AuraEnabled public String Name;
        @AuraEnabled public Decimal Closing_Balance;
        @AuraEnabled public String Loan_Period;
        @AuraEnabled public Decimal Interest_Rate;
        @AuraEnabled public Date Repayment_Date;
        @AuraEnabled public Decimal Interest;
        @AuraEnabled public Decimal Payment;
        @AuraEnabled public String Loan_Application_Number;
        @AuraEnabled public Decimal Loan_Repayment;
        @AuraEnabled public String Loan_Repayment_Option;
        @AuraEnabled public Decimal Opening_Balance;
        @AuraEnabled public String Payment_Status;
        @AuraEnabled public Decimal Remaining;
        @AuraEnabled public Decimal Repayment_Number;
        @AuraEnabled public Boolean PendingPayment;
        @AuraEnabled public String Loan;
        @AuraEnabled public Decimal ServicingAmount;

    }
}