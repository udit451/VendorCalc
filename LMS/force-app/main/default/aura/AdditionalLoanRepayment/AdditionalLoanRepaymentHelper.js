({
	doInit_helper : function(c,e,h) {
		var calculator = {};
		calculator.LoanAmmount = undefined;
		calculator.InterestRate = undefined;
		calculator.LoanTerm = undefined;
		c.set('v.calculator',calculator);
		console.log('opp ID--->'+c.get('v.recordIdMenu'));
	},
	calculate_helper:function(c,e,h){
	    try{
	        var calValue = c.get('v.calculator');
	        if(!$A.util.isUndefinedOrNull(calValue)){
	            console.log(JSON.stringify(calValue));
	            h.calculatePMT(c,e,h,calValue,0,0);
	        }
	    }catch(ex){
	        console.log('Error');
	        console.log(ex);
	    }
	},

    calculatePMT: function (c, e, h ,calValue,fv, type) {
        var ir = calValue.InterestRate;
        var pv = calValue.LoanAmmount;
        var np = calValue.LoanTerm;
        var self = this;
        /*
         * * ir - interest rate per month np - number of periods (months) pv -
         * present value * fv - future value type - when the payments are due:
         * 0: end of the period, e.g. end of month (default) 1: beginning of
         * period
         */
        var pmt = 0.00;
        var fixedPmt = 0.0;
        var newPmt = 0.00;
        var fixedNewPmt = 0.00;
        var loanTypeCheckbox = 'Variable';
        var repaymentFrequencyCheckbox = 'Monthly';
        var repaymentTypeCheckbox = 'Principal';
        var newIr = 0;
        var fixedTerm;
        var fixedRate;
        var totalPossibleNumberOfRepayments = 0;
        var totalVariableNumberOfRepayments = 0;
        var totalFixedNumberOfRepayments = 0;

        if (repaymentFrequencyCheckbox == 'Monthly') {
            newIr = newIr / 1200;
            ir = ir / 1200;
            np = np * 12;
        } else if (repaymentFrequencyCheckbox == 'Fortnightly') {
            newIr = newIr / 2600;
            ir = ir / 2600;
            np = np * 26;
        } else if (repaymentFrequencyCheckbox == 'Weekly') {
            newIr = newIr / 5200;
            ir = ir / 5200;
            np = np * 52;
        }
        totalPossibleNumberOfRepayments = np;
        pv = -pv;

        if (loanTypeCheckbox == 'Variable') {
            if (repaymentTypeCheckbox == 'Principal') {
                if (ir === 0) {
                    pmt = -(pv + fv) / np;
                } else {
                    var pvif = Math.pow(1 + ir, np);
                    pmt = -parseFloat(ir) * parseFloat(pv) * parseFloat((pvif + fv)) / (pvif - 1);
                    if (type === 1) {
                        pmt /= (1 + ir);
                    }
                }
                if (newIr === 0) {
                    newPmt = -(pv + fv) / np;
                } else {
                    var pvif = Math.pow(1 + newIr, np);
                    newPmt = -parseFloat(newIr) * parseFloat(pv) * parseFloat((pvif + fv)) / (pvif - 1);
                    if (type === 1) {
                        newPmt /= (1 + newIr);
                    }
                }
            }
            totalVariableNumberOfRepayments = np;

            // finalongoingPMT = pmt;
        }
         console.log('-->>PMT='+pmt);
         console.log('-->>New PMT='+newPmt);
        var monthlyDifference = newPmt - pmt;
         console.log('-->>Monthly Difference='+monthlyDifference);


        /*c.set("v.MonthlyMortgageRepayment", pmt);
        c.set("v.MonthlyMortgageRepaymentAtNormal", pmt);
        c.set("v.MonthlyMortgageRepaymentAtSensitivity", isNaN(newPmt) ? '0.00' : newPmt);
        c.set("v.MonthlyDifference", isNaN(monthlyDifference) ? '0.00' : monthlyDifference);*/


        var totalMortgageRepaymentOverLoanPeriodValue;

        if (repaymentFrequencyCheckbox == 'Monthly') {
            totalMortgageRepaymentOverLoanPeriodValue = pmt * 12 * np;
        }

        var totalInterestOverMortgagePeriodValue = totalMortgageRepaymentOverLoanPeriodValue - pv;


        var netDisposableIncomeValue = c.get("v.netDisposableIncomeObject.MortgageCalc__Net_Disposable_Income__c");


        var maximumMortgageQualificationAmountValue = 0.00;
        for (var i = 1; i <= np; i++) {
            maximumMortgageQualificationAmountValue += netDisposableIncomeValue / Math.pow((1 + ir), i);
        }


        var minimumRequiredNetDisposableIncomeValue = Math.round(pmt);


        var interestRateSafetyValue = 0;
        if (netDisposableIncomeValue == 0) {
            interestRateSafetyValue = 'no NDI';
           // c.set("v.InterestRateSafetyNoNDI", true);
        } else {
            var FINANCIAL_MAX_ITERATIONS = 128;
            var FINANCIAL_PRECISION = 1.0e-08;
            var type = 0;
            var guess = 0.1;
            var rate = guess;
            var nper = np;
            var pmtNetDisposable = netDisposableIncomeValue;
            var pv = -pv;
            var y;
            var fv = 0.0;
            var f;
            var y0;
            var y1;
            var i;
            var x1;
            var x0;


            if (Math.abs(rate) < FINANCIAL_PRECISION) {
                y = pv * (1 + nper * rate) + pmtNetDisposable * (1 + rate * type) * nper + fv;
            } else {
                f = Math.exp(nper * Math.log(1 + rate));
                y = pv * f + pmtNetDisposable * (1 / rate + type) * (f - 1) + fv;
            }
            y0 = pv + pmtNetDisposable * nper + fv;
            y1 = pv * f + pmtNetDisposable * (1 / rate + type) * (f - 1) + fv;

            // find root by secant method
            i = x0 = 0.0;
            x1 = rate;
            while ((Math.abs(y0 - y1) > FINANCIAL_PRECISION) && (i < FINANCIAL_MAX_ITERATIONS)) {
                rate = (y1 * x0 - y0 * x1) / (y1 - y0);
                x0 = x1;
                x1 = rate;

                if (Math.abs(rate) < FINANCIAL_PRECISION) {
                    y = pv * (1 + nper * rate) + pmtNetDisposable * (1 + rate * type) * nper + fv;
                } else {
                    f = Math.exp(nper * Math.log(1 + rate));
                    y = pv * f + pmtNetDisposable * (1 / rate + type) * (f - 1) + fv;
                }

                y0 = y1;
                y1 = y;
                ++i;
            }
            // console.log('-->>rate='+rate);
            interestRateSafetyValue = ((rate * 12) - (((calValue.InterestRate/100) * 100) / 100)) * 100;

        }


        var increasedInstalmentRepaymentAmount = pmt ;

        var adjustedMortgageRepaymentPeriodInMonths;
        var irForAdjustedMortgageRepaymentPeriodInMonths = (calValue.InterestRate/100) * 100;
        if (irForAdjustedMortgageRepaymentPeriodInMonths != 0) {
            irForAdjustedMortgageRepaymentPeriodInMonths = irForAdjustedMortgageRepaymentPeriodInMonths / 1200;
        }

        // console.log('-->>irForAdjustedMortgageRepaymentPeriodInMonths='+irForAdjustedMortgageRepaymentPeriodInMonths);
        adjustedMortgageRepaymentPeriodInMonths = Math.log((increasedInstalmentRepaymentAmount) / (increasedInstalmentRepaymentAmount + irForAdjustedMortgageRepaymentPeriodInMonths * (-pv))) / Math.log(1 + irForAdjustedMortgageRepaymentPeriodInMonths);
        adjustedMortgageRepaymentPeriodInMonths = isNaN(adjustedMortgageRepaymentPeriodInMonths) ? '0.00' : adjustedMortgageRepaymentPeriodInMonths;

        var adjustedMortgageRepaymentPeriodInYears = adjustedMortgageRepaymentPeriodInMonths / 12;
        adjustedMortgageRepaymentPeriodInYears = isNaN(adjustedMortgageRepaymentPeriodInYears) ? '0.00' : adjustedMortgageRepaymentPeriodInYears;



        var now = new Date();
        var chartArray1 = [];
        var chartArray2 = [];

        var openingBalanceMonthAmort = pv;
        var charactersInMainBalance = (openingBalanceMonthAmort / 10).toString().length;
        // console.log('1.charactersInMainBalance='+charactersInMainBalance);
        charactersInMainBalance = Math.pow(10, charactersInMainBalance);
        //console.log('-->>PMT='+pmt);
        var mortgageRepaymentMonthAmort = pmt;
        //console.log('-->>mortgageRepaymentMonthAmort='+mortgageRepaymentMonthAmort);
        var interestRateMonthAmort = (calValue.InterestRate/100) * 100;
        var mainInterestRateMonthAmort = (calValue.InterestRate/100) * 100;
        var interestChargedMonthAmort = openingBalanceMonthAmort * interestRateMonthAmort / 1200;
        var capitalRepaidMonthAmort = mortgageRepaymentMonthAmort - interestChargedMonthAmort;
        var closingbalanceMonthAmort;

        var totalMortgageRepaymentOverLoanPeriodValueLeft = totalMortgageRepaymentOverLoanPeriodValue;

        var loanTypeCheckboxValidate = 'Variable';
        var fixedTermElementVal = 0;
        var fixedRateElementVal = 0;


        var newPmtAfterFixed = 0;
        var newPvAfterFixed = 0;

        var i = 0;
        var isFixedSet = false;

        // var monthAmortListToInsertHelper = c.get("v.monthAmortListToInsert");
        var monthAmortListToInsertHelper = [];
        var startOpeningBalance = openingBalanceMonthAmort;

        // c.set("v.FixedMonthlyRepayments", fixedPmt);

        var interestArray1 = [];
        var LoopCount = 0;

        var newTotalMortgageRepaymentOverLoanPeriodValue = 0;
        //console.log(np);
        var remainingCount = np;
        //console.log(remainingCount);
        //remainingCount = remainingCount * 12;
        //console.log(remainingCount);

        var test = 0;


        do {
            // totalVariableNumberOfRepayments totalPossibleNumberOfRepayments
            // totalFixedNumberOfRepayments;
            if (LoopCount < fixedTermElementVal) {
                interestRateMonthAmort = fixedRateElementVal;
                mortgageRepaymentMonthAmort = fixedPmt;
                newPmtAfterFixed = null;
            } else {
                interestRateMonthAmort = mainInterestRateMonthAmort;
                if (newPmtAfterFixed == null && !isFixedSet) {
                    newPvAfterFixed = closingbalanceMonthAmort;
                    if (ir === 0) {
                        pmt = -(newPvAfterFixed + fv) / totalVariableNumberOfRepayments;
                    } else {
                        var pvif = Math.pow(1 + ir, totalVariableNumberOfRepayments);
                        pmt = -parseFloat(ir) * parseFloat(newPvAfterFixed) * parseFloat((pvif + fv)) / (pvif - 1);
                        if (type === 1) {
                            pmt /= (1 + ir);
                        }
                    }
                    pmt = Math.abs(pmt);
                    isFixedSet = true;
                    //c.set("v.MonthlyMortgageRepayment", pmt);
                }
                mortgageRepaymentMonthAmort = pmt;
            }

            interestChargedMonthAmort = openingBalanceMonthAmort * interestRateMonthAmort / 1200;
            capitalRepaidMonthAmort = mortgageRepaymentMonthAmort - interestChargedMonthAmort;
            // console.log('-->>interestRateMonthAmort='+interestRateMonthAmort);
            var prevOpeningBalanceMonthAmort = openingBalanceMonthAmort;

            chartArray1.push([Date.UTC(now.getUTCFullYear(), now.getUTCMonth() + i, now.getUTCDate()), totalMortgageRepaymentOverLoanPeriodValueLeft]);
            chartArray2.push([Date.UTC(now.getUTCFullYear(), now.getUTCMonth() + i, now.getUTCDate()), openingBalanceMonthAmort]);

            if (repaymentFrequencyCheckbox == 'Monthly') {
                interestChargedMonthAmort = openingBalanceMonthAmort * interestRateMonthAmort / 1200;
            }

            interestArray1.push(interestChargedMonthAmort);

            capitalRepaidMonthAmort = mortgageRepaymentMonthAmort - interestChargedMonthAmort;
            // console.log('capitalRepaidMonthAmort='+capitalRepaidMonthAmort+'--'
            // +'mortgageRepaymentMonthAmort='+mortgageRepaymentMonthAmort+'--'+'interestChargedMonthAmort='
            // +
            // interestChargedMonthAmort+'--'+'openingBalanceMonthAmort='+openingBalanceMonthAmort+'--'+'interestRateMonthAmort='+interestRateMonthAmort);
            totalMortgageRepaymentOverLoanPeriodValueLeft = totalMortgageRepaymentOverLoanPeriodValueLeft - mortgageRepaymentMonthAmort;

            closingbalanceMonthAmort = Math.round(prevOpeningBalanceMonthAmort - capitalRepaidMonthAmort) == 0 ? 0 : prevOpeningBalanceMonthAmort - capitalRepaidMonthAmort;
            openingBalanceMonthAmort = closingbalanceMonthAmort;

            var closingbalanceMonthAmortToInsert = closingbalanceMonthAmort;
            if (closingbalanceMonthAmortToInsert < 0) {
                closingbalanceMonthAmortToInsert = 0.00;
            }

            var capitalOutstandingPercentage = (closingbalanceMonthAmortToInsert / startOpeningBalance) * 100;
            if (capitalOutstandingPercentage < 0) {
                capitalOutstandingPercentage = 0.00;
            }
            var CurrentDate = new Date();
            CurrentDate.setMonth(CurrentDate.getMonth() + i);
            CurrentDate = convert(CurrentDate);

            function convert(str) {
                var date = new Date(str),
                    mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                    day = ("0" + date.getDate()).slice(-2);
                return [date.getFullYear(), mnth, day ].join("-");
            }


            /*
             * if(i<12){ test=test+interestChargedMonthAmort; }
             */
                monthAmortListToInsertHelper.push({
                    'sobjectType': 'servicecal__Amortization_Result__c',
                    'servicecal__Payment_Number__c': i + 1,
                    'servicecal__Opening_Balance__c': prevOpeningBalanceMonthAmort,
                    'servicecal__Payment__c': mortgageRepaymentMonthAmort,
                    'servicecal__Interest__c': interestChargedMonthAmort,
                    'servicecal__Closing_Balance__c': closingbalanceMonthAmortToInsert,
                    'servicecal__Principal__c': capitalRepaidMonthAmort,
                    'servicecal__Remaining__c': remainingCount - 1,
                    'servicecal__Payment_Date__c': CurrentDate
                });

            remainingCount--;
            i++;
            LoopCount++;
        } while (closingbalanceMonthAmort > 0);
        // console.log('-->>count i='+i);
        // console.log('-->>test i='+test);

        // //console.log('chartArray1='+JSON.stringify(chartArray1));
        // //console.log('chartArray2='+JSON.stringify(chartArray2));
        // //console.log('monthAmortListToInsertHelper='+JSON.stringify(monthAmortListToInsertHelper));
        // console.log(monthAmortListToInsertHelper[0]);
        c.set("v.monthAmortListToInsert", monthAmortListToInsertHelper);

        if (repaymentFrequencyCheckbox == 'Monthly') {
            c.set("v.monthAmortListToInsert", monthAmortListToInsertHelper);
            //console.log(c.get("v.monthAmortListToInsert"));
        }
        c.set('v.AmortizationTable',true);
        console.log('exit calculatePMT' );
        console.log(monthAmortListToInsertHelper);
        console.log('ITS'+c.get('v.monthAmortListToInsert'));
    },
    saveCalvalue_helper:function(c,e,h){
        try{
            console.log('opp ID--->'+c.get('v.recordIdMenu'));
            var calculatorValue = c.get('v.calculator');
            var amortizationDataCheck = c.get("v.monthAmortListToInsert");
            var calculatorObject ={};
            calculatorObject.sobjectType = 'servicecal__Non_Resident__c';
            calculatorObject.servicecal__New_Loan_Amount__c = calculatorValue.LoanAmmount;
            calculatorObject.servicecal__Intrest_Rate_on_new_Loan__c = calculatorValue.InterestRate;
            calculatorObject.servicecal__New_Loan_Term_Years__c = calculatorValue.LoanTerm;
            calculatorObject.servicecal__Opportunity__c = c.get('v.recordIdMenu');
            if(!$A.util.isUndefinedOrNull(calculatorValue) && !$A.util.isUndefinedOrNull(c.get('v.recordIdMenu'))){
             var action =  c.get("c.savecalculatorData_Apex");
                action.setParams({
                 "RTName": "Non Resident",
                 "calculatorRecord" : calculatorObject,
                 "AmortData": JSON.stringify(amortizationDataCheck),
                 "OppId": c.get('v.recordIdMenu'),
                });
                action.setCallback(this, function (response) {
                 if(response.getState() == "SUCCESS"){
                     var storedResponse = (response.getReturnValue());
                     //console.log(oppObj);
                     if(storedResponse !== null ){
                        console.log('storedResponse');
                        console.log(storedResponse);
                     }else {
                         //console.log("something misshappens");
                         c.set('v.ErrorMessage', storedResponse.status);
                         h.showErrorToast_Helper(c);
                     }
                 }else{
                     console.log("something misshappens");
                 }
                });
                $A.enqueueAction(action);
            }
        }catch(ex){
            console.log('Error');
            console.logex;
        }
    },

})