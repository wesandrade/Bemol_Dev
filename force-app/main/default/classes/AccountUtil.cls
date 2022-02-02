/**
 * @File Name          : 
 * @Description        :
 * @Author             : bianca.andrade@moldsoft.com.br
 * @Group              :
 * @Last Modified By   : bianca.andrade@moldsoft.com.br
 * @Last Modified On   : 07/01/2021
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    07/01/2021  bianca.andrade@moldsoft.com.br         Initial Version
**/
public class AccountUtil {
    public static void validateMask(List<Account> newAccounts){
        for(Account acc : newAccounts){
            if ((acc.Phone != null && acc.Phone != '')){
                if (Validate.isPhone (acc.Phone)){
                    acc.Phone = Validate.imprimePhone (acc.Phone);
                }else{
                    acc.Phone.addError ('Neste campo é necessário DDD + Nº telefone (8 ou 9 dígitos).');
                }
            }
            
            if(acc.CPFCNPJ__c != '' && acc.CPFCNPJ__c != null){
                String CPFCNPJ = Validate.removeCaractEsp(acc.CPFCNPJ__c);
                if(CPFCNPJ.length()>11){
                    if (!Validate.isCNPJ (CPFCNPJ)){
                    	acc.CPFCNPJ__c.addError ('O CNPJ digitado é inválido.');
                    }else{
                    	acc.CPFCNPJ__c = Validate.imprimeCNPJ (CPFCNPJ);
                    }
                }else{
                    if (Validate.isCPF (CPFCNPJ)){
                        acc.CPFCNPJ__c = Validate.imprimeCPF(CPFCNPJ);
                    
                	}else{
                    	acc.CPFCNPJ__c.addError ('O CPF digitado é inválido.');
                	}
                }
            }
            
            if ((acc.CEP__c != null && acc.CEP__c != '')) {
                if (!Validate.isCEP (acc.CEP__c))
                    acc.CEP__c.addError ('Neste campo é necessário 8 dígitos.');
                else
                    acc.CEP__c = Validate.CEP(acc.CEP__c);
            }
            if ((acc.InscricaoMunicipal__c != null && acc.InscricaoMunicipal__c != '')) {
                if (!Validate.isInscricaoMunicipal (acc.InscricaoMunicipal__c))
                    acc.InscricaoMunicipal__c.addError ('Este campo só é permitido números');
                else
                    acc.InscricaoMunicipal__c = Validate.InscricaoMunicipal(acc.InscricaoMunicipal__c);
            }
            if ((acc.InscricaoEstadual__c != null && acc.InscricaoEstadual__c != '')) {
                if (!Validate.isInscricaoEstadual (acc.InscricaoEstadual__c))
                    acc.InscricaoEstadual__c.addError ('Este campo só é permitido números');
                else
                    acc.InscricaoEstadual__c = Validate.InscricaoEstadual(acc.InscricaoEstadual__c);
            }
            if ((acc.Imposto__c != null && acc.Imposto__c != '')) {
                if (!Validate.isImposto (acc.Imposto__c))
                    acc.Imposto__c.addError ('Este campo só é permitido números');
                else
                    acc.Imposto__c = Validate.Imposto(acc.Imposto__c);
            }
        }
    }
    public static void createRelatedContact(List<Account> newAccounts){
        List<Contact> cttList = new List<Contact>();
        for(Account acct : newAccounts){
            Contact ctt = new Contact();
            List<String> nome = acct.Name.split(' ');
            if(nome.size()>1){
                ctt.FirstName = nome.get(0);
                ctt.LastName = nome.get(1);
            }else{
                ctt.LastName = nome.get(0);
            }
            ctt.Email = acct.Email__c;
            ctt.AccountId = acct.Id;
            cttList.add(ctt);
        }
        Database.SaveResult[] results = Database.insert(cttList, false);
    }
}