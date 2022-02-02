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
public with sharing class Validate {

    public static boolean isCNPJ(String CNPJ) {
  
      CNPJ = removeCaractEsp(CNPJ);
  
      if(!CNPJ.isNumeric())
        return false;
  
      // considera-se erro CNPJ's formados por uma sequencia de numeros iguais
      if(CNPJ.equals('00000000000000') || CNPJ.equals('11111111111111') ||
        CNPJ.equals('22222222222222') || CNPJ.equals('33333333333333') ||
        CNPJ.equals('44444444444444') || CNPJ.equals('55555555555555') ||
        CNPJ.equals('66666666666666') || CNPJ.equals('77777777777777') ||
        CNPJ.equals('88888888888888') || CNPJ.equals('99999999999999') ||
       (CNPJ.length() != 14))
        return false;
  
      Integer sm, i, r, num, peso, dig13, dig14;
      List<String> cnpjString = CNPJ.split('');
      sm = 0;
      peso = 2;
      for(i = 11; i >= 0; i--) {
        num = Integer.valueOf(cnpjString[i]);
        sm = sm +(num * peso);
        peso = peso + 1;
        if(peso == 10)
          peso = 2;
      }
  
      r = math.mod(sm, 11);
      if((r == 0) ||(r == 1))
        dig13 = 0;
      else dig13 = Integer.valueOf(11 - r);
  
      // Calculo do 2o. Digito Verificador
      sm = 0;
      peso = 2;
      for(i = 12; i >= 0; i--) {
        num = Integer.valueOf(cnpjString[i]);
        sm = sm +(num * peso);
        peso = peso + 1;
        if(peso == 10)
          peso = 2;
      }
  
      r = math.mod(sm, 11);
      if((r == 0) ||(r == 1))
        dig14 = 0;
      else dig14 = Integer.valueOf(11 - r);
  
      // Verifica se os dígitos calculados conferem com os dígitos informados.
      if(dig13 == Integer.valueOf(cnpjString[12]) && dig14 == Integer.valueOf(cnpjString[13]))
  
        return true;
      else return false;
    }
  
    public static String imprimeCNPJ(String CNPJ) {
  
      CNPJ = removeCaractEsp(CNPJ);
  
      return(CNPJ.substring(0, 2) + '.' + CNPJ.substring(2, 5) + '.' +
        CNPJ.substring(5, 8) + '/' + CNPJ.substring(8, 12) + '-' +
        CNPJ.substring(12, 14));
    }
  
    public static boolean isCPF(String CPF) {
        CPF = removeCaractEsp(CPF);
        
        if(!CPF.isNumeric())
        return false;
        
        CPF = CPF.replace('-', '');
        CPF = CPF.replace('.', '');
    
        if (
          CPF.equals('00000000000') ||
          CPF.equals('11111111111') ||
          CPF.equals('22222222222') ||
          CPF.equals('33333333333') ||
          CPF.equals('44444444444') ||
          CPF.equals('55555555555') ||
          CPF.equals('66666666666') ||
          CPF.equals('77777777777') ||
          CPF.equals('88888888888') ||
          CPF.equals('99999999999') ||
          (CPF.length() != 11)
        )
          return (false);
    
        Integer dig10, dig11, sm, i, r, num, peso;
    
        sm = 0;
        peso = 10;
        List<String> cpfString = cpf.split('');
        for (i = 0; i < 9; i++) {
          num = Integer.valueOf(cpfString[i]);
          sm = sm + (num * peso);
          peso = peso - 1;
        }
    
        r = 11 - (math.mod(sm, 11));
        if ((r == 10) || (r == 11))
          dig10 = 0;
        else
          dig10 = r;
    
        // Calculo do 2o. Digito Verificador
        sm = 0;
        peso = 11;
        for (i = 0; i < 10; i++) {
          num = Integer.valueOf(cpfString[i]);
          sm = sm + (num * peso);
          peso = peso - 1;
        }
    
        r = 11 - (math.mod(sm, 11));
        if ((r == 10) || (r == 11))
          dig11 = 0;
        else
          dig11 = r;
    
        // Verifica se os digitos calculados conferem com os digitos informados.
        if (
          dig10 == Integer.valueOf(cpfString[9]) &&
          dig11 == Integer.ValueOf(cpfString[10])
        )
          return true;
        else
          return false;
      }

      public static String imprimeCPF(String CPF) {
        return (CPF.substring(0, 3) +
        '.' +
        CPF.substring(3, 6) +
        '.' +
        CPF.substring(6, 9) +
        '-' +
        CPF.substring(9, 11));
      }
  
    public static boolean isPhone(String phone) {
      phone = removeCaractEsp(phone);

    if(!phone.isNumeric())
      return false;

    if(phone.equals('0000000000') || phone.equals('1111111111') ||
      phone.equals('2222222222') || phone.equals('3333333333') ||
      phone.equals('4444444444') || phone.equals('5555555555') ||
      phone.equals('6666666666') || phone.equals('7777777777') ||
      phone.equals('8888888888') || phone.equals('9999999999') ||
      phone.equals('00000000000') || phone.equals('11111111111') ||
      phone.equals('22222222222') || phone.equals('33333333333') ||
      phone.equals('44444444444') || phone.equals('55555555555') ||
      phone.equals('66666666666') || phone.equals('77777777777') ||
      phone.equals('88888888888') || phone.equals('99999999999') ||
      phone.length() < 10 || phone.length() > 11)
      return false;
    else return true;
    }
  
    public static String imprimePhone(String phone) {
  
      phone = removeCaractEsp(phone);
        if(phone.length() == 10) {
          return '(' + phone.substring(0, 2) + ') ' + phone.substring(2, 6) + '-' + phone.substring(6, 10);
        } else {
          return '(' + phone.substring(0, 2) + ') ' + phone.substring(2, 7) + '-' + phone.substring(7, 11);
        }
    }
    
    public static boolean isCEP(String CEP) {
    	CEP = removeCaractEsp(CEP);
  
    	if(CEP.isNumeric() && CEP.length()==8)
        	return true;
        else
            return false;
    }
  
    public static String CEP(String CEP) {
    	CEP = removeCaractEsp(CEP);
 
    	return CEP.substring(0,5) + '-' +CEP.substring(5,8);
    }
    public static boolean isInscricaoMunicipal(String InsM) {
    	InsM = removeCaractEsp(InsM);
  
    	if(InsM.isNumeric())
        	return true;
        else
            return false;
    }
  
    public static String InscricaoMunicipal(String InsM) {
        InsM = removeCaractEsp(InsM);
    	return InsM;
    }
    public static boolean isInscricaoEstadual(String InsE) {
    	InsE = removeCaractEsp(InsE);
  
    	if(InsE.isNumeric())
        	return true;
        else
            return false;
    }
  
    public static String InscricaoEstadual(String InsE) {
    	InsE = removeCaractEsp(InsE);
        return InsE;
    }
    public static boolean isImposto(String Imp) {
    	Imp = removeCaractEsp(Imp);
  
    	if(Imp.isNumeric())
        	return true;
        else
            return false;
    }
  
    public static String Imposto(String Imp) {
    	Imp = removeCaractEsp(Imp);
        return Imp;
    }
    public static String removeCaractEsp(string texto) {
      return texto.replace('.', '')
        .replace('-', '')
        .replace('/', '')
        .replace(' ', '')
        .replace('(', '')
        .replace(')', '');
    }
  
  }