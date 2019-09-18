public class AdditionalLoanRepayment {
	@AuraEnabled
	public static String savecalculatorData_Apex(String RTName,servicecal__Non_Resident__c calculatorRecord,String AmortData,String SCList) {
		try{
			if(calculatorRecord !=null){
				upsert calculatorRecord;
				if(calculatorRecord.Id !=null){
					if(AmortData != null){
						List<servicecal__Amortization_Result__c> amortizationResultData = new list<servicecal__Amortization_Result__c>();
						amortizationResultData = (list<servicecal__Amortization_Result__c>) JSON.deserialize(AmortData, list<servicecal__Amortization_Result__c>.class);
						
						if(amortizationResultData.size() > 0){
							list<servicecal__Amortization_Result__c> CheckAmortizationOldResultsData = new list<servicecal__Amortization_Result__c>();
							CheckAmortizationOldResultsData=[select id from servicecal__Amortization_Result__c where servicecal__Serviceability_Calculator__c =: calculatorRecord.id];
							
							if(CheckAmortizationOldResultsData.size() > 0){
								delete CheckAmortizationOldResultsData;
							}
							Integer i = 1;
							for (servicecal__Amortization_Result__c amortLoop : amortizationResultData) {
								amortLoop.servicecal__Serviceability_Calculator__c = calculatorRecord.Id;
								if(calculatorRecord.Name != null){
									amortLoop.Name = calculatorRecord.Name + ' - ' + i;
								}else {
									amortLoop.Name = 'Amortization - ' + i;
								}
								i++;
							}
							if(amortizationResultData.size() > 0){
								insert amortizationResultData;
							}
						}
					}
					return calculatorRecord.Id;
				}
			}
		}catch (Exception ex){
			system.debug('>>>>Error--->'+ex);
		}

		return null;
	}
}