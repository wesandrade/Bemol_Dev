@RestResource(urlMapping='/CartaoBemol__c/*')
global class EnvioDeCartaoService {

    
    @HttpPost
    global static List<CartaoBemol__c> doPost(List<CartaoBemol__c> CartoesBemol){
        Set<String> cpf = new Set<String>();
        for(CartaoBemol__c c : CartoesBemol){
            
                        if(c.CPF__c != '' && c.CPF__c != null){
                String CPFCNPJ = Validate.removeCaractEsp(c.CPF__c);
                if(CPFCNPJ.length()>11){
                    if (!Validate.isCNPJ (CPFCNPJ)){
                    	c.CPF__c.addError ('O CNPJ digitado é inválido.');
                    }else{
                    	c.CPF__c = Validate.imprimeCNPJ (CPFCNPJ);
                    }
                }else{
                    if (Validate.isCPF (CPFCNPJ)){
                        c.CPF__c = Validate.imprimeCPF(CPFCNPJ);
                    
                	}else{
                    	c.CPF__c.addError ('O CPF digitado é inválido.');
                	}
                }
            }
            cpf.add(c.CPF__c);
        }
        Map<String,Account> mAccountCpf_Id = new Map<String,Account>();
        
        List<Account> accs = [SELECT ID, CPFCNPJ__c FROM ACCOUNT WHERE CPFCNPJ__c IN:cpf ];

        if(accs.size()>0){
            for(Account a : accs){
               mAccountCpf_Id.put(a.CPFCNPJ__c,a);
            }
        }
        system.debug(mAccountCpf_Id);
        for(CartaoBemol__c c : CartoesBemol){
            if(mAccountCpf_Id.get(c.CPF__C) != null){
                c.Account__c = mAccountCpf_Id.get(c.CPF__C).Id;
                if(string.isNotBlank( c.Codigo_De_Rastreio__c) && c.Status__c == 'Em trânsito'){
                    c.Tipo_de_envio__c = 'Correios';
                }else if(!string.isNotBlank( c.Codigo_De_Rastreio__c) && c.Status__c == 'Em trânsito'){
                    c.Tipo_de_envio__c = 'Envio Bemol';
                }
                 if(c.Status_do_envio__c == 'Cancelado' || c.Status_do_envio__c == 'Extraviado'){
                    c.Status_do_cart_o__c = 'Bloqueado';
                 }
                if(c.OptouPeloNonamed__c){
                    c.Status__c = 'Entregue';
                }
            }           
        }        
        upsert CartoesBemol idCartao__c;
                       
        return CartoesBemol;
    }
   
}