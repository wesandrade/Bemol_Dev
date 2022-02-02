@isTest
global class EnvioDeCartaoService_Test {
	private static Integer mockedStatusCode;
    private static String mockedResponseBody;
   
    @isTest
    public static void testPost(){
    
        Account acc = new Account(Name='Teste ',Phone='83970094793',
                                  Email__c='test@bemol.com.br',
                                  CPFCNPJ__c='41298815070',StatusConta__c='online',Type='Cliente Pessoa física',
                                  Logradouro__c='Parque',CEP__c='58091-250',Estado__c='PB',Bairro__c='Alto do Mateus',Cidade__c='João Pessoa');
        insert acc;
        
        CartaoBemol__c c = new CartaoBemol__c();
        
         c.IdCartao__c= '123456789cartao';
         c.CPF__c= '412.988.150-70';
         c.Status__c= 'Em Trânsito';
         c.Codigo_De_Rastreio__c= '1234123';
         c.DataSolicitacaoCartao__c= system.today();
        
        List<CartaoBemol__c> CartoesBemol = new List<CartaoBemol__c>();
        CartoesBemol.add(c);
        
        List<CartaoBemol__c> testList = EnvioDeCartaoService.doPost(CartoesBemol);
        
        system.assert(testList.size() > 0);
    }
    
     
}